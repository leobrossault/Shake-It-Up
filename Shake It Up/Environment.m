//
//  Environment.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 06/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Environment.h"

@implementation Environment

+ (instancetype) sharedEnvironment {
    static Environment *sharedInstance;
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
        
        [self performSelector:@selector(loadData) withObject:nil afterDelay:0.2];
        
    }
    return self;
}

#pragma mark - GetDataEnvironment

- (void) loadData {
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://37.187.118.146:8000/api/environment/debug"]];
    NSLog(@"okokokokokoko");
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"okokokokokoko");
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", error);
            NSLog(@"errrrrrrrrooooooooooooor");
            
        } else {
            NSLog(@"okokokokokoko");
            // Data to Object
            NSArray *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
            self.label = [[JSON objectAtIndex: 0] objectForKey:@"label"];
            self.temperatureMin = (NSInteger)[[JSON objectAtIndex: 0] objectForKey:@"temperatureMin"];
            self.temperatureMax = (NSInteger)[[JSON objectAtIndex: 0] objectForKey:@"temperatureMax"];
            self.moment = [[JSON objectAtIndex: 0] objectForKey:@"moment"];
            self.season = [[JSON objectAtIndex: 0] objectForKey:@"season"];
            self.colors = [[JSON objectAtIndex: 0] objectForKey:@"colors"];
            self.ingredients = [[JSON objectAtIndex: 0] objectForKey:@"ingredients"];
            self.textures = [[JSON objectAtIndex: 0] objectForKey:@"textures"];
            self.sounds = [[JSON objectAtIndex: 0] objectForKey:@"sounds"];
            self.emotions = [[JSON objectAtIndex: 0] objectForKey:@"emotions"];
            
            NSLog(@"%@", JSON);
        }
    }] resume];
    
}


@end
