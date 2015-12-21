//
//  DragView.h
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 04/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragView : UIView

@property (nonatomic) NSUInteger nbImages;
@property (nonatomic) NSString *path;
@property (nonatomic) NSString *value;
@property (nonatomic) UIColor *colorValue;
@property (nonatomic) NSString *imageValue;
@property (nonatomic) NSString *soundValue;

@property (assign, nonatomic) BOOL active;
@property (assign, nonatomic) CGPoint originalPosition;

- (id)initWithFrame:(CGRect)frame andNbImages: (NSUInteger)nb andPath: (NSString *) path andColor: (UIColor *) color;

@end