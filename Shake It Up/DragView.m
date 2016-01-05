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
        self.colorValue = color;
        self.imageValue = path;
        //self.backgroundColor = color;
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.path withExtension:@"gif"];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        imageView.frame = CGRectMake(0.0, 0.0, 70.0, 70.0);
        [self addSubview:imageView];
    }
    
    return self;
}

@end
