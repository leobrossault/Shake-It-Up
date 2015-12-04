//
//  Action_Shaker_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import <pop/POP.h>

@protocol ActionShakerDelegate <NSObject>

@end

@interface Action_Shaker_ViewController : UIViewController {
    double currentMaxAccelX;
    double currentMaxAccelY;
    double currentMaxAccelZ;
    double currentMaxRotX;
    double currentMaxRotY;
    double currentMaxRotZ;
    BOOL isShake;
    BOOL loopAnim;
    BOOL loopGravity;
    BOOL overlayActive;
    BOOL shakeEnding;
    int countAnim;
    CGRect screenBound;
    int shakeValidation;
    int waterHigh;
    
    // SETTINGS
    float animDuration;
    float gravityLoopDuration;
    int nbShakeRequired;
    int coefAmpStart;
    int coefAmpShake;
    int nbDrops;
}

@property (nonatomic, weak) id <ActionShakerDelegate> delegate;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSMutableArray *shakeObjects;

@end
