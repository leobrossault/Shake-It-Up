//
//  User.m
//  Shake It Up
//
//  Created by Léo Brossault on 03/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "User.h"

@implementation User


+ (instancetype) sharedUser {
    static User *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    } );
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self performSelector:@selector(loadDataUser) withObject:nil afterDelay:0.2];
        [self performSelector:@selector(loadDataProduct) withObject:nil afterDelay:0.2];
    }
    return self;
}

#pragma mark - GetDataUser

- (void) loadDataUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isRegister"]) {
        NSLog(@"get user");
        self.responseDataUser = [NSMutableData data];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://37.187.118.146:8000/api/connection/%@", [defaults objectForKey:@"isRegister"]]]];
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.timeoutIntervalForResource = 30;
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                NSLog(@"%@", error);
            
            } else {
            // Data to Object
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
                self.user = JSON;
            }
        }] resume];
    }
}

- (void) loadDataProduct {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults objectForKey:@"isRegister"]) {
        self.responseDataProduct = [NSMutableData data];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://37.187.118.146:8000/api/discoverAll/%@", [defaults objectForKey:@"isRegister"]]]];
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.timeoutIntervalForResource = 30;
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                NSLog(@"%@", error);
            
            } else {
            // Data to Object
                NSArray *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
                self.userProducts = JSON;
                NSLog(@"%@", self.userProducts);
            }
        }] resume];
    } else {
        if ([defaults objectForKey:@"products"]) {
            self.userProducts = [defaults objectForKey:@"products"];
        }
    }
    
    
}

-(BOOL) isAnonymous {
    return YES;
}


@end