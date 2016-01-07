//
//  Store_Search_ViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Store_Search_ViewController : UIViewController <CLLocationManagerDelegate> {
    UICollectionView *collectionView;
    NSUInteger nbCell;
    CLLocationManager *locationManager;
    BOOL getDist;
}

@property (nonatomic, assign) BOOL favorites;

@end
