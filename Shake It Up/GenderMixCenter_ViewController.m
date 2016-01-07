//
//  GenderMixCenter_ViewController.m
//  Shake It Up
//
//  Created by Jeremie drazic on 21/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "GenderMixCenter_ViewController.h"
#import "MixCenter_ContentViewController.h"
#import "NavigationController.h"

@interface GenderMixCenter_ViewController ()
{
    BOOL dragging;
    BOOL dropZoneFull;
    BOOL dropped;
}
@end

@implementation GenderMixCenter_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.app = [AppSettings sharedAppSettings];
    [self buildInterface];
    
    NavigationController *navigation = (NavigationController *)self.navigationController;
    [navigation hideMenu];
    
    // Remove previous View Controller
    NSInteger count = [self.navigationController.viewControllers count];
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex: count - 2];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

#pragma mark - Interface

- (void) buildInterface {
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(37.0, 113.0, 245.0, 37.5)];
    self.descriptionLabel.font = self.app.font37Bold;
    self.descriptionLabel.textAlignment = NSTextAlignmentRight;
    [self.descriptionLabel setAlpha:0.0];
    [self.view addSubview:self.descriptionLabel];
    
    self.genderLabel.font = self.app.font20;
    self.genderLabel.textColor = self.app.purple;
    
    [self drawDragViews];
    [self drawDropZone];
    [self drawProgressTimer];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //overlay1
    self.overlay1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.overlay1.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:3.0 / 255.0 blue:66.0 / 255.0 alpha:0.9];
    self.overlay1.alpha = 0.0;
    self.overlay1Line1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 75, 230, 20)];
    self.overlay1Line2 = [[UILabel alloc] initWithFrame:CGRectMake(36, 95, 200, 20)];
    self.overlay1Line1.text = @"Touche pour savoir à quoi";
    self.overlay1Line2.text = @"correspond l'illustration";
    self.overlay1Line1.textColor = self.app.white;
    self.overlay1Line2.textColor = self.app.white;
    self.overlay1Line1.font = self.app.font20;
    self.overlay1Line2.font = self.app.font20;
    [self.overlay1 addSubview:self.overlay1Line1];
    [self.overlay1 addSubview:self.overlay1Line2];
    [self.view addSubview:self.overlay1];
    
    //overlay2
    self.overlay2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.overlay2.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:3.0 / 255.0 blue:66.0 / 255.0 alpha:0.9];
    self.overlay2.alpha = 0.0;
    self.overlay2Line1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 75, 230, 20)];
    self.overlay2Line1.text = @"Glisse ton choix au milieu";
    self.overlay2Line1.textColor = self.app.white;
    self.overlay2Line1.font = self.app.font20;
    [self.overlay2 addSubview:self.overlay2Line1];
    
    //overlay3
    self.overlay3 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.overlay3.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:3.0 / 255.0 blue:66.0 / 255.0 alpha:0.9];
    self.overlay3.alpha = 0.0;
    self.overlay3Line1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 75, 230, 20)];
    self.overlay3Line2 = [[UILabel alloc] initWithFrame:CGRectMake(36, 95, 250, 20)];
    self.overlay3Line1.text = @"Un temps limité t’es donné";
    self.overlay3Line2.text = @"si tu veux changer ton choix";
    self.overlay3Line1.textColor = self.app.white;
    self.overlay3Line2.textColor = self.app.white;
    self.overlay3Line1.font = self.app.font20;
    self.overlay3Line2.font = self.app.font20;
    [self.overlay3 addSubview:self.overlay3Line1];
    [self.overlay3 addSubview:self.overlay3Line2];
    
    self.dropLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(127, 338, 100.0, 20.0)];
    self.dropLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(127, 338, 100.0, 20.0)];
    self.dropLabel1.text = [@"Déposer ici" uppercaseString];
    self.dropLabel2.text = [@"Déposer ici" uppercaseString];
    self.dropLabel1.font = self.app.font12;
    self.dropLabel2.font = self.app.font12;
    self.dropLabel1.textColor = self.app.white;
    self.dropLabel2.textColor = self.app.white;
    [self.overlay1 addSubview:self.dropLabel1];
    [self.overlay2 addSubview:self.dropLabel2];
    
    self.bottomLeftRoundContainer1 = [[UIImageView alloc] initWithFrame:self.bottomLeftItem.frame];
    self.bottomLeftRound1 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomLeftRoundContainer1.image = self.bottomLeftRound1;
    [self.overlay1 addSubview:self.bottomLeftRoundContainer1];
    
    self.bottomRightRoundContainer1 = [[UIImageView alloc] initWithFrame:self.bottomRightItem.frame];
    self.bottomRightRound1 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomRightRoundContainer1.image = self.bottomRightRound1;
    [self.overlay1 addSubview:self.bottomRightRoundContainer1];
    
    self.centerRoundContainer1 = [[UIImageView alloc] initWithFrame:self.progressTimer.frame];
    self.centerRound1 = [UIImage imageNamed:@"round_center.png"];
    self.centerRoundContainer1.image = self.centerRound1;
    [self.overlay1 addSubview:self.centerRoundContainer1];
    
    self.tapIconContainer = [[UIImageView alloc] initWithFrame:CGRectMake(60.0, 500.0, 34.0, 45.0)];
    self.tapIcon = [UIImage imageNamed:@"tap_ico.png"];
    self.tapIconContainer.image = self.tapIcon;
    [self.overlay1 addSubview:self.tapIconContainer];
    
    self.bottomLeftRoundContainer2 = [[UIImageView alloc] initWithFrame:self.bottomLeftItem.frame];
    self.bottomLeftRound2 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomLeftRoundContainer2.image = self.bottomLeftRound2;
    [self.overlay2 addSubview:self.bottomLeftRoundContainer2];
    
    self.bottomRightRoundContainer2 = [[UIImageView alloc] initWithFrame:self.bottomRightItem.frame];
    self.bottomRightRound2 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomRightRoundContainer2.image = self.bottomRightRound2;
    [self.overlay2 addSubview:self.bottomRightRoundContainer2];
    
    self.centerRoundContainer2 = [[UIImageView alloc] initWithFrame:self.progressTimer.frame];
    self.centerRound2 = [UIImage imageNamed:@"round_center.png"];
    self.centerRoundContainer2.image = self.centerRound2;
    [self.overlay2 addSubview:self.centerRoundContainer2];
    
    self.bottomLeftRoundContainer3 = [[UIImageView alloc] initWithFrame:self.bottomLeftItem.frame];
    self.bottomLeftRound3 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomLeftRoundContainer3.image = self.bottomLeftRound3;
    [self.overlay3 addSubview:self.bottomLeftRoundContainer3];
    
    self.bottomRightRoundContainer3 = [[UIImageView alloc] initWithFrame:self.bottomRightItem.frame];
    self.bottomRightRound3 = [UIImage imageNamed:@"round_left_bottom.png"];
    self.bottomRightRoundContainer3.image = self.bottomRightRound3;
    [self.overlay3 addSubview:self.bottomRightRoundContainer3];
    
    self.centerTimerContainer3 = [[UIImageView alloc] initWithFrame:self.progressTimer.frame];
    self.centerTimer3 = [UIImage imageNamed:@"round_center_timer.png"];
    self.centerTimerContainer3.image = self.centerTimer3;
    [self.overlay3 addSubview:self.centerTimerContainer3];
    
    self.dragIconContainer = [[UIImageView alloc] initWithFrame:CGRectMake(60.0, 500.0, 50.0, 37.0)];
    self.dragIcon = [UIImage imageNamed:@"icon_dragdrop.png"];
    self.dragIconContainer.image = self.dragIcon;
    [self.overlay2 addSubview:self.dragIconContainer];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        self.overlay1.alpha = 1.0;
    });
    
    UITapGestureRecognizer *tapOverlay1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlay1Action:)];
    [self.overlay1 addGestureRecognizer:tapOverlay1];
    
    UITapGestureRecognizer *tapOverlay2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlay2Action:)];
    [self.overlay2 addGestureRecognizer:tapOverlay2];
    
    UITapGestureRecognizer *tapOverlay3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlay3Action:)];
    [self.overlay3 addGestureRecognizer:tapOverlay3];
}

- (void) overlay1Action:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration: 1.0 animations:^(void) {
        self.overlay1.alpha = 0;
        [self.overlay1 removeFromSuperview];
    }];
}

- (void) overlay2Action:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration: 1.0 animations:^(void) {
        self.overlay2.alpha = 0;
        [self.overlay2 removeFromSuperview];
    }];
}

- (void) overlay3Action:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration: 1.0 animations:^(void) {
        self.overlay3.alpha = 0;
        [self.overlay3 removeFromSuperview];
        [self startTimer];
    }];
}

- (void) drawDragViews {
    
    UIColor *color1 = [UIColor colorWithRed:91.0 / 255.0 green:45.0 / 255.0 blue:148.0 / 255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:253.0 / 255.0 green:13.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    //DragView 1
    self.bottomRightItem = [[DragView alloc] initWithFrame:CGRectMake(227.0, 455.0, 70.0, 70.0) andNbImages:25 andPath:@"femme" andColor:color1];
    self.bottomRightItem.tag = 1;
    self.bottomRightItem.value = @"une Femme";
    [self.view addSubview:self.bottomRightItem];
    
    //DragView 2
    self.bottomLeftItem = [[DragView alloc] initWithFrame:CGRectMake(26.0, 455.0, 70.0, 70.0) andNbImages:25 andPath:@"homme" andColor:color2];
    self.bottomLeftItem.tag = 2;
    self.bottomLeftItem.value = @"un Homme";
    [self.view addSubview:self.bottomLeftItem];
}

- (void) drawDropZone {
    
    self.dropZone = [[DropView alloc] initWithFrame:CGRectMake(72.5, 258.0, 175.0, 175.0)];
    self.dropZone.backgroundColor = self.app.lightGrey;
    [self.view addSubview:self.dropZone];
    [self.view sendSubviewToBack:self.dropZone];
}

- (void) drawProgressTimer {
    
    CGRect frame = self.dropZone.frame;
    frame = CGRectInset(frame, -20, -20);
    self.progressTimer = [[CircularLoaderView alloc] initWithFrame:frame];
    [self.view addSubview:self.progressTimer];
    [self.view sendSubviewToBack:self.progressTimer];
    [self.progressTimer setNeedsDisplay];
}

#pragma mark - Drag & Drop

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.draggedItem = (DragView *) touch.view;
    
    //if object is a dragView and if there is only one touch
    if ([self.draggedItem isMemberOfClass:[DragView class]] && [touches count] == 1) {
        dragging = YES;
        
        self.nbTouches++;
        if (self.nbTouches == 1) {
            [self.view addSubview:self.overlay2];
            self.overlay2.alpha = 1.0;
        }
        
        self.descriptionLabel.text = self.draggedItem.value;
        self.descriptionLabel.textColor = self.draggedItem.colorValue;
        [self.descriptionLabel setAlpha:1.0];
        
        POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        shake.fromValue = @(140);
        shake.toValue = @(150);
        shake.springBounciness = 20;
        shake.velocity = @(10);
        [self.descriptionLabel.layer pop_addAnimation:shake forKey:@"descriptionLabelAnimation"];
        
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.fromValue = @(0.0);
        opacityAnimation.toValue = @(1.0);
        [self.descriptionLabel.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
        
    } else {
        dragging = NO;
    }
    
    if (dragging) {
        //if moved in drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            //anim scale
            [self.draggedItem pop_removeAllAnimations];
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
            scaleAnimation.springBounciness = 20.f;
            scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
            scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                //if scale not properly done
                if (self.draggedItem.transform.a != 1.0) {
                    self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                }
            };
            [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrag"];
            
            //put center under mouse pointer
            POPSpringAnimation *placeUnderPointerAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            placeUnderPointerAnimation.fromValue = [NSValue valueWithCGPoint:self.dropZone.center];
            placeUnderPointerAnimation.toValue = [NSValue valueWithCGPoint:touch.view.center];
            [self.draggedItem pop_addAnimation:placeUnderPointerAnimation forKey:@"placeUnderPointer"];
        }
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    // if touch object is a dragView and if dragging enabled
    if (dragging) {
        
        dropped = NO;
        CGPoint p = [touch locationInView:self.view];
        self.draggedItem.center = p;
        
        // if dragged in the drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            if (!dropZoneFull) {
                NSLog(@"drop zone was empty");
                
                //drop zone is full
                dropZoneFull = YES;
                
                //change droped item properties
                self.droppedItem = self.draggedItem;
                self.droppedItem.active = YES;
                
            } else if(dropZoneFull && self.draggedItem.tag != self.droppedItem.tag) {
                NSLog(@"drop zone was occupied and dropped item wasn't moved");
                
                // reposition current Active item
                self.previousDroppedItem = self.droppedItem;
                self.previousDroppedItem.active = NO;
                
                [self.previousDroppedItem pop_removeAllAnimations];
                POPSpringAnimation *returnAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
                returnAnimation.toValue = [NSValue valueWithCGPoint:self.previousDroppedItem.originalPosition];
                returnAnimation.springBounciness = 10;
                returnAnimation.springSpeed = 20.0f;
                [self.previousDroppedItem pop_addAnimation:returnAnimation forKey:@"returnToOriginalPosition"];
                
                POPSpringAnimation *unscaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                unscaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                unscaleAnimation.springBounciness = 20.f;
                unscaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                unscaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
                unscaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.previousDroppedItem.transform.a != 1.0) {
                        self.previousDroppedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                    }
                };
                [self.previousDroppedItem pop_addAnimation:unscaleAnimation forKey:@"unscaleOnItemReplacedInDropZone"];
                
                // replace by new dragged item
                self.droppedItem = self.draggedItem;
                self.droppedItem.active = YES;
            }
        }
        
        // if dragged out of the drop zone
        if (dropZoneFull && self.draggedItem.active && ![self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            dropZoneFull = NO;
            self.droppedItem = nil;
            self.previousDroppedItem = nil;
            self.draggedItem.active = NO;
            
            //anim unscale
            POPSpringAnimation *unscaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            unscaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
            unscaleAnimation.springBounciness = 20.f;
            unscaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
            unscaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                //if scale not properly done
                if (self.draggedItem.transform.a != 1.0) {
                    self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                }
            };
            [self.draggedItem pop_addAnimation:unscaleAnimation forKey:@"unscaleOnItemDraggedOutOfDropZone"];
            
        }
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (dragging) {
        
        //if moved out of drop zone
        if (![self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            //anim return to initial position
            [self.draggedItem pop_removeAllAnimations];
            POPSpringAnimation *returnAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
            returnAnimation.toValue = [NSValue valueWithCGPoint:self.draggedItem.originalPosition];
            returnAnimation.springBounciness = 10;
            returnAnimation.springSpeed = 20.0f;
            [self.draggedItem pop_addAnimation:returnAnimation forKey:@"returnToOriginalPosition"];
        }
        
        //if moved in drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            dropped = YES;
            self.progressTimer.circlePathColor = self.droppedItem.colorValue;
            
            self.nbDrops++;
            NSLog(@"%d", self.nbDrops);
            if (self.nbDrops == 1) {
                [self.view addSubview:self.overlay3];
                self.overlay3.alpha = 1.0;
            } else {
                [self startTimer];
            }
            
            
            
            //if not in center of drop zone
            if (!CGPointEqualToPoint(self.draggedItem.center, self.dropZone.center)) {
                
                //anim return to center of drop zone
                [self.draggedItem pop_removeAllAnimations];
                POPSpringAnimation *returnToCenterAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
                returnToCenterAnimation.toValue = [NSValue valueWithCGPoint:self.dropZone.center];
                returnToCenterAnimation.springBounciness = 10;
                returnToCenterAnimation.springSpeed = 20.0f;
                [self.draggedItem pop_addAnimation:returnToCenterAnimation forKey:@"returnToOriginalPosition"];
                
                //anim scale
                POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                scaleAnimation.springBounciness = 20.f;
                scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.draggedItem.transform.a != 2.5) {
                        self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.5, 2.5);
                    }
                };
                [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrop"];
                
            } else {
                
                //anim scale
                [self.draggedItem pop_removeAllAnimations];
                POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                scaleAnimation.springBounciness = 20.f;
                scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.draggedItem.transform.a != 2.5) {
                        self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.5, 2.5);
                    }
                };
                [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrop"];
            }
        }
    }
}

#pragma mark - Loader

- (void) startTimer {
    
    CGFloat animDuration = 0.05;
    
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:animDuration target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

- (void) stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void) updateTimer:(NSTimer *) timer {
    if (dropped) {
        self.progressTimer.progress += 0.01;
    } else {
        self.progressTimer.progress -= 0.1;
    }
    
    [self.progressTimer setNeedsDisplay];
    
    if ((self.progressTimer.progress >= 1 ) && timer) {
        self.progressTimer.progress = 0;
        [self stopTimer];

        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MixCenters" bundle:nil];
        MixCenter_ContentViewController *mixCenter = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:mixCenter animated:YES];
    }
    
    if (self.progressTimer.progress < 0 && timer) {
        self.progressTimer.progress = 0;
        [self stopTimer];
    }
}

@end
