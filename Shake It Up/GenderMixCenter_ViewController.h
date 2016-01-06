//
//  GenderMixCenter_ViewController.h
//  Shake It Up
//
//  Created by Jeremie drazic on 21/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "DragView.h"
#import "DropView.h"
#import "CircularLoaderView.h"

@protocol MixCenterDelegate <NSObject>

-(void) mixCenterDidFinish;

@end

@interface GenderMixCenter_ViewController : UIViewController

@property (nonatomic, weak) id <MixCenterDelegate> delegate;

@property (nonatomic) DragView *bottomRightItem;
@property (nonatomic) DragView *bottomLeftItem;
@property (nonatomic) DropView *dropZone;

@property (weak, nonatomic) IBOutlet DragView *draggedItem;

@property (assign, nonatomic) DragView *droppedItem;
@property (assign, nonatomic) DragView *previousDroppedItem;

@property (nonatomic) CircularLoaderView *progressTimer;

@property (nonatomic) NSTimer *timer;

@property (nonatomic) AppSettings *app;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) NSString *selectedGender;

@property (nonatomic, strong) UIView *overlay1;
@property (nonatomic, strong) UIView *overlay2;
@property (nonatomic, strong) UIView *overlay3;

@property (nonatomic, strong) UILabel *overlay1Line1;
@property (nonatomic, strong) UILabel *overlay1Line2;
@property (nonatomic, strong) UILabel *overlay2Line1;
@property (nonatomic, strong) UILabel *overlay2Line2;
@property (nonatomic, strong) UILabel *overlay3Line1;
@property (nonatomic, strong) UILabel *overlay3Line2;

@property (nonatomic, strong) UILabel *dropLabel1;
@property (nonatomic, strong) UILabel *dropLabel2;
@property (nonatomic, strong) UILabel *dropLabel3;

@property (nonatomic, strong) UIImageView *bottomRightRoundContainer1;
@property (nonatomic, strong) UIImage *bottomRightRound1;

@property (nonatomic, strong) UIImageView *bottomLeftRoundContainer1;
@property (nonatomic, strong) UIImage *bottomLeftRound1;

@property (nonatomic, strong) UIImageView *centerRoundContainer1;
@property (nonatomic, strong) UIImage *centerRound1;

@property (nonatomic, strong) UIImageView *bottomRightRoundContainer2;
@property (nonatomic, strong) UIImage *bottomRightRound2;

@property (nonatomic, strong) UIImageView *bottomLeftRoundContainer2;
@property (nonatomic, strong) UIImage *bottomLeftRound2;

@property (nonatomic, strong) UIImageView *centerRoundContainer2;
@property (nonatomic, strong) UIImage *centerRound2;

@property (nonatomic, strong) UIImageView *bottomRightRoundContainer3;
@property (nonatomic, strong) UIImage *bottomRightRound3;

@property (nonatomic, strong) UIImageView *bottomLeftRoundContainer3;
@property (nonatomic, strong) UIImage *bottomLeftRound3;

@property (nonatomic, strong) UIImageView *centerRoundContainer3;
@property (nonatomic, strong) UIImage *centerRound3;

@property (nonatomic, strong) UIImageView *centerTimerContainer3;
@property (nonatomic, strong) UIImage *centerTimer3;

@property (nonatomic, strong) UIImageView *dragIconContainer;
@property (nonatomic, strong) UIImage *dragIcon;

@property (nonatomic, strong) UIImageView *tapIconContainer;
@property (nonatomic, strong) UIImage *tapIcon;


@property int nbTouches;
@property int nbDrops;

- (void) buildInterface;

@end
