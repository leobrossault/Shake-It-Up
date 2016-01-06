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
@property (nonatomic, strong) UIFont *font18;
@property (nonatomic, strong) UIFont *font20;
@property (nonatomic, strong) UIFont *font24;
@property (nonatomic, strong) UIFont *font37;

@property (nonatomic, strong) UIFont *font12Bold;
@property (nonatomic, strong) UIFont *font18Bold;
@property (nonatomic, strong) UIFont *font37Bold;

//colors
@property (nonatomic, strong) UIColor *purple;
@property (nonatomic, strong) UIColor *lightGrey;
@property (nonatomic, strong) UIColor *white;

+ (instancetype) sharedAppSettings;

@end
