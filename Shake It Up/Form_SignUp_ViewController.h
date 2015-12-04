//
//  Form_SignUp_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FormSignUpDelegate <NSObject>

@end

@interface Form_SignUp_ViewController : UIViewController

@property (nonatomic, weak) id <FormSignUpDelegate> delegate;

@end
