//
//  ReverseTransition.m
//  Shake It Up
//
//  Created by Léo Brossault on 05/01/2016.
//  Copyright © 2016 BROSSAULT Leo. All rights reserved.
//

#import "ReverseTransition.h"

@implementation ReverseTransition

- (void) perform {
    [[[self sourceViewController] navigationController] pushViewController:[self destinationViewController] animated:NO];
}

@end
