//
//  NavigationController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "NavigationController.h"
#import <pop/POP.h>
#import "Store_Home_ViewController.h"
#import "HomeViewController.h"

@interface NavigationController ()<Home_DefaultDelegate, StoreDefaultDelegate>

@property (nonatomic, strong) NSArray *titleSections;
@property (nonatomic, strong) NSArray *icoSections;
@property (nonatomic, assign) NSInteger *selectedSection;

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuView = [[UIView alloc] init];
    [self.menuView setFrame:CGRectMake(320, 0, 270, 568)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    [self.view addSubview: self.menuView];
    
    self.icoMenu = [[UIView alloc] init];
    [self.icoMenu setFrame:CGRectMake(270, 40, 30, 20)];
    [self.view addSubview: self.icoMenu];
    
    UITapGestureRecognizer *menuAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCloseMenu:)];
    [self.icoMenu addGestureRecognizer:menuAction];
    
    
    // Lines Ico menu
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
    
    // Init Content Menu
    self.titleSections = [NSArray arrayWithObjects:@"Créer une nouvelle recette", @"Mes recettes", @"Mon profil", @"Mes boutiques", @"Paramètres", @"Quitter l'application", nil];
    self.icoSections = [NSArray arrayWithObjects:@"ico_default_menu", @"ico_default_menu", @"ico_default_menu", @"ico_default_menu", @"ico_default_menu", @"ico_default_menu", nil];
    // Title Menu
    UILabel *titleMenu = [[UILabel alloc] init];
    [titleMenu setFrame:CGRectMake(25, 35, 200, 30)];
    titleMenu.text = @"Shake it up";
    titleMenu.textColor = [UIColor whiteColor];
    titleMenu.font = [UIFont fontWithName:@"Bariol-Bold" size:28];
    
    // Border menu
    CAShapeLayer *borderTitleMenu = [CAShapeLayer layer];
    UIBezierPath *borderTitleMenuPath = [UIBezierPath bezierPath];
    [borderTitleMenuPath moveToPoint: CGPointMake(0, 0)];
    [borderTitleMenuPath addLineToPoint: CGPointMake(30, 0)];
    borderTitleMenu.path = borderTitleMenuPath.CGPath;
    borderTitleMenu.fillColor = nil;
    borderTitleMenu.lineWidth = 1;
    [borderTitleMenu setFrame:CGRectMake(25, 85, 30, 1)];
    borderTitleMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    
    CAShapeLayer *borderBottomMenu = [CAShapeLayer layer];
    UIBezierPath *borderBottomMenuPath = [UIBezierPath bezierPath];
    [borderBottomMenuPath moveToPoint: CGPointMake(0, 0)];
    [borderBottomMenuPath addLineToPoint: CGPointMake(30, 0)];
    borderBottomMenu.path = borderBottomMenuPath.CGPath;
    borderBottomMenu.fillColor = nil;
    borderBottomMenu.lineWidth = 1;
    [borderBottomMenu setFrame:CGRectMake(25, 518, 30, 1)];
    borderBottomMenu.strokeColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
    
    // Sections menu
    for (int j = 0; j < [self.titleSections count]; j ++) {
        float yTitleSection = 120 + 70 * j;
        
        UIView *viewSection = [[UIView alloc] init];
        [viewSection setFrame:CGRectMake(25, yTitleSection - 6, 200, 30)];
        viewSection.tag = j;
        
        UILabel *titleSection = [[UILabel alloc] init];
        [titleSection setFrame:CGRectMake(40, 6, 200, 20)];
        titleSection.text = [self.titleSections objectAtIndex: j];
        titleSection.textColor = [UIColor whiteColor];
        titleSection.font = [UIFont fontWithName:@"Bariol-Bold" size:18];
        
        UIImageView *imgSection = [[UIImageView alloc] init];
        [imgSection setFrame:CGRectMake(0, 0, 30, 30)];
        [imgSection setImage:[UIImage imageNamed: [self.icoSections objectAtIndex: j]]];
        
        
        [viewSection addSubview: titleSection];
        [viewSection addSubview: imgSection];
        [self.menuView addSubview: viewSection];
        
        UITapGestureRecognizer *tapSection = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goTo:)];
        [viewSection addGestureRecognizer:tapSection];
    }
    
    // Add menu components
    [self.menuView addSubview: titleMenu];
    [self.menuView.layer addSublayer:borderTitleMenu];
    [self.menuView.layer addSublayer:borderBottomMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openCloseMenu:(UITapGestureRecognizer *) recognizer {
    if (menuOpen == 0) {
        [UIView animateWithDuration: 0.5f animations:^{
            CGRect frameMenu = self.menuView.frame;
            frameMenu.origin.x = 50;
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

- (void)goTo:(UITapGestureRecognizer *)recognizer {
    UIView *selectedView = (UIView *)recognizer.view;
    self.selectedSection = (NSInteger *)selectedView.tag;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ((int)self.selectedSection == 0) {
        NSLog(@"Créer une nouvelle recette");
    } else if ((int)self.selectedSection == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        HomeViewController *home = [sb instantiateInitialViewController];
        [self pushViewController:home animated:YES];
    } else if ((int)self.selectedSection == 2) {
        if ([defaults objectForKey:@"isRegister"]) {
            NSLog(@"Mon profil");
        } else {
            NSLog(@"Créer mon compte");
        }
    } else if ((int)self.selectedSection == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Store" bundle:nil];
        Store_Home_ViewController *store = [sb instantiateInitialViewController];
        [self pushViewController:store animated:YES];
    } else if ((int)self.selectedSection == 4) {
        NSLog(@"Paramètres");
    } else if ((int)self.selectedSection == 5) {
        exit(0);
    }
    
    [self openCloseMenu: nil];
}

@end
