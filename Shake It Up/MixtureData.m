//
//  MixtureData.m
//  Shake It Up
//
//  Created by Jeremie drazic on 14/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "MixtureData.h"

@implementation MixtureData

+ (instancetype) sharedMixtureData {
    static MixtureData *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
