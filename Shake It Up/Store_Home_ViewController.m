//
//  Store_Home_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Home_ViewController.h"
#import "NavigationController.h"

@interface Store_Home_ViewController ()

@end

@implementation Store_Home_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
