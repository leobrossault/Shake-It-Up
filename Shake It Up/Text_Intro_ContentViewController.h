//
//  Text_Intro_ContentViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Text_Intro_ContentViewController : UIViewController {
    int prevPage;
}

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void) setCurrentPage:(NSInteger)currentPage;

@end
