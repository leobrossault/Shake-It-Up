//
//  ProductViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 03/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImgProduct;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.product);
    NSLog(@"%@", [self.product objectAtIndex:0]);
    self.mainImgProduct.image = [UIImage imageNamed:[NSString stringWithFormat:@"eau_tropicale_main_img"]];
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
