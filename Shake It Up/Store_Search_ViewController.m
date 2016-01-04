//
//  Store_Search_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Search_ViewController.h"
#import "NavigationController.h"
#import "Store.h"
#import "Store_Detail_ViewController.h"
#import "User.h"


@interface Store_Search_ViewController ()<UITextFieldDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UITextField *inputSearch;
@property (weak, nonatomic) IBOutlet UIImageView *icoSearch;

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign, nonatomic) NSArray *selectedStore;

@property (strong, nonatomic) NSArray *stores;
@property (strong, nonatomic) NSMutableArray *searchStores;
@property (weak, nonatomic) IBOutlet UILabel *indicSearch;
@property (assign, nonatomic) NSInteger *posSelectedStore;

@property (strong, nonatomic) NSDictionary *user;

@end

@implementation Store_Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
    [navigation resetColorMenu];
    
    self.searchField.layer.sublayerTransform = CATransform3DMakeTranslation(60, 0, 0);
    getDist = 0;
    
    self.stores = [Store sharedStore].store;
    
    if (self.favorites == 0) {
        self.searchStores = [[NSMutableArray alloc] initWithArray: self.stores];
        nbCell = [self.searchStores count];
        [self nearStores];
    } else {
        self.user = [User sharedUser].user;
        self.searchStores = [[NSMutableArray alloc] init];
        
        for (int h = 0; h < [self.stores count]; h ++) {
            for (int k = 0; k < [[self.user objectForKey:@"stores"] count]; k ++) {
                if ([[[self.stores objectAtIndex: h] objectForKey:@"_id"] isEqualToString: [[[self.user objectForKey:@"stores"] objectAtIndex:k] objectForKey:@"_id"]]) {
                    [self.searchStores addObject: [self.stores objectAtIndex: h]];
                    nbCell = [self.searchStores count];
                }
            }
        }
        
        [self favoriteStores];
    }
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) nearStores {
    // Get location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}

- (void) favoriteStores {
    self.inputSearch.hidden = true;
    self.icoSearch.hidden = true;
    self.titleView.text = @"Mes boutiques favorites";
    
    CGRect scrollFrame = self.scrollView.frame;
    scrollFrame.origin.y = 157;
    scrollFrame.size.height = 411;
    self.scrollView.frame = scrollFrame;
    
    if (nbCell == 0) {
        self.indicSearch.hidden = false;
        self.indicSearch.text = @"Tu n'as enregistré aucun magasin en favoris";
    }
}

- (void) buildCollection {
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
    if (self.favorites == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.161 green:0.059 blue:0.388 alpha:1];
    }
    
    if (nbCell - 1 > indexPath.row) {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height, cell.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0].CGColor;
        [cell.layer addSublayer:bottomBorder];
    }
    
    UIImageView *icoStore = [[UIImageView alloc] init];
    [icoStore setFrame:CGRectMake(20, 25, 35, 35)];
    
    if (self.favorites == 0) {
        [icoStore setImage:[UIImage imageNamed:@"ico_store"]];
    } else {
        [icoStore setImage:[UIImage imageNamed:@"ico_store_favorite"]];
    }
    
    UIImageView *icoArrow = [[UIImageView alloc] init];
    [icoArrow setFrame:CGRectMake(260, 36, 15, 12)];
    [icoArrow setImage:[UIImage imageNamed:@"arrow_store"]];
    
    UILabel *titleStore = [[UILabel alloc] init];
    [titleStore setFrame:CGRectMake(70, 12, 180, 20)];
    titleStore.text = [[[self.searchStores objectAtIndex: indexPath.row] objectForKey:@"title"] uppercaseString];
    titleStore.textColor = [UIColor whiteColor];
    titleStore.font = [UIFont fontWithName:@"Bariol-Bold" size:19];
    
    UILabel *street = [[UILabel alloc] init];
    [street setFrame:CGRectMake(70, 38, 180, 20)];
    street.text = [[self.searchStores objectAtIndex: indexPath.row] objectForKey:@"street"];
    street.textColor = [UIColor whiteColor];
    street.font = [UIFont fontWithName:@"Bariol-Regular" size:14];
    
    UILabel *city = [[UILabel alloc] init];
    [city setFrame:CGRectMake(70, 53, 180, 20)];
    city.text = [NSString stringWithFormat:@"%@ %@",[[self.searchStores objectAtIndex: indexPath.row] objectForKey:@"postalCode"], [[self.searchStores objectAtIndex: indexPath.row] objectForKey:@"city"]];
    city.textColor = [UIColor whiteColor];
    city.font = [UIFont fontWithName:@"Bariol-Regular" size:14];
    
    cell.tag = indexPath.row;
    
    UITapGestureRecognizer *goToStore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToStore:)];
    [goToStore setNumberOfTapsRequired: 1];
    [cell addGestureRecognizer:goToStore];
    
    [cell addSubview: icoStore];
    [cell addSubview: icoArrow];
    [cell addSubview: titleStore];
    [cell addSubview: street];
    [cell addSubview: city];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 85);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    float lat1 = locationManager.location.coordinate.latitude;
    float long1 = locationManager.location.coordinate.longitude;
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:long1];
    
    if (getDist == 0) {
        for (int p = 0; p < [self.stores count]; p ++) {
            float lat2 = [[[self.stores objectAtIndex: p] objectForKey:@"latitude"] floatValue];
            float long2 = [[[self.stores objectAtIndex: p] objectForKey:@"longitude"] floatValue];
        
            CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat2 longitude:long2];
            CLLocationDistance distance = [locA distanceFromLocation:locB];
        
            // Sort store in array
//            [[self.searchStores objectAtIndex: p] objectForKey:@"distance"] = distance;
            NSLog(@"%f", distance);
            
            if (p >= [self.stores count] -1) {
                getDist = 1;
            }
        }
    }
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToDetailStore"]) {
        Store_Detail_ViewController *controller = (Store_Detail_ViewController *)segue.destinationViewController;
        controller.selectedStore = self.selectedStore;
        controller.posSelectedStore = self.posSelectedStore;
        controller.myFav = self.favorites;
    }
}

- (void)goToStore:(UITapGestureRecognizer *) recognizer {
    UIView *selectedView = (UIView *)recognizer.view;
//    self.selectedStore = [self.searchStores objectAtIndex: selectedView.tag];
    self.selectedStore = self.searchStores;
    self.posSelectedStore = (NSInteger *)selectedView.tag;
    [self performSegueWithIdentifier:@"goToDetailStore" sender:recognizer];
}

// Search Store
- (void)searchStore: (NSString *) param {
    [self.searchStores removeAllObjects];
    
    if (![param isEqualToString:@""]) {
        for (int j = 0; j < [self.stores count]; j ++) {
            NSArray *titleWords = [[[self.stores objectAtIndex: j] objectForKey:@"title"] componentsSeparatedByString: @" "];
            NSArray *streetWords = [[[self.stores objectAtIndex: j] objectForKey:@"street"] componentsSeparatedByString: @" "];
            NSString *cityWords = [[self.stores objectAtIndex: j] objectForKey:@"city"];
            NSString *postalCode = [[self.stores objectAtIndex: j] objectForKey:@"postalCode"];
        
            int countWords = [titleWords count] + [streetWords count] + 2;
            BOOL match = false;
        
            NSMutableArray *mutableWords = [NSMutableArray arrayWithCapacity: countWords];
        
            [mutableWords addObjectsFromArray:titleWords];
            [mutableWords addObjectsFromArray:streetWords];
            [mutableWords addObject:cityWords];
            [mutableWords addObject:postalCode];
        
            for (int k = 0; k < [mutableWords count]; k ++) {
                if ([[param lowercaseString] isEqualToString: [[mutableWords objectAtIndex: k]lowercaseString]]) {
                    match = true;
                }
            
                if (match == true && k >= [mutableWords count] - 1) {
                    [self.searchStores addObject: [self.stores objectAtIndex: j]];
                    nbCell = [self.searchStores count];
                    [collectionView reloadData];
                    self.indicSearch.hidden = true;
                }
            }
        
            if (j >= [self.stores count] - 1 && [self.searchStores count] == 0) {
                nbCell = 0;
                [collectionView reloadData];
                self.indicSearch.hidden = false;
            }
        }
    } else {
        for (int m = 0; m < [self.stores count]; m ++) {
            [self.searchStores addObject: [self.stores objectAtIndex: m]];
            
            if (m >= [self.stores count] - 1) {
                nbCell = [self.searchStores count];
                [collectionView reloadData];
                self.indicSearch.hidden = true;
            }
        }
    }
}

#pragma Hide Keyboard

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchStore: textField.text];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self searchStore: textView.text];
        return NO;
    }
    
    return YES;
}

@end
