//
//  DropView.m
//  Shake It Up
//
//  Created by DRAZIC Jeremie on 04/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "DropView.h"

@implementation DropView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //load app settings
        self.app = [AppSettings sharedAppSettings];
        
        //change corner radius
        self.layer.cornerRadius = 87.5;
        
        //set drop zone label
        self.dropZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.dropZoneLabel.backgroundColor = [UIColor clearColor];
        self.dropZoneLabel.font = self.app.font12;
        self.dropZoneLabel.textColor = self.app.purple;
        self.dropZoneLabel.text = [@"Déposer ici" uppercaseString];
        self.dropZoneLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dropZoneLabel];
    }
    return self;
}

@end
