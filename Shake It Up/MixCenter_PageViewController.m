//
//  MixCenter_PageViewController.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "MixCenter_PageViewController.h"
#import "MixCenter_ViewController.h"
#import "SoundMixCenter_ViewController.h"

@interface MixCenter_PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSArray *pageViewControllers;
@property (nonatomic, strong) CAShapeLayer *line;

@end

@implementation MixCenter_PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    
    //All pages
    MixCenter_ViewController *emotionMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"emotionMixCenter"];
    MixCenter_ViewController *ingredientsMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"ingredientsMixCenter"];
    MixCenter_ViewController *textureMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"textureMixCenter"];
    SoundMixCenter_ViewController *soundMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"soundMixCenter"];
    
    self.pageViewControllers = @[emotionMixCenter, ingredientsMixCenter, textureMixCenter, soundMixCenter];
    
    [self setViewControllers:@[emotionMixCenter] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    
    return nil;
}

- (void) pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}

- (void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
}

@end
