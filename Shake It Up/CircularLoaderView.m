//
//  CircularLoaderView.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 10/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "CircularLoaderView.h"

@interface CircularLoaderView ()

@end

@implementation CircularLoaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.app = [AppSettings sharedAppSettings];
        
        self.circlePathLayer = [CAShapeLayer layer];
        self.circlePathLayer.lineCap = kCALineCapRound;

        self.progress = 0.0;
        self.backgroundCirclePathLayer = [CAShapeLayer layer];
        self.circleRadius = frame.size.width / 2.0;
        
        [self setOpaque:NO];
        [self.layer addSublayer:self.backgroundCirclePathLayer];
        [self.layer addSublayer:self.circlePathLayer];
    }
    return self;
}

//  Only override drawRect: if you perform custom drawing.
//  An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
{
    if (self.progress == 0.0) {
        self.circlePathLayer.strokeEnd = 0;
        
    } else if (self.progress > 1) {
        self.circlePathLayer.strokeEnd = 1;
        
    } else {
        self.circlePathLayer.strokeEnd = self.progress;
    }
    
    [self drawBackgroundCircle];
    [self drawCircle];
}

#pragma mark - CirclePath

-(void) drawCircle
{
    self.circlePathLayer.lineWidth = 4;
    if (self.circlePathColor == NULL) {
        self.circlePathLayer.strokeColor = [UIColor colorWithRed:0 green:0.737 blue:0.831 alpha:1].CGColor;
    } else {
        self.circlePathLayer.strokeColor = self.circlePathColor.CGColor;
    }
    
    self.circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    self.circlePathLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CGRect circleFame = CGRectMake(0, 0, 2 * self.circleRadius, 2 * self.circleRadius);
    [self.circlePathLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:circleFame] CGPath]];
}

- (void) drawBackgroundCircle
{
    self.backgroundCirclePathLayer.lineWidth = 0.5;
    self.backgroundCirclePathLayer.strokeColor = self.app.purple.CGColor;
    self.backgroundCirclePathLayer.fillColor = [UIColor clearColor].CGColor;
    self.backgroundCirclePathLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CGRect circleFame = CGRectMake(0, 0, 2 * self.circleRadius, 2 * self.circleRadius);
    [self.backgroundCirclePathLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:circleFame] CGPath]];
}

@end
