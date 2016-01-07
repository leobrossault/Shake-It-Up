//
//  Text_Intro_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Text_Intro_PageViewController.h"
#import <pop/POP.h>

@interface Text_Intro_PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSArray *pageViewControllers;
@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;

@end

@implementation Text_Intro_PageViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    
    // All pages
    UIViewController *p1 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1"];
    UIViewController *p2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page2"];
    UIViewController *p3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page3"];
    self.pageViewControllers = @[p1, p2, p3];
    
    [self setViewControllers:@[p1] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.thirdSlide = self.pageViewControllers[2];
    
    self.line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(275, 55)];
    [linePath addLineToPoint: CGPointMake(300, 55)];
    self.line.path = linePath.CGPath;
    self.line.fillColor = nil;
    self.line.lineWidth = 2.5;
    self.line.strokeStart = 1;
    self.line.strokeEnd = 1;
    self.line.lineCap = kCALineCapRound;
    
    self.line.strokeColor = [UIColor colorWithRed:0.984 green:0.212 blue:0.365 alpha:1].CGColor;
    [self.view.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:0.984 green:0.212 blue:0.365 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(275, 53.7, 6, 2.5);
    self.point.opacity = 0;

    [self.view.layer addSublayer: self.point];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentIndex = 0;
    // Set index each controller
    [self.textIntroPage setCurrentPage: self.currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.pageViewControllers indexOfObject:viewController];
    
    if (index > 0)	{
        return self.pageViewControllers[index - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageViewControllers indexOfObject:viewController];
    index++;
    
    if (index < [self.pageViewControllers count])	{
        return self.pageViewControllers[index];
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.pendingIndex = [self.pageViewControllers indexOfObject:pendingViewControllers[0]];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // Check if page is completly visible
    if (completed)  {
        self.currentIndex = self.pendingIndex;
        [self.textIntroPage setCurrentPage: self.currentIndex];
        [self.thirdSlide checkCurrent: self.currentIndex];
    }
}


@end
