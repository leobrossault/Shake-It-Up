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
        UILabel *dropZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        dropZoneLabel.backgroundColor = [UIColor clearColor];
        dropZoneLabel.font = self.app.font12;
        dropZoneLabel.textColor = self.app.purple;
        dropZoneLabel.text = [@"Déposer ici" uppercaseString];
        dropZoneLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dropZoneLabel];
    }
    return self;
}

@end
