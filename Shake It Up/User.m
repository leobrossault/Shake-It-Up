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
    self.responseDataUser = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.79:8000/api/connection/brossault.leo@gmail.com"]];
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

- (void) loadDataProduct {
    self.responseDataProduct = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.79:8000/api/discoverAll/565f0a0f9cab747efb1748f3"]];
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
        }
    }] resume];
}


@end