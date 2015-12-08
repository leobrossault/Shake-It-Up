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

@interface Discover_ViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *mainImgProduct;
@property (nonatomic, strong) NSArray *userProducts;
@property (weak, nonatomic) IBOutlet UIImageView *waveContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *sloganProduct;
@property (weak, nonatomic) IBOutlet UILabel *descrProduct;
@property (weak, nonatomic) IBOutlet UIButton *retryExp;
@property (weak, nonatomic) IBOutlet UIView *testProduct;
@property (weak, nonatomic) IBOutlet UIView *similarProduct;

@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (nonatomic, strong) CAShapeLayer *lineMore;
@property (nonatomic, strong) CALayer *pointMore;

@property (nonatomic, strong) NavigationController *navigation;

@end

@implementation Discover_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation = self.navigationController;
    [self.navigation showMenu];
    [self.navigation whiteMenu];
    // Do any additional setup after loading the view.
    self.userProducts = [User sharedUser].userProducts;
    
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
    [linePath moveToPoint: CGPointMake(270, 50)];
    [linePath addLineToPoint: CGPointMake(295, 50)];
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
    self.point.frame = CGRectMake(260, 48.7, 6, 2.5);
    
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
    }
}

- (void)goForm:(UITapGestureRecognizer *) recognizer {
    [self performSegueWithIdentifier:@"goForm" sender:recognizer];
}



@end
