//
//  SoundMixCenter_ViewController.m
//  Shake It Up
//
//  Created by Jeremie drazic on 01/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "SoundMixCenter_ViewController.h"

@interface SoundMixCenter_ViewController ()

@end

@implementation SoundMixCenter_ViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.ingredients = [Environment sharedEnvironment].sounds;
        self.app = [AppSettings sharedAppSettings];
        
        [self buildInterface];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
