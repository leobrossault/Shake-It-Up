//
//  NavigationController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "NavigationController.h"
#import <pop/POP.h>

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuView = [[UIView alloc] init];
    [self.menuView setFrame:CGRectMake(320, 0, 205, 568)];
    self.menuView.backgroundColor = [UIColor grayColor];
    [self.view addSubview: self.menuView];
    
    self.icoMenu = [[UIView alloc] init];
    [self.icoMenu setFrame:CGRectMake(270, 40, 30, 20)];
    [self.view addSubview: self.icoMenu];
    
    UITapGestureRecognizer *menuAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCloseMenu:)];
    [self.icoMenu addGestureRecognizer:menuAction];
    
    self.lineTopMenu = [CAShapeLayer layer];
    UIBezierPath *linePathTop=[UIBezierPath bezierPath];
    [linePathTop moveToPoint: CGPointMake(0, 0)];
    [linePathTop addLineToPoint: CGPointMake(30, 0)];
    self.lineTopMenu.path = linePathTop.CGPath;
    self.lineTopMenu.fillColor = nil;
    self.lineTopMenu.lineWidth = 2;
    self.lineTopMenu.lineCap = kCALineCapRound;
    [self.lineCenterMenu setFrame:CGRectMake(0, 0, 30, 2)];
    
    self.lineTopMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    [self.icoMenu.layer addSublayer:self.lineTopMenu];
    
    self.lineCenterMenu = [CAShapeLayer layer];
    UIBezierPath *linePathCenter=[UIBezierPath bezierPath];
    [linePathCenter moveToPoint: CGPointMake(0, 0)];
    [linePathCenter addLineToPoint: CGPointMake(30, 0)];
    self.lineCenterMenu.path = linePathCenter.CGPath;
    self.lineCenterMenu.fillColor = nil;
    self.lineCenterMenu.lineWidth = 2;
    self.lineCenterMenu.lineCap = kCALineCapRound;
    [self.lineCenterMenu setFrame:CGRectMake(0, 10, 30, 2)];
    
    self.lineCenterMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    [self.icoMenu.layer addSublayer:self.lineCenterMenu];
    
    self.lineBotMenu = [CAShapeLayer layer];
    UIBezierPath *linePathBot=[UIBezierPath bezierPath];
    [linePathBot moveToPoint: CGPointMake(0, 0)];
    [linePathBot addLineToPoint: CGPointMake(30, 0)];
    self.lineBotMenu.path = linePathBot.CGPath;
    self.lineBotMenu.fillColor = nil;
    self.lineBotMenu.lineWidth = 2;
    self.lineBotMenu.lineCap = kCALineCapRound;
    self.lineBotMenu.anchorPoint = CGPointMake(0, 0);
    [self.lineBotMenu setFrame:CGRectMake(0, 21, 30, 2)];
    
    self.lineBotMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    [self.icoMenu.layer addSublayer:self.lineBotMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openCloseMenu:(UITapGestureRecognizer *) recognizer {
    if (menuOpen == 0) {
        [UIView animateWithDuration: 0.5f animations:^{
            CGRect frameMenu = self.menuView.frame;
            frameMenu.origin.x = 115;
            self.menuView.frame = frameMenu;
        } completion:^(BOOL finished) {
            menuOpen = 1;
        }];
        
        // Ico Animation
        [UIView animateWithDuration:0.5f animations:^{
            self.lineTopMenu.transform = CATransform3DMakeRotation(M_PI * 0.25, 0, 0.0, 1.0);
            self.lineBotMenu.transform = CATransform3DMakeRotation(- M_PI * 0.25, 0, 0.0, 1.0);
        } completion:^(BOOL finished) {}];
        
        POPSpringAnimation *animLineCenter = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
        animLineCenter.springSpeed = 10;
        animLineCenter.springBounciness = 10.f;
        animLineCenter.fromValue = @(0.0);
        animLineCenter.toValue = @(100);
        [self.lineCenterMenu pop_addAnimation:animLineCenter forKey:@"animLineCenter"];
    } else {
        [UIView animateWithDuration: 0.5f animations:^{
            CGRect frameMenu = self.menuView.frame;
            frameMenu.origin.x = 320;
            self.menuView.frame = frameMenu;
        } completion:^(BOOL finished) {
            menuOpen = 0;
        }];
        
        // Ico Animation
        [UIView animateWithDuration:0.5f animations:^{
            self.lineTopMenu.transform = CATransform3DMakeRotation(0, 0, 0.0, 1.0);
            self.lineBotMenu.transform = CATransform3DMakeRotation(0, 0, 0.0, 1.0);
        } completion:^(BOOL finished) {}];
        
        POPSpringAnimation *animLineCenter = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
        animLineCenter.springSpeed = 10;
        animLineCenter.springBounciness = 10.f;
        animLineCenter.fromValue = @(100);
        animLineCenter.toValue = @(0);
        [self.lineCenterMenu pop_addAnimation:animLineCenter forKey:@"animLineCenter"];
    }
}

- (void)hideMenu {
    self.icoMenu.hidden = true;
}

- (void)showMenu {
    self.icoMenu.hidden = false;
}

- (void)whiteMenu {
    self.lineTopMenu.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0].CGColor;
    self.lineCenterMenu.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0].CGColor;
    self.lineBotMenu.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0].CGColor;
}

- (void)resetColorMenu {
    self.lineTopMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    self.lineCenterMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    self.lineBotMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
}

@end
