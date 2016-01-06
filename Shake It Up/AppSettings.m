//
//  AppSettings.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 01/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+ (instancetype) sharedAppSettings {
    static AppSettings *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    } );
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.font12 = [UIFont fontWithName:@"Bariol" size:12];
        self.font18 = [UIFont fontWithName:@"Bariol" size:18];
        self.font20 = [UIFont fontWithName:@"Bariol" size:20];
        self.font24 = [UIFont fontWithName:@"Bariol" size:24];
        self.font37 = [UIFont fontWithName:@"Bariol" size:37];
        
        self.font18Bold = [UIFont fontWithName:@"Bariol-bold" size:18];
        self.font37Bold = [UIFont fontWithName:@"Bariol-bold" size:37];
        self.font12Bold = [UIFont fontWithName:@"Bariol-bold" size:12];
        
        self.purple = [UIColor colorWithRed:91.0/255.0 green:45.0/255.0 blue:148.0/255.0 alpha:1.0];
        self.lightGrey = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:254.0/255.0 alpha:1.0];
        self.white = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        
    }
    return self;
}

@end
