//
//  NavigationController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 03/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController {
    int menuOpen;
}

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *icoMenu;
@property (nonatomic, strong) CAShapeLayer *lineTopMenu;
@property (nonatomic, strong) CAShapeLayer *lineCenterMenu;
@property (nonatomic, strong) CAShapeLayer *lineBotMenu;

- (void) hideMenu;
- (void) showMenu;
- (void)whiteMenu;
- (void)resetColorMenu;

@end
