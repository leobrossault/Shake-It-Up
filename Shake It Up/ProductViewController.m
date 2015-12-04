//
//  ProductViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 03/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "ProductViewController.h"
#import "User.h"
#import "NavigationController.h"

@interface ProductViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImgProduct;
@property (nonatomic, strong) NSArray *userProducts;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *waveContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *sloganProduct;
@property (weak, nonatomic) IBOutlet UILabel *descrProduct;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
    [navigation whiteMenu];
    // Do any additional setup after loading the view.
    self.userProducts = [User sharedUser].userProducts;
    
    // Inject Data
    self.mainImgProduct.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"pathMainImg"]]];
    self.sloganProduct.text = [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"slogan"];
    [self.sloganProduct sizeToFit];
    self.descrProduct.text = [[self.userProducts objectAtIndex: (int)self.product] objectForKey:@"description"];
    [self.descrProduct sizeToFit];
    
    NSMutableArray *imgArray = [[NSMutableArray alloc] initWithCapacity: 81];
    for(int i = 0; i < 81; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"vague_ficheproduit_%d", i]];
        [imgArray addObject:image];
    }
    
    self.waveContainer.animationImages = imgArray;
    self.waveContainer.animationDuration = 5.0f;
    self.waveContainer.animationRepeatCount = 0;
    [self.waveContainer startAnimating];
    
    self.scrollView.contentSize = CGSizeMake(320, 800);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
    [self performSegueWithIdentifier:@"backToHome" sender:sender];
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
