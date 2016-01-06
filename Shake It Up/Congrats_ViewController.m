//
//  Congrats_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 03/01/2016.
//  Copyright © 2016 BROSSAULT Leo. All rights reserved.
//

#import "Congrats_ViewController.h"
#import "NavigationController.h"
#import "HomeViewController.h"

@interface Congrats_ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backToHome;
@property (nonatomic, strong) NavigationController *navigation;

@end

@implementation Congrats_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation = (NavigationController *)self.navigationController;
    [self.navigation showMenu];
    [self.navigation resetColorMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToHome:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    HomeViewController *home = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:home animated:YES];
}


@end
