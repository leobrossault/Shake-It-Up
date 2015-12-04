//
//  Environment.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 06/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Environment : NSObject

@property (nonatomic, strong) NSString *label;
@property (nonatomic, assign) NSInteger temperatureMin;
@property (nonatomic, assign) NSInteger temperatureMax;
@property (nonatomic, strong) NSString *moment;
@property (nonatomic, strong) NSString *season;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSArray *textures;
@property (nonatomic, strong) NSArray *sounds;
@property (nonatomic, strong) NSArray *emotions;
@property (nonatomic, strong) NSMutableData *responseData;

+ (instancetype) sharedEnvironment;

@end
