//
//  Discover_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 08/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Discover_ViewController.h"
#import "User.h"
#import "NavigationController.h"
#import "Form_SignUp_ViewController.h"
#import "Form_Validate_ViewController.h"

@interface Discover_ViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *mainImgProduct;
@property (nonatomic, strong) NSArray *userProducts;
@property (weak, nonatomic) IBOutlet UIImageView *waveContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSDictionary *product;
@property (weak, nonatomic) IBOutlet UILabel *sloganProduct;
@property (weak, nonatomic) IBOutlet UILabel *descrProduct;
@property (weak, nonatomic) IBOutlet UIButton *retryExp;
@property (weak, nonatomic) IBOutlet UIView *testProduct;
@property (weak, nonatomic) IBOutlet UIView *similarProduct;

@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (nonatomic, strong) CAShapeLayer *lineMore;
@property (nonatomic, strong) CALayer *pointMore;

@property (nonatomic, strong) NSMutableArray *anonymousProduct;
@property (nonatomic, strong) NSDictionary *user;

@property (nonatomic, strong) NavigationController *navigation;

@end

@implementation Discover_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation = self.navigationController;
    [self.navigation showMenu];
    [self.navigation whiteMenu];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view.
//    self.userProducts = [User sharedUser].userProducts;
    
    // Get Product from Database
    // Fake request
    NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/product/debug"];
    
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
        
        if (![defaults objectForKey: @"products"]) {
            self.anonymousProduct = [[NSMutableArray alloc] init];
        } else {
            self.anonymousProduct = [[NSMutableArray alloc] initWithArray: [defaults objectForKey:@"products"]];
        }
        
        [self.anonymousProduct addObject: self.product];
        [defaults setObject: self.anonymousProduct forKey:@"products"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }] resume];
    
    
    
    if ([defaults objectForKey: @"isRegister"]) {
        self.user = [User sharedUser].user;
        NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/addProduct/%@/%@", [self.user objectForKey:@"email"], [self.product objectForKey: @"_id"]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.timeoutIntervalForResource = 30;
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                NSLog(@"%@", error);
            }
        }] resume];
    } else {
        // Save data for anonymous user
        [defaults setObject: self.anonymousProduct forKey:@"products"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // Inject Data
//    self.mainImgProduct.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"pathMainImg"]]];
//    self.sloganProduct.text = [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"slogan"];
//    [self.sloganProduct sizeToFit];
//    self.descrProduct.text = [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"description"];
//    [self.descrProduct sizeToFit];
    
    NSMutableArray *imgArray = [[NSMutableArray alloc] initWithCapacity: 81];
    for(int i = 0; i < 81; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"vague_ficheproduit_%d", i]];
        [imgArray addObject:image];
    }
    
    self.waveContainer.animationImages = imgArray;
    self.waveContainer.animationDuration = 5.0f;
    self.waveContainer.animationRepeatCount = 0;
    [self.waveContainer startAnimating];
    
    [self.scrollView setDelegate:self];
    self.scrollView.contentSize = CGSizeMake(320, 1295);
    
    self.retryExp.layer.borderWidth=1.0f;
    self.retryExp.layer.borderColor= [UIColor colorWithRed:0.89 green:0.83 blue:0.98 alpha:1.0].CGColor;
    [self.retryExp.layer setCornerRadius:5.0f];
    
    // Test Product
    self.line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(228, 50)];
    [linePath addLineToPoint: CGPointMake(253, 50)];
    self.line.path = linePath.CGPath;
    self.line.fillColor = nil;
    self.line.lineWidth = 2.5;
    self.line.strokeStart = 0;
    self.line.strokeEnd = 1;
    self.line.lineCap = kCALineCapRound;
    
    self.line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.testProduct.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(218, 48.7, 6, 2.5);
    
    [self.testProduct.layer addSublayer: self.point];
    
    UITapGestureRecognizer *tapTest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goForm:)];
    [tapTest setNumberOfTapsRequired: 1];
    [self.testProduct addGestureRecognizer:tapTest];
    
    // More
    self.lineMore = [CAShapeLayer layer];
    UIBezierPath *linePathMore=[UIBezierPath bezierPath];
    [linePathMore moveToPoint: CGPointMake(33, 352)];
    [linePathMore addLineToPoint: CGPointMake(58, 352)];
    self.lineMore.path = linePathMore.CGPath;
    self.lineMore.fillColor = nil;
    self.lineMore.lineWidth = 2.5;
    self.lineMore.strokeStart = 0;
    self.lineMore.strokeEnd = 1;
    self.lineMore.lineCap = kCALineCapRound;
    
    self.lineMore.strokeColor = [UIColor colorWithRed:0.15 green:0.01 blue:0.38 alpha:1.0].CGColor;
    [self.similarProduct.layer addSublayer:self.lineMore];
    
    self.pointMore = [CALayer layer];
    [self.pointMore setMasksToBounds:YES];
    self.pointMore.backgroundColor = [UIColor colorWithRed:0.15 green:0.01 blue:0.38 alpha:1.0].CGColor;
    [self.pointMore setCornerRadius: 3.0f];
    self.pointMore.frame = CGRectMake(63, 350.7, 6, 2.5);
    
    [self.similarProduct.layer addSublayer: self.pointMore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
    [self performSegueWithIdentifier:@"backToHome" sender:sender];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 330) {
        [self.navigation whiteMenu];
    }
    else if (scrollView.contentOffset.y >= 330) {
        [self.navigation resetColorMenu];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goForm"]) {
        //send data
        Form_SignUp_ViewController *controller = (Form_SignUp_ViewController *)segue.destinationViewController;
        controller.product = self.product;
    } else if ([segue.identifier isEqualToString:@"alreadyForm"]) {
        Form_Validate_ViewController *controller = (Form_Validate_ViewController *)segue.destinationViewController;
        controller.product = self.product;
    }
}

- (void)goForm:(UITapGestureRecognizer *) recognizer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey: @"isRegister"]) {
        [self performSegueWithIdentifier:@"alreadyForm" sender:recognizer];
    } else {
        [self performSegueWithIdentifier:@"goForm" sender:recognizer];
    }
}



@end
