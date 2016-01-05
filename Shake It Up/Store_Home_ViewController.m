//
//  Store_Home_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Home_ViewController.h"
#import "NavigationController.h"
#import "Store_Search_ViewController.h"
#import "HomeViewController.h"
#import "Sign_Up_Later_ViewController.h"

@interface Store_Home_ViewController ()

@property (weak, nonatomic) IBOutlet UIView *btnNextStore;
@property (weak, nonatomic) IBOutlet UIView *btnFavStore;

@end

@implementation Store_Home_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
    [navigation resetColorMenu];
    
    // Remove previous View Controller
    NSInteger count = [self.navigationController.viewControllers count];
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex: count - 2];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"isRegister"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"signUp" bundle:nil];
        Sign_Up_Later_ViewController *signup = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:signup animated:YES];
    }
    
    UITapGestureRecognizer *tapNext = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nearStoresAction:)];
    [self.btnNextStore addGestureRecognizer:tapNext];
    
    UITapGestureRecognizer *tapFav = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoriteStoresAction:)];
    [self.btnFavStore addGestureRecognizer:tapFav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToSearch"]) {
        Store_Search_ViewController *controller = (Store_Search_ViewController *)segue.destinationViewController;
        controller.favorites = storeChoice;
    }
}

- (void)nearStoresAction:(UITapGestureRecognizer *)sender {
    storeChoice = 0;
    [self performSegueWithIdentifier:@"goToSearch" sender:sender];
}

- (void)favoriteStoresAction:(UITapGestureRecognizer *)sender {
    storeChoice = 1;
    [self performSegueWithIdentifier:@"goToSearch" sender:sender];
}

@end
