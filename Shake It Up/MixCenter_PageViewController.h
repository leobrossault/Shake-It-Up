//
//  MixCenter_PageViewController.h
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "MixCenter_ContentViewController.h"

@interface MixCenter_PageViewController : UIPageViewController

@property (nonatomic, weak) MixCenter_ContentViewController *mixCenterPage;
@property (nonatomic, assign) NSInteger pendingIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end
