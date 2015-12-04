//
//  Text_Intro_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Text_Intro_ContentViewController.h"
#import "Third_Text_Intro_Page_DetailViewController.h"


@interface Text_Intro_PageViewController : UIPageViewController

@property (nonatomic, weak) Text_Intro_ContentViewController *textIntroPage;
@property (nonatomic, strong) Third_Text_Intro_Page_DetailViewController *thirdSlide;
@property (nonatomic, assign) NSInteger pendingIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end
