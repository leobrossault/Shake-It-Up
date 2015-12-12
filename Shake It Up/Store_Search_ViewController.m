//
//  Store_Search_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Search_ViewController.h"
#import "NavigationController.h"

@interface Store_Search_ViewController ()<UITextFieldDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UITextField *inputSearch;
@property (weak, nonatomic) IBOutlet UIImageView *icoSearch;

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *stores;

@end

@implementation Store_Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
    
    nbCell = 3;
    
    self.searchField.layer.sublayerTransform = CATransform3DMakeTranslation(60, 0, 0);
    
    // Collection
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.frame collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    
    // Reset Y of collection
    CGRect collectionFrame = collectionView.frame;
    collectionFrame.origin.y = 0;
    collectionView.frame = collectionFrame;
    
    [self.scrollView addSubview:collectionView];

    if (self.favorites == 0) {
        [self nearStores];
    } else {
        [self favoriteStores];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) nearStores {
    NSLog(@"Get Location");
    // Get location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8000/api/store/all"]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", error);
            
        } else {
            // Data to Object
            NSArray *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
            self.stores = JSON;
            NSLog(@"%@", self.stores);
        }
    }] resume];
}

- (void) favoriteStores {
    self.inputSearch.hidden = true;
    self.icoSearch.hidden = true;
    self.titleView.text = @"Mes boutiques favorites";
    
    CGRect scrollFrame = self.scrollView.frame;
    scrollFrame.origin.y = 157;
    scrollFrame.size.height = 411;
    self.scrollView.frame = scrollFrame;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return nbCell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)myCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[myCollectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    // Avoid bug cells
    for (UIView *v in [cell subviews]) {
        [v removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    if (nbCell - 1 > indexPath.row) {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height, cell.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
        [cell.layer addSublayer:bottomBorder];
    }
    
    UIImageView *icoStore = [[UIImageView alloc] init];
    [icoStore setFrame:CGRectMake(20, 25, 35, 35)];
    [icoStore setImage:[UIImage imageNamed:@"ico_store"]];
    
    UIImageView *icoArrow = [[UIImageView alloc] init];
    [icoArrow setFrame:CGRectMake(260, 36, 15, 12)];
    [icoArrow setImage:[UIImage imageNamed:@"arrow_store"]];
    
    UILabel *titleStore = [[UILabel alloc] init];
    
    [cell addSubview: icoStore];
    [cell addSubview: icoArrow];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 85);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", [locations lastObject]);
}

- (void)requestAlwaysAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle: title
                                                                                   message: message
                                                                            preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alertView addAction: ok];
        [self presentViewController: alertView animated:YES completion:nil];
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

@end
