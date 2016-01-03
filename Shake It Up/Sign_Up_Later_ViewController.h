//
//  Sign_Up_Later_ViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 03/01/2016.
//  Copyright © 2016 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignUpDelegate <NSObject>

@end

@interface Sign_Up_Later_ViewController : UIViewController

@property (nonatomic, weak) id <SignUpDelegate> delegate;

@end
