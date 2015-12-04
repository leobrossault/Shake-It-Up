//
//  CircularLoaderView.h
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 10/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView

@property (nonatomic) CAShapeLayer *circlePathLayer;
@property (nonatomic) CAShapeLayer *backgroundCirclePathLayer;
@property (nonatomic) UIColor *circlePathColor;
@property (assign, nonatomic) CGFloat circleRadius;
@property (assign, nonatomic) CGFloat progress;

@property (assign, nonatomic) AppSettings *app;

@end
