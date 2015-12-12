//
//  Store_Detail_ViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 09/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Store_Detail_ViewController.h"
@import MapKit;

@interface Store_Detail_ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UILabel *streetDetail;
@property (weak, nonatomic) IBOutlet UILabel *cityDetail;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation Store_Detail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.containerDetail.backgroundColor = [UIColor colorWithRed:0.98 green:0.15 blue:0.35 alpha:1.0];
    self.titleDetail.text = [[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"title"] uppercaseString];
    self.streetDetail.text = [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"street"];
    self.cityDetail.text = [NSString stringWithFormat:@"%@ %@", [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"postalCode"], [[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"city"]];
    
    // Get location
    MKCoordinateRegion region;
    CLLocation *locObj = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"latitude"] doubleValue], [[[self.selectedStore objectAtIndex: (int)self.posSelectedStore] objectForKey:@"longitude"] doubleValue])
                                                       altitude:0
                                             horizontalAccuracy:0
                                               verticalAccuracy:0
                                                      timestamp:[NSDate date]];
    region.center = locObj.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta  = 1; // values for zoom
    span.longitudeDelta = 1;
    region.span = span;
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits: region];
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    [self.mapView addAnnotation: marker];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
