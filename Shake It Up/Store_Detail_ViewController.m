//
//  Store_Detail_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Detail_ViewController.h"
#import "Store_Search_ViewController.h"
#import "User.h"
@import MapKit;

@interface Store_Detail_ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UILabel *streetDetail;
@property (weak, nonatomic) IBOutlet UILabel *cityDetail;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *favoriteView;
@property (weak, nonatomic) IBOutlet UIImageView *ico_star_empty;
@property (weak, nonatomic) IBOutlet UIImageView *ico_star_full;
@property (weak, nonatomic) IBOutlet UIImageView *ico_store;

@property (strong, nonatomic) NSDictionary *user;
@property (strong, nonatomic) User *objectUser;

@end

@implementation Store_Detail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get user
    self.user = [User sharedUser].user;
    self.objectUser = [User sharedUser];
    
    // Check if is already in fav
    alreadyFav = false;
    
    for (int k = 0; k < [[self.user objectForKey:@"stores"] count]; k ++) {
        if ([[[[self.user objectForKey:@"stores"] objectAtIndex:k] objectForKey:@"_id"] isEqualToString:[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"_id"]]) {
            self.ico_star_empty.alpha = 0;
            self.ico_star_full.alpha = 1;
            alreadyFav = true;
        }
    }
    
    // Init Text
    if (alreadyFav == true) {
        self.containerDetail.backgroundColor = [UIColor colorWithRed:0.161 green:0.059 blue:0.388 alpha:1];
    } else {
        self.containerDetail.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    }
    
    self.titleDetail.text = [[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"title"] uppercaseString];
    self.streetDetail.text = [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"street"];
    self.cityDetail.text = [NSString stringWithFormat:@"%@ %@", [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"postalCode"], [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"city"]];
    
    if (alreadyFav == true) {
        [self.ico_store setImage: [UIImage imageNamed:@"ico_store_favorite"]];
    }
    
    // Get location
    MKCoordinateRegion region;
    CLLocation *locObj = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"latitude"] doubleValue], [[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"longitude"] doubleValue])
                                                       altitude:0
                                             horizontalAccuracy:0
                                               verticalAccuracy:0
                                                      timestamp:[NSDate date]];
    region.center = locObj.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.05; // values for zoom
    span.longitudeDelta = 0.05;
    region.span = span;
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits: region];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = locObj.coordinate;
    point.title = [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"title"];
    
    [self.mapView addAnnotation:point];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    // Add in favorites
    UITapGestureRecognizer *addFav = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFavorite:)];
    [addFav setNumberOfTapsRequired: 1];
    [self.favoriteView addGestureRecognizer:addFav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.image = [UIImage imageNamed:@"ico_marker"];
    annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)addFavorite: (UITapGestureRecognizer *)recognizer {
    if (alreadyFav == false) {
        NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/store/%@/%@", [self.user objectForKey:@"email"], [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"_id"]];
        
        self.ico_star_empty.alpha = 0;
        self.ico_star_full.transform = CGAffineTransformMakeScale(2, 2);
        
        [UIView animateWithDuration: 0.3f animations:^{
            self.ico_star_full.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.ico_star_full.alpha = 1;
        }];
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.timeoutIntervalForResource = 30;
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                NSLog(@"%@", error);
            }
        }] resume];
        alreadyFav = true;
    } else {
        NSString *url = [NSString stringWithFormat: @"http://37.187.118.146:8000/api/store/delete/%@/%@", [self.user objectForKey:@"email"], [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"_id"]];
        
        self.ico_star_empty.alpha = 1;
        self.ico_star_full.transform = CGAffineTransformMakeScale(1, 1);
        
        [UIView animateWithDuration: 0.3f animations:^{
            self.ico_star_full.transform = CGAffineTransformMakeScale(2.0, 2.0);
            self.ico_star_full.alpha = 0;
        }];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.timeoutIntervalForResource = 30;
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                NSLog(@"%@", error);
            }
        }] resume];
        alreadyFav = false;
    }
    
    [self performSelector:@selector(reloadData) withObject:self afterDelay: 1];
}

- (void) reloadData {
    [self.objectUser loadDataUser];
    self.user = [User sharedUser].user;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"returnAllStore"]) {
        Store_Search_ViewController *controller = (Store_Search_ViewController *)segue.destinationViewController;
        controller.favorites = self.myFav;
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
