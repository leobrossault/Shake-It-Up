//
//  Interaction_Video_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoInteractionDelegate <NSObject>

- (void) videoDidFinish;

@end

@interface Interaction_Video_ViewController : UIViewController {
    int nbTouch;
    BOOL firstTouch;
    CGPoint lastPoint;
    BOOL videoEnded;
}

@property (nonatomic, weak) id <VideoInteractionDelegate> delegate;
@property (strong, nonatomic) NSDictionary *product;

@end
