//
//  BodyMixCenter_ViewController.m
//  Shake It Up
//
//  Created by Jeremie drazic on 21/12/15.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "BodyMixCenter_ViewController.h"
#import "Interaction_Video_ViewController.h"

@interface BodyMixCenter_ViewController ()<VideoInteractionDelegate>
{
    BOOL dragging;
    BOOL dropZoneFull;
    BOOL dropped;
}
@end

@implementation BodyMixCenter_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.app = [AppSettings sharedAppSettings];
    [self buildInterface];
}

#pragma mark - Interface

- (void) buildInterface {
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(37.0, 113.0, 245.0, 37.5)];
    self.descriptionLabel.font = self.app.font37;
    self.descriptionLabel.textAlignment = NSTextAlignmentRight;
    [self.descriptionLabel setAlpha:0.0];
    [self.view addSubview:self.descriptionLabel];
    
    self.bodyLabel.font = self.app.font18;
    self.bodyLabel.textColor = self.app.purple;
    
    [self drawDragViews];
    [self drawDropZone];
    [self drawProgressTimer];
}

- (void) drawDragViews {
    
    UIColor *color1 = [UIColor colorWithRed:253.0 / 255.0 green:13.0 / 255.0 blue:80.0 / 255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:122.0 / 255.0 green:224.0 / 255.0 blue:252.0 / 255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:91.0 / 255.0 green:45.0 / 255.0 blue:148.0 / 255.0 alpha:1];
    UIColor *color4 = [UIColor colorWithRed:255.0 / 255.0 green:241.0 / 255.0 blue:50.0 / 255.0 alpha:1];
    
    //DragView 1
    self.topLeftItem = [[DragView alloc] initWithFrame:CGRectMake(26.0, 165.0, 70.0, 70.0) andNbImages:25 andPath:@"round_body_01_%d.png" andColor:color1];
    self.topLeftItem.tag = 1;
    self.topLeftItem.value = @"Bouche";
    [self.view addSubview:self.topLeftItem];
    
    //DragView 2
    self.topRightItem = [[DragView alloc] initWithFrame:CGRectMake(227.0, 165.0, 70.0, 70.0) andNbImages:25 andPath:@"round_body_02_%d.png" andColor:color2];
    self.topRightItem.tag = 2;
    self.topRightItem.value = @"Visage";
    [self.view addSubview:self.topRightItem];
    
    //DragView 3
    self.bottomRightItem = [[DragView alloc] initWithFrame:CGRectMake(227.0, 455.0, 70.0, 70.0) andNbImages:25 andPath:@"round_body_03_%d.png" andColor:color3];
    self.bottomRightItem.tag = 3;
    self.bottomRightItem.value = @"Yeux";
    [self.view addSubview:self.bottomRightItem];
    
    //DragView 4
    self.bottomLeftItem = [[DragView alloc] initWithFrame:CGRectMake(26.0, 455.0, 70.0, 70.0) andNbImages:25 andPath:@"round_body_04_%d.png" andColor:color4];
    self.bottomLeftItem.tag = 4;
    self.bottomLeftItem.value = @"Corps entier";
    [self.view addSubview:self.bottomLeftItem];
}
- (void) drawDropZone {
    
    self.dropZone = [[DropView alloc] initWithFrame:CGRectMake(72.5, 258.0, 175.0, 175.0)];
    self.dropZone.backgroundColor = self.app.lightGrey;
    [self.view addSubview:self.dropZone];
    [self.view sendSubviewToBack:self.dropZone];
}

- (void) drawProgressTimer {
    
    CGRect frame = self.dropZone.frame;
    frame = CGRectInset(frame, -20, -20);
    self.progressTimer = [[CircularLoaderView alloc] initWithFrame:frame];
    [self.view addSubview:self.progressTimer];
    [self.view sendSubviewToBack:self.progressTimer];
    [self.progressTimer setNeedsDisplay];
}

#pragma mark - Drag & Drop

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.draggedItem = (DragView *) touch.view;
    
    //if object is a dragView and if there is only one touch
    if ([self.draggedItem isMemberOfClass:[DragView class]] && [touches count] == 1) {
        dragging = YES;
        self.descriptionLabel.text = self.draggedItem.value;
        self.descriptionLabel.textColor = self.draggedItem.colorValue;
        [self.descriptionLabel setAlpha:1.0];
        
    } else {
        dragging = NO;
    }
    
    if (dragging) {
        //if moved in drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            //anim scale
            [self.draggedItem pop_removeAllAnimations];
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
            scaleAnimation.springBounciness = 20.f;
            scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
            scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                //if scale not properly done
                if (self.draggedItem.transform.a != 1.0) {
                    self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                }
            };
            [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrag"];
            
            //put center under mouse pointer
            POPSpringAnimation *placeUnderPointerAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            placeUnderPointerAnimation.fromValue = [NSValue valueWithCGPoint:self.dropZone.center];
            placeUnderPointerAnimation.toValue = [NSValue valueWithCGPoint:touch.view.center];
            [self.draggedItem pop_addAnimation:placeUnderPointerAnimation forKey:@"placeUnderPointer"];
        }
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    // if touch object is a dragView and if dragging enabled
    if (dragging) {
        
        dropped = NO;
        CGPoint p = [touch locationInView:self.view];
        self.draggedItem.center = p;
        
        // if dragged in the drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            if (!dropZoneFull) {
                NSLog(@"drop zone was empty");
                
                //drop zone is full
                dropZoneFull = YES;
                
                //change droped item properties
                self.droppedItem = self.draggedItem;
                self.droppedItem.active = YES;
                
            } else if(dropZoneFull && self.draggedItem.tag != self.droppedItem.tag) {
                NSLog(@"drop zone was occupied and dropped item wasn't moved");
                
                // reposition current Active item
                self.previousDroppedItem = self.droppedItem;
                self.previousDroppedItem.active = NO;
                
                [self.previousDroppedItem pop_removeAllAnimations];
                POPSpringAnimation *returnAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
                returnAnimation.toValue = [NSValue valueWithCGPoint:self.previousDroppedItem.originalPosition];
                returnAnimation.springBounciness = 10;
                returnAnimation.springSpeed = 20.0f;
                [self.previousDroppedItem pop_addAnimation:returnAnimation forKey:@"returnToOriginalPosition"];
                
                POPSpringAnimation *unscaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                unscaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                unscaleAnimation.springBounciness = 20.f;
                unscaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                unscaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
                unscaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.previousDroppedItem.transform.a != 1.0) {
                        self.previousDroppedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                    }
                };
                [self.previousDroppedItem pop_addAnimation:unscaleAnimation forKey:@"unscaleOnItemReplacedInDropZone"];
                
                // replace by new dragged item
                self.droppedItem = self.draggedItem;
                self.droppedItem.active = YES;
            }
        }
        
        // if dragged out of the drop zone
        if (dropZoneFull && self.draggedItem.active && ![self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            dropZoneFull = NO;
            self.droppedItem = nil;
            self.previousDroppedItem = nil;
            self.draggedItem.active = NO;
            
            //anim unscale
            POPSpringAnimation *unscaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            unscaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
            unscaleAnimation.springBounciness = 20.f;
            unscaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
            unscaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                //if scale not properly done
                if (self.draggedItem.transform.a != 1.0) {
                    self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                }
            };
            [self.draggedItem pop_addAnimation:unscaleAnimation forKey:@"unscaleOnItemDraggedOutOfDropZone"];
            
        }
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (dragging) {
        
        [self.descriptionLabel setAlpha:0.0];
        
        //if moved out of drop zone
        if (![self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            //anim return to initial position
            [self.draggedItem pop_removeAllAnimations];
            POPSpringAnimation *returnAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
            returnAnimation.toValue = [NSValue valueWithCGPoint:self.draggedItem.originalPosition];
            returnAnimation.springBounciness = 10;
            returnAnimation.springSpeed = 20.0f;
            [self.draggedItem pop_addAnimation:returnAnimation forKey:@"returnToOriginalPosition"];
        }
        
        //if moved in drop zone
        if ([self.dropZone pointInside:[touch locationInView:self.dropZone] withEvent:nil]) {
            
            dropped = YES;
            self.progressTimer.circlePathColor = self.droppedItem.backgroundColor;
            [self startTimer];
            
            //if not in center of drop zone
            if (!CGPointEqualToPoint(self.draggedItem.center, self.dropZone.center)) {
                
                //anim return to center of drop zone
                [self.draggedItem pop_removeAllAnimations];
                POPSpringAnimation *returnToCenterAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
                returnToCenterAnimation.toValue = [NSValue valueWithCGPoint:self.dropZone.center];
                returnToCenterAnimation.springBounciness = 10;
                returnToCenterAnimation.springSpeed = 20.0f;
                [self.draggedItem pop_addAnimation:returnToCenterAnimation forKey:@"returnToOriginalPosition"];
                
                //anim scale
                POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                scaleAnimation.springBounciness = 20.f;
                scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.draggedItem.transform.a != 2.5) {
                        self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.5, 2.5);
                    }
                };
                [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrop"];
                
            } else {
                
                //anim scale
                [self.draggedItem pop_removeAllAnimations];
                POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
                scaleAnimation.springBounciness = 20.f;
                scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.5, 2.5)];
                scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    //if scale not properly done
                    if (self.draggedItem.transform.a != 2.5) {
                        self.draggedItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.5, 2.5);
                    }
                };
                [self.draggedItem pop_addAnimation:scaleAnimation forKey:@"scaleOnDrop"];
            }
        }
    }
}

#pragma mark - Loader

- (void) startTimer {
    
    CGFloat animDuration = 0.05;
    
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:animDuration target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        NSLog(@"timer started");
    }
}

- (void) stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"timer stopped");
    }
}

- (void) updateTimer:(NSTimer *) timer {
    if (dropped) {
        NSLog(@"timer updating");
        self.progressTimer.progress += 0.01;
    } else {
        NSLog(@"timer decreasing");
        self.progressTimer.progress -= 0.1;
    }
    
    [self.progressTimer setNeedsDisplay];
    
    if ((self.progressTimer.progress >= 1 ) && timer) {
        self.progressTimer.progress = 0;
        [self stopTimer];
        self.selectedBodyPart = self.droppedItem.value;

        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Video" bundle:nil];
        Interaction_Video_ViewController *video = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:video animated:YES];
    }
    
    if (self.progressTimer.progress < 0 && timer) {
        self.progressTimer.progress = 0;
        [self stopTimer];
    }
}

@end
