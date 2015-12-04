//
//  AppSettings.h
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 01/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject

//fonts
@property (nonatomic, strong) UIFont *font12;

//colors
@property (nonatomic, strong) UIColor *purple;
@property (nonatomic, strong) UIColor *lightGrey;

+ (instancetype) sharedAppSettings;

@end
