//
//  MixCenter_ContentViewController.h
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "MixCenter_ViewController.h"
#import "SoundMixCenter_ViewController.h"

@protocol MixCenterDelegate <NSObject>

@end

@interface MixCenter_ContentViewController : UIViewController

@property (nonatomic) MixCenter_ViewController *emotionMixCenter;
@property (nonatomic) MixCenter_ViewController *ingredientsMixCenter;
@property (nonatomic) MixCenter_ViewController *textureMixCenter;
@property (nonatomic) SoundMixCenter_ViewController *soundMixCenter;
@property (nonatomic, assign) NSInteger currentMixCenterIndex;
@property (nonatomic, assign) NSInteger nextMixCenterIndex;
@property (nonatomic, weak) id <MixCenterDelegate> delegate;

@property (nonatomic) AppSettings *app;

@property (nonatomic) MixtureData *mData;

@end
