//
//  Third_Text_Intro_Page_DetailViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 30/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Third_Text_Intro_Page_DetailViewController : UIViewController {
    int currentSlide;
}

- (void) checkCurrent:(NSInteger) current;

@end
