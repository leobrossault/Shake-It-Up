//
//  Menu_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Menu;

@protocol MenuDelegate <NSObject>

@end

@interface Menu : UIViewController {
    int menuOpen;
}

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *icoMenu;
@property (nonatomic, strong) CAShapeLayer *lineTopMenu;
@property (nonatomic, strong) CAShapeLayer *lineCenterMenu;
@property (nonatomic, strong) CAShapeLayer *lineBotMenu;

+ (instancetype)visibleMenu;

- (void)openCloseMenu:(UITapGestureRecognizer *) recognizer;

@property (nonatomic, weak) id <MenuDelegate> delegate;

@end