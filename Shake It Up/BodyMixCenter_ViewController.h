//
//  BodyMixCenter_ViewController.h
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

@interface BodyMixCenter_ViewController : UIViewController

@property (nonatomic) DragView *topLeftItem;
@property (nonatomic) DragView *topRightItem;
@property (nonatomic) DragView *bottomRightItem;
@property (nonatomic) DragView *bottomLeftItem;
@property (nonatomic) DropView *dropZone;

@property (weak, nonatomic) IBOutlet DragView *draggedItem;

@property (assign, nonatomic) DragView *droppedItem;
@property (assign, nonatomic) DragView *previousDroppedItem;

@property (nonatomic) CircularLoaderView *progressTimer;

@property (nonatomic) NSTimer *timer;

@property (nonatomic) AppSettings *app;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) NSString *selectedBodyPart;

- (void) buildInterface;

@end
