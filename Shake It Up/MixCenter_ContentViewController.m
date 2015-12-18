//
//  MixCenter_ContentViewController.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "MixCenter_ContentViewController.h"

@interface MixCenter_ContentViewController () <MixCenterDelegate>

@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (nonatomic, strong) CAShapeLayer *lineMore;

@end

@implementation MixCenter_ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.app = [AppSettings sharedAppSettings];
    self.mData = [MixtureData sharedMixtureData];
    
    self.emotionMixCenter = self.childViewControllers[0];
    self.ingredientsMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"ingredientsMixCenter"];
    self.textureMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"textureMixCenter"];
    self.soundMixCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"soundMixCenter"];
    
    self.emotionMixCenter.delegate = self;
    self.ingredientsMixCenter.delegate = self;
    self.textureMixCenter.delegate = self;
    self.soundMixCenter.delegate = self;
    
    [self addChildViewController:self.ingredientsMixCenter];
    [self addChildViewController:self.textureMixCenter];
    [self addChildViewController:self.soundMixCenter];
    
    self.currentMixCenterIndex = 0;
    self.nextMixCenterIndex = 1;
    
    self.lineMore = [CAShapeLayer layer];
    UIBezierPath *linePathMore=[UIBezierPath bezierPath];
    [linePathMore moveToPoint: CGPointMake(0, 565)];
    [linePathMore addLineToPoint: CGPointMake(320, 565)];
    self.lineMore.path = linePathMore.CGPath;
    self.lineMore.fillColor = nil;
    self.lineMore.lineWidth = 6;
    self.lineMore.strokeStart = 0;
    self.lineMore.strokeEnd = 0;
    
    self.lineMore.strokeColor = self.app.purple.CGColor;
    [self.view.layer addSublayer:self.lineMore];

}

- (void)viewDidAppear:(BOOL)animated {
    
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(0.25);
    [self.lineMore pop_addAnimation:animLine forKey:@"widthLine"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animStateLine {
    CGFloat strokeEndValue = 0;
    
    if (self.currentMixCenterIndex == 1) {
        strokeEndValue = 0.50;
    } else if (self.currentMixCenterIndex == 2) {
        strokeEndValue = 0.75;
    } else if (self.currentMixCenterIndex == 3) {
        strokeEndValue = 1;
    }
    
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(strokeEndValue);
    [self.lineMore pop_addAnimation:animLine forKey:@"widthLine"];
}

#pragma mark - MixCenterDelegate

- (void) mixCenterDidFinish {
    
    if(self.nextMixCenterIndex < 4) {
        
        NSLog(@"%ld", (long)self.currentMixCenterIndex);
        
        if (self.currentMixCenterIndex == 0) {
            NSLog(@"%ld", (long)self.currentMixCenterIndex);
            self.mData.emotion = self.emotionMixCenter.selectedIngredient;
            self.mData.emotionColor = self.emotionMixCenter.selectedIngredientColor;
            self.mData.emotionImageName = self.emotionMixCenter.selectedIngredientImageName;
        }
        
        if (self.currentMixCenterIndex == 1) {
            self.mData.ingredient = self.ingredientsMixCenter.selectedIngredient;
            self.mData.ingredientColor = self.ingredientsMixCenter.selectedIngredientColor;
            self.mData.ingredientImageName = self.ingredientsMixCenter.selectedIngredientImageName;
        }
        
        if (self.currentMixCenterIndex == 2) {
            self.mData.texture = self.textureMixCenter.selectedIngredient;
            self.mData.textureColor = self.textureMixCenter.selectedIngredientColor;
            self.mData.textureImageName = self.textureMixCenter.selectedIngredientImageName;
        }
        
        if (self.currentMixCenterIndex == 3) {
            self.mData.sound = self.soundMixCenter.selectedIngredient;
            self.mData.soundColor = self.soundMixCenter.selectedIngredientColor;
            self.mData.soundImageName = self.soundMixCenter.selectedIngredientImageName;
        }
        
        [self transitionFromViewController:self.childViewControllers[self.currentMixCenterIndex] toViewController:self.childViewControllers[self.nextMixCenterIndex] duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{} completion:^(BOOL finished) {
            NSLog(@"%ld", (long)self.currentMixCenterIndex);
            [self animStateLine];
        }];
        
        self.currentMixCenterIndex++;
        self.nextMixCenterIndex++;
    }
}

@end