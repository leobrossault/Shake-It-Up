//
//  Store_Detail_ViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Store_Detail_ViewController : UIViewController {
    BOOL alreadyFav;
}

@property (strong, nonatomic) NSArray *selectedStore;
@property (assign, nonatomic) NSInteger *posSelectedStore;
@property (assign, nonatomic) BOOL myFav;

@end
