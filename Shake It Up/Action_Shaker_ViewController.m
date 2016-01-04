//
//  Action_Shaker_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Action_Shaker_ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <BAFLuidView/BAFLuidView.h>
#import "NavigationController.h"
#import "BodyMixCenter_ViewController.h"
#import "MixtureData.h"

@interface Action_Shaker_ViewController () <MixCenterDelegate, UICollisionBehaviorDelegate>

#pragma story objects
@property (strong, nonatomic) MixtureData *mixtureData;

@property (weak, nonatomic) IBOutlet UIImageView *colorObject;
@property (weak, nonatomic) IBOutlet UIImageView *textureObject;
@property (weak, nonatomic) IBOutlet UIImageView *ingredientObject;
@property (weak, nonatomic) IBOutlet UIImageView *soundObject;
@property (weak, nonatomic) IBOutlet UIView *waterView;
@property (weak, nonatomic) IBOutlet UIView *bottomWaterView;
@property (strong, nonatomic) BAFluidView *fluid;
@property (strong, nonatomic) NSMutableArray *dropArray;
@property (weak, nonatomic) IBOutlet UIView *collisionView;

// Gravity
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehaviour;
@property (strong, nonatomic) UICollisionBehavior *collision;

// Overlay
@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (weak, nonatomic) IBOutlet UILabel *labelOverlay;
@property (weak, nonatomic) IBOutlet UILabel *botLabelOverlay;
@property (weak, nonatomic) IBOutlet UIImageView *icoOverlay;
@property (weak, nonatomic) IBOutlet UIImageView *icoTapOverlay;

@end

@implementation Action_Shaker_ViewController{
    UIDynamicAnimator *animator;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = self.navigationController;
    [navigation hideMenu];
    
    // Remove previous View Controller
    NSInteger count = [self.navigationController.viewControllers count];
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex: count - 2];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    
    // Get Img Elements
    [MixtureData sharedMixtureData].emotionImageName = [[MixtureData sharedMixtureData].emotionImageName stringByReplacingOccurrencesOfString:@"%d" withString:@"0"];
    [MixtureData sharedMixtureData].textureImageName = [[MixtureData sharedMixtureData].textureImageName stringByReplacingOccurrencesOfString:@"%d" withString:@"0"];
    [MixtureData sharedMixtureData].ingredientImageName = [[MixtureData sharedMixtureData].ingredientImageName stringByReplacingOccurrencesOfString:@"%d" withString:@"0"];
    [MixtureData sharedMixtureData].soundImageName = [[MixtureData sharedMixtureData].soundImageName stringByReplacingOccurrencesOfString:@"%d" withString:@"0"];

    
    [self.colorObject setImage:[UIImage imageNamed: [MixtureData sharedMixtureData].emotionImageName]];
    [self.textureObject setImage:[UIImage imageNamed: [MixtureData sharedMixtureData].textureImageName]];
    [self.ingredientObject setImage:[UIImage imageNamed: [MixtureData sharedMixtureData].ingredientImageName]];
    [self.soundObject setImage:[UIImage imageNamed: [MixtureData sharedMixtureData].soundImageName]];
    
#pragma Wave Init
    screenBound = [[UIScreen mainScreen] bounds];
    
    self.fluid = [[BAFluidView alloc] initWithFrame:CGRectMake(0, 0, screenBound.size.width, self.waterView.frame.size.height) startElevation:@0.5];
    // Set color
    self.fluid.fillColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    self.fluid.strokeColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    [self.waterView addSubview: self.fluid];
    [self.fluid startAnimation];
    self.bottomWaterView.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    [self.bottomWaterView setFrame:CGRectMake(0, screenBound.size.height - 12, screenBound.size.width, screenBound.size.height)];

#pragma settings
    // SETTINGS
    animDuration = 2;
    gravityLoopDuration = 0.06;
    nbShakeRequired = 10;
    coefAmpStart = 40;
    coefAmpShake = 500;
    nbDrops = 150;
    
#pragma init overlay
    self.overlay.backgroundColor = [UIColor colorWithRed:0.06 green:0.01 blue:0.26 alpha:0.9];
    
    UITapGestureRecognizer *tapOverlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayAction:)];
    [self.overlay addGestureRecognizer:tapOverlay];
    
    // Anim Ico Overlay
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 2;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.icoOverlay.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
#pragma Init Shaker

    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    isShake = 0;
    shakeValidation = 0;
    loopAnim = 0;
    loopGravity = 0;
    countAnim = 0;
    waterHigh = 0;
    overlayActive = 0;
    shakeEnding = 0;
    
    // Init motion
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        [self outputAccelertionData:accelerometerData.acceleration];
        currentMaxRotX = accelerometerData.acceleration.x;
        currentMaxRotY = accelerometerData.acceleration.y;
        
         if(error) {
             NSLog(@"%@", error);
         }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        [self outputRotationData:gyroData.rotationRate];
    }];
    
#pragma Init Drops

    self.gravityBehavior = [[UIGravityBehavior alloc] init];
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] init];
    self.collision = [[UICollisionBehavior alloc] init];
    
    self.itemBehaviour.elasticity = 0.8f;
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.collision addItem: self.collisionView];
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    
    // Add drops
    for (int m = 0; m < nbDrops; m ++) {
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * m / 100);
        dispatch_after(delay, dispatch_get_main_queue(), ^(void){
            int randomY = - floor(arc4random() % (180 - 100));
            int randomX = 120 + floor(arc4random() % (160 - 120));
            int randomRadius = 10 + floor(arc4random() % (20 - 10));
            
            UIView *dropSquare = [[UIView alloc] initWithFrame: CGRectMake(randomX, randomY
                                                                           , randomRadius, randomRadius)];
            dropSquare.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
            [dropSquare.layer setCornerRadius: randomRadius/2];

            [self.view addSubview: dropSquare];
        
            [self.itemBehaviour addItem:dropSquare];
            [self.gravityBehavior addItem:dropSquare];
            
            if (m % 10 == 0) {
                [self dropComing];
            }
        });
    }
    
    CGVector direction = CGVectorMake(-0.2, 1);
    self.gravityBehavior.gravityDirection = direction;
    
    [animator addBehavior:self.itemBehaviour];
    [animator addBehavior:self.gravityBehavior];
    [animator addBehavior:self.collision];
    
    
#pragma Init Array Objects
    self.shakeObjects = [[NSMutableArray alloc] init];
    [self.shakeObjects addObject: self.colorObject];
    [self.shakeObjects addObject: self.textureObject];
    [self.shakeObjects addObject: self.ingredientObject];
    [self.shakeObjects addObject: self.soundObject];
    
    for (int k = 0; k < [self.shakeObjects count]; k ++) {
        [[self.shakeObjects objectAtIndex: (NSInteger) k] setAlpha: 0.5];
    }
    
#pragma Get Good Product

    NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/product/discover/%@/%@/%@/%@", [MixtureData sharedMixtureData].emotion, [MixtureData sharedMixtureData].ingredient, [MixtureData sharedMixtureData].texture, [MixtureData sharedMixtureData].sound];
//    NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/product/discover/%@/%@/%@/%@", @"emotion2", @"ingredient2", @"texture2", @"sound2"];
    
    NSLog(@"%@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    NSURLSession *session = [NSURLSession sharedSession];
    session.configuration.timeoutIntervalForResource = 30;
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", error);
        }
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
        self.product = JSON;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.product forKey:@"actualProduct"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"%@", [[defaults objectForKey:@"actualProduct"] objectForKey: @"_id"]);
    }] resume];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

#pragma drops coming

- (void) dropComing {
    waterHigh ++;

    if (waterHigh < 15 && waterHigh > 9) {
        // Water
        [UIView animateWithDuration: 0.6
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             CGRect frameTop = self.waterView.frame;
                             CGRect frameBot = self.bottomWaterView.frame;
                             
                             frameTop.origin.y = self.waterView.frame.origin.y - waterHigh * 8;
                             frameBot.origin.y = self.bottomWaterView.frame.origin.y - waterHigh * 8;
                             
                             self.waterView.frame = frameTop;
                             self.bottomWaterView.frame = frameBot;
                         }
                         completion:^(BOOL finished){ }
         ];

    }
    
    if (waterHigh == 15) {
        [self objectsComing];
    }
}

#pragma objects coming

- (void) objectsComing {
    for (int j = 0; j < [self.shakeObjects count]; j ++) {
        POPBasicAnimation *objectsAreComing = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        int posY = 200 + arc4random() % (200 - 100);
        
        objectsAreComing.beginTime = CACurrentMediaTime() + 0.7;
        objectsAreComing.toValue = @(posY);
        objectsAreComing.duration = 1.5;
        objectsAreComing.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.165 :0.84 :0.44 :1];
        [[self.shakeObjects objectAtIndex: (NSInteger) j] pop_addAnimation:objectsAreComing forKey:@"comingLiquid"];
        
        objectsAreComing.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            countAnim ++;
            
            if (countAnim == [self.shakeObjects count]) {
                loopAnim = 1;
                [self moveLoopAnimation: nil];
            }
            overlayActive = 1;
            self.overlay.alpha = 1;
        };
    }
    
    // Loop animation
    NSTimer *timerStart = [NSTimer timerWithTimeInterval: animDuration target:self selector:@selector(moveLoopAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timerStart forMode:NSDefaultRunLoopMode];
 
    NSTimer *timer = [NSTimer timerWithTimeInterval: gravityLoopDuration target:self selector:@selector(moveLoopGravity:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

#pragma move Loop
- (void) moveLoopAnimation:(NSTimer *) timer {
    if (loopAnim == 1) {
        int coefAmp = coefAmpStart;
        
        for (int j = 0; j < [self.shakeObjects count]; j ++) {
            [self.gravityBehavior removeItem: [self.shakeObjects objectAtIndex: (NSInteger) j]];
            
            int amplitudeX;
            int amplitudeY;
            
            amplitudeX = -coefAmp + arc4random() % (coefAmp + coefAmp);
            amplitudeY = -coefAmp + arc4random() % (coefAmp + coefAmp);
 
            [UIView animateWithDuration: animDuration * 2
                                  delay: 0.0
                options: UIViewAnimationOptionCurveLinear
                animations:^{
                    CGRect frame = [[self.shakeObjects objectAtIndex: (NSInteger) j] frame];
                    //Check if target position is ouf of view
                    // In X
                    if ([[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.x + amplitudeX < 25) {
                        frame.origin.x = 25;
                    } else if ([[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.x + amplitudeX > screenBound.size.width - 50) {
                        frame.origin.x = screenBound.size.width - 50;
                    } else {
                        frame.origin.x = [[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.x + amplitudeX;
                    }
                    
                    // In Y
                    if ([[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.y + amplitudeY < 120) {
                        frame.origin.y = 120;
                    } else if ([[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.y + amplitudeY > screenBound.size.height - 50) {
                        frame.origin.y = screenBound.size.height - 50;
                    } else {
                        frame.origin.y = [[self.shakeObjects objectAtIndex: (NSInteger) j] frame].origin.y + amplitudeY;
                    }
                    

                    [[self.shakeObjects objectAtIndex: (NSInteger) j] setFrame: frame];
                }
                completion:^(BOOL finished){ }
            ];
        }
    }
}

#pragma move Gravity Loop

- (void) moveLoopGravity:(NSTimer *) timer {
    if (loopGravity == 1 && shakeValidation <= nbShakeRequired && isShake == 0) {
        float coefAmp = 0.1;

        float x = -coefAmp + ((float)arc4random() / UINT32_MAX) * (coefAmp + coefAmp);
        float y = -coefAmp + ((float)arc4random() / UINT32_MAX) * (coefAmp + coefAmp);
        CGVector direction = CGVectorMake(x, y);
        self.gravityBehavior.gravityDirection = direction;
    }
}

#pragma move Shake
- (void) moveShake: (double) xAverage withYAverage:(double) yAverage {
    loopAnim = 0;
    
    if (isShake == 1) {
        shakeValidation ++;
    }
    
    if (shakeValidation >= nbShakeRequired) {
        isShake = 0;
        shakeEnding = 1;

        self.labelOverlay.text = @"Ta préparation est prête !";
        self.botLabelOverlay.text = @"Tap pour continuer";
        
        self.icoOverlay.hidden = true;
        self.icoTapOverlay.hidden = false;
        
        NSMutableArray* imgArray = [[NSMutableArray alloc] initWithCapacity: 25];
        for(int i = 0; i < 25; i++) {
            UIImage* image = [UIImage imageNamed:[NSString stringWithFormat: @"tap_%d", i]];
            [imgArray addObject:image];
        }
        
        self.icoTapOverlay.animationImages = imgArray;
        self.icoTapOverlay.animationDuration = 1.0f;
        self.icoTapOverlay.animationRepeatCount = 0;
        [self.icoTapOverlay startAnimating];
        
        [UIView animateWithDuration: 1.0 animations:^(void) {
            self.overlay.alpha = 1;
        }];
        overlayActive = 1;
    } else {
        for (int k = 0; k < [self.shakeObjects count]; k ++) {
            [self.itemBehaviour addItem:[self.shakeObjects objectAtIndex: (NSInteger) k]];
            [self.gravityBehavior addItem:[self.shakeObjects objectAtIndex: (NSInteger) k]];
            [self.collision addItem:[self.shakeObjects objectAtIndex: (NSInteger) k]];
        }

        if (xAverage != 0) {
            CGVector direction = CGVectorMake(xAverage, 0);
            self.gravityBehavior.gravityDirection = direction;
        }
        
        [animator addBehavior:self.itemBehaviour];
        [animator addBehavior:self.gravityBehavior];
        [animator addBehavior:self.collision];
    }
}

#pragma shake

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Shake Start");
        // Vibrate
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        
        isShake = 1;
        loopGravity = 0;
    }
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Shake End");
        
        isShake = 0;
        
        if (shakeValidation < nbShakeRequired) {
            shakeValidation = 0;
            animDuration = 2;
            [UIView animateWithDuration: 1.0 animations:^(void) {
                self.overlay.alpha = 1;
            }];
            overlayActive = 1;
            loopGravity = 1;
            
            self.labelOverlay.text = @"Tu n’as pas assez de force ?";
            self.botLabelOverlay.text = @"Secoue ton mobile !";
        }
        
        CGVector direction = CGVectorMake(0, 0);
        self.gravityBehavior.gravityDirection = direction;
    }
}

- (void) outputAccelertionData:(CMAcceleration)acceleration {}

- (void) outputRotationData:(CMRotationRate)rotation {
    if (isShake == 1) {
        [self moveShake: currentMaxRotX withYAverage: currentMaxRotY];
    }
}

- (void) overlayAction:(UITapGestureRecognizer *)recognizer {
    if (shakeEnding == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BodyPartMixCenter" bundle:nil];
        BodyMixCenter_ViewController *body = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:body animated:YES];
    } else {
        if (overlayActive == 1) {
            [UIView animateWithDuration: 1.0 animations:^(void) {
                self.overlay.alpha = 0;
            }];
        
            overlayActive = 0;
        }
    }
}


@end
