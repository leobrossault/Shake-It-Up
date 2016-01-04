//
//  DragView.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 04/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "DragView.h"

@implementation DragView

- (id)initWithFrame:(CGRect)frame andNbImages: (NSUInteger)nb andPath: (NSString *) path andColor: (UIColor*) color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 35.0;
        self.userInteractionEnabled = YES;
        self.originalPosition = self.center;
        
        self.nbImages = nb;
        self.path = path;
        self.backgroundColor = color;
        self.colorValue = color;
        self.imageValue = path;
        
        [self buildSprite];
        
    }
    return self;
}

- (void) buildSprite {
    //sprites
    NSMutableArray* imgArray = [[NSMutableArray alloc] initWithCapacity: self.nbImages];
    for(int i = 0; i < self.nbImages; i++) {
        
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat: self.path, i]];
        [imgArray addObject:image];
    }
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 70, 70)];
    animatedImageView.animationImages = imgArray;
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;
    [self addSubview: animatedImageView];
    [animatedImageView startAnimating];
}

- (void)dealloc
{
    NSLog(@"dragView %zd dealloc", self.tag);
}

@end
