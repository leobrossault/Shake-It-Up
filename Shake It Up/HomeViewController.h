//
//  HomeViewController.h
//  Shake It Up
//
//  Created by Léo Brossault on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Home_DefaultDelegate <NSObject>

@end

@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *collectionView;
    int nbProduct;
    int nbCell;
    int countCell;
    BOOL productNotLoaded;
    BOOL didLoad;
}

@property (nonatomic, weak) id <Home_DefaultDelegate> delegate;

@end
