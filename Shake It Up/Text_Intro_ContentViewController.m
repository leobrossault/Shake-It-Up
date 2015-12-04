//
//  Text_Intro_ContentViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Text_Intro_ContentViewController.h"
#import "Text_Intro_PageViewController.h"
#import "NavigationController.h"

@interface Text_Intro_ContentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIImageView *waveContainer;
@property (weak, nonatomic) IBOutlet UILabel *textContainer;

@end

@implementation Text_Intro_ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationController *navigation = self.navigationController;
    [navigation hideMenu];
    
    prevPage = 0;
    
    Text_Intro_PageViewController *tip = self.childViewControllers[0];
    tip.textIntroPage = self;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSMutableArray *imgArray = [[NSMutableArray alloc] initWithCapacity: 81];
    for(int i = 0; i < 81; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"vague_intro_%d", i]];
        [imgArray addObject:image];
    }
    
    self.waveContainer.animationImages = imgArray;
    self.waveContainer.animationDuration = 5.0f;
    self.waveContainer.animationRepeatCount = 0;
    [self.waveContainer startAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setCurrentPage:(NSInteger)currentPage {
    [self.pageControl setCurrentPage: currentPage];
    
    // Top Button
    if (currentPage == 2) {
        [UIView animateWithDuration: 0.3f animations:^{
            [self.btnStart setAlpha:0];
        } completion:^(BOOL finished) {
            [self.btnStart setTitle:@"commencer" forState:UIControlStateNormal];
            [UIView animateWithDuration: 0.3f animations:^{
                [self.btnStart setAlpha:1];
            } completion:^(BOOL finished) {}];
        }];
    } else {
        if (prevPage == 2) {
            [UIView animateWithDuration: 0.3f animations:^{
                [self.btnStart setAlpha:0];
            } completion:^(BOOL finished) {
                [self.btnStart setTitle:@"passer" forState:UIControlStateNormal];
                [UIView animateWithDuration: 0.3f animations:^{
                    [self.btnStart setAlpha:1];
                } completion:^(BOOL finished) {}];
            }];
        }
    }
    
    // Text Label
    [UIView animateWithDuration: 0.3f animations:^{
        [self.textContainer setAlpha:0];
        CGRect frameText = self.textContainer.frame;
        frameText.origin.y = self.textContainer.frame.origin.y;
        self.textContainer.frame = frameText;
    } completion:^(BOOL finished) {
        if (currentPage == 0) {
            self.textContainer.text = @"Sisley est une marque de cosmétique française qui propose des produits naturels";
        } else if (currentPage == 1) {
            self.textContainer.text = @"Sisley te propose de créer des recettes de produits selon tes envies, tes humeurs";
        } else if (currentPage == 2) {
            self.textContainer.text = @"à l’issue de cette expérience, tu pourras recevoir des échantillons de produits Sisley";
        }
        
        [UIView animateWithDuration: 0.3f animations:^{
            [self.textContainer setAlpha:1];
            CGRect frameText = self.textContainer.frame;
            frameText.origin.y = self.textContainer.frame.origin.y - 10;
            self.textContainer.frame = frameText;
        } completion:^(BOOL finished) {}];
    }];
    
    prevPage = currentPage;
}

- (IBAction)goMixCenter:(id)sender {
    
}

@end
