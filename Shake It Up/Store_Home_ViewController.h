//
//  Store_Home_ViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreDefaultDelegate <NSObject>

@end

@interface Store_Home_ViewController : UIViewController

@property (nonatomic, weak) id <StoreDefaultDelegate> delegate;

@end
