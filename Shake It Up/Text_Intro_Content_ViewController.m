//
//  Text_Intro_Content_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Text_Intro_Content_ViewController.h"

@interface Text_Intro_Content_ViewController ()

@property (strong, nonatomic) IBOutlet UIView *pageScreen;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property NSString *txtTitle;
@property NSUInteger pageIndex;

@end

@implementation Text_Intro_Content_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageLabel.text = self.txtTitle;
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
