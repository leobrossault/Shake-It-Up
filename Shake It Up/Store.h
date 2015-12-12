//
//  Store.h
//  Shake It Up
//
//  Created by Léo Brossault on 12/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (nonatomic, strong) NSArray *store;
@property (nonatomic, strong) NSMutableData *responseData;

+ (instancetype) sharedStore;

@end
