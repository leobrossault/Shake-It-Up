//
//  Form_Validate_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Form_Validate_ViewController.h"
#import <pop/POP.h>
#import "HomeViewController.h"

@interface Form_Validate_ViewController ()<Home_DefaultDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;

@property (weak, nonatomic) IBOutlet UIView *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icoShare;
@property (weak, nonatomic) IBOutlet UILabel *labelShare;
@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;

@end

@implementation Form_Validate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Bottom Btn
    self.line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint: CGPointMake(25, 0)];
    self.line.path = linePath.CGPath;
    self.line.fillColor = nil;
    self.line.lineWidth = 2.5;
    self.line.strokeStart = 1;
    self.line.strokeEnd = 1;
    self.line.lineCap = kCALineCapRound;
    
    self.line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.line setFrame:CGRectMake(222, 48, 25, 2.5)];
    [self.shareBtn.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(222, 46.7, 6, 2.5);
    self.point.opacity = 0;
    
    [self.shareBtn.layer addSublayer: self.point];
    
    // See mix
    self.goHomeBtn.layer.borderWidth = 1.0f;
    self.goHomeBtn.layer.borderColor = [UIColor colorWithRed:0.89 green:0.83 blue:0.98 alpha:1.0].CGColor;
    [self.goHomeBtn.layer setCornerRadius:5.0f];
}

- (void)viewDidAppear:(BOOL)animated {
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(0.0);
    [self.line pop_addAnimation:animLine forKey:@"widthLine"];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.2);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        self.point.opacity = 1;
    });
    
    POPSpringAnimation *animPoint = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    animPoint.beginTime = CACurrentMediaTime() + 0.3;
    animPoint.springSpeed = 10;
    animPoint.springBounciness = 20.f;
    animPoint.fromValue = @(0.0);
    animPoint.toValue = @(-10.0);
    [self.point pop_addAnimation:animPoint forKey:@"leftPoint"];
    
    [UIView animateWithDuration: 0.3f animations:^{
        self.icoShare.alpha = 1;
        CGRect frameIcoBtn = self.icoShare.frame;
        frameIcoBtn.origin.y = self.icoShare.frame.origin.y - 10;
        self.icoShare.frame = frameIcoBtn;
        
        self.labelShare.alpha = 1;
        CGRect frameLabelBtn = self.labelShare.frame;
        frameLabelBtn.origin.x = self.labelShare.frame.origin.x - 10;
        self.labelShare.frame = frameLabelBtn;
        
    } completion:^(BOOL finished) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    HomeViewController *home = [sb instantiateInitialViewController];
    home.delegate = self;
    [self.navigationController pushViewController:home animated:YES];
}

@end
