//
//  MixCenter_ContentViewController.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "MixCenter_ContentViewController.h"

@interface MixCenter_ContentViewController ()

@end

@implementation MixCenter_ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emotionMixCenter = self.childViewControllers[0];
    self.ingredientsMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"ingredientsMixCenter"];
    self.textureMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"textureMixCenter"];
    self.soundMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"soundMixCenter"];
    
    [self addChildViewController:self.ingredientsMixCenter];
    [self addChildViewController:self.textureMixCenter];
    [self addChildViewController:self.soundMixCenter];
    
    NSLog(@"%@", self.childViewControllers);
    self.currentMixCenterIndex = 0;
    self.nextMixCenterIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toOtherViewController:(id)sender {
    
    if(self.nextMixCenterIndex < 4) {
        
        [self transitionFromViewController:self.childViewControllers[self.currentMixCenterIndex] toViewController:self.childViewControllers[self.nextMixCenterIndex] duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{} completion:^(BOOL finished) {}];
        
        self.currentMixCenterIndex++;
        self.nextMixCenterIndex++;
    }
}

@end