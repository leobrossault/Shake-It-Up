//
//  User.h
//  Shake It Up
//
//  Created by Léo Brossault on 03/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSArray *userProducts;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSMutableData *responseDataUser;
@property (nonatomic, strong) NSMutableData *responseDataProduct;

+ (instancetype) sharedUser;
- (void) loadDataUser;

@end
