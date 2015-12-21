//
//  MixCenter_ViewController.h
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
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

@interface MixCenter_ViewController : UIViewController

@property (nonatomic, weak) id <MixCenterDelegate> delegate;

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
@property (nonatomic) Environment *e;
@property (nonatomic) NSArray *ingredients;
@property (nonatomic) NSString *mixCenterType;

@property (weak, nonatomic) IBOutlet UILabel *emotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel;
@property (weak, nonatomic) IBOutlet UILabel *textureLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) NSString *selectedIngredient;
@property (nonatomic, strong) NSString *selectedIngredientImageName;
@property (nonatomic, strong) NSString *selectedIngredientName;
@property (nonatomic, strong) UIColor *selectedIngredientColor;

- (void) buildInterface;

@end