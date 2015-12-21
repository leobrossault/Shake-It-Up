//
//  MixtureData.h
//  Shake It Up
//
//  Created by Jeremie drazic on 14/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MixtureData : NSObject

@property (nonatomic, strong) NSString *emotion;
@property (nonatomic, strong) NSString *emotionImageName;
@property (nonatomic, strong) UIColor *emotionColor;

@property (nonatomic, strong) NSString *ingredient;
@property (nonatomic, strong) NSString *ingredientImageName;
@property (nonatomic, strong) UIColor *ingredientColor;

@property (nonatomic, strong) NSString *texture;
@property (nonatomic, strong) NSString *textureImageName;
@property (nonatomic, strong) UIColor *textureColor;

@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSString *soundImageName;
@property (nonatomic, strong) NSString *soundName;
@property (nonatomic, strong) UIColor *soundColor;

@property (nonatomic, strong) NSString *bodyPart;
@property (nonatomic, strong) UIColor *bodyPartColor;

+ (instancetype) sharedMixtureData;

@end
