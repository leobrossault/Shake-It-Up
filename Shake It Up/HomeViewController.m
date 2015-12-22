//
//  HomeViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 02/12/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "HomeViewController.h"
#import <pop/POP.h>
#import "User.h"
#import "ProductViewController.h"
#import "NavigationController.h"
#import "MixCenter_ContentViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *goMixBtn;
@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, strong) CALayer *point;
@property (weak, nonatomic) IBOutlet UIImageView *icoMixBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelMixBtn;
@property (nonatomic, strong) NSArray *userProducts;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger *selectedProduct;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationController *navigation = self.navigationController;
    [navigation showMenu];
    [navigation resetColorMenu];
    // Do any additional setup after loading the view.
    
    [navigation resetColorMenu];
    
    UITapGestureRecognizer *btnMix = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToMix:)];
    [self.goMixBtn addGestureRecognizer:btnMix];
    
    // Get User Data
    self.userProducts = [User sharedUser].userProducts;
    nbProduct = [self.userProducts count];
    nbCell = 10;
    countCell = 0;
    
    // Bottom Btn
    self.line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint: CGPointMake(25, 0)];
    self.line.path = linePath.CGPath;
    self.line.fillColor = nil;
    self.line.lineWidth = 2.5;
    self.line.strokeStart = 1;
    self.line.strokeEnd = 1;
    self.line.lineCap = kCALineCapRound;
    
    self.line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.line setFrame:CGRectMake(208, 48, 25, 2.5)];
    [self.goMixBtn.layer addSublayer:self.line];
    
    self.point = [CALayer layer];
    [self.point setMasksToBounds:YES];
    self.point.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [self.point setCornerRadius: 3.0f];
    self.point.frame = CGRectMake(208, 46.7, 6, 2.5);
    self.point.opacity = 0;
    
    [self.goMixBtn.layer addSublayer: self.point];
    
    // Collection
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.frame collectionViewLayout:layout];
    
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

- (void)viewDidAppear:(BOOL)animated {
    POPSpringAnimation *animLine = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    animLine.springSpeed = 10;
    animLine.springBounciness = 20.f;
    animLine.toValue = @(0.0);
    [self.line pop_addAnimation:animLine forKey:@"widthLine"];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.2);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        self.point.opacity = 1;
    });
    
    POPSpringAnimation *animPoint = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    animPoint.beginTime = CACurrentMediaTime() + 0.3;
    animPoint.springSpeed = 10;
    animPoint.springBounciness = 20.f;
    animPoint.fromValue = @(0.0);
    animPoint.toValue = @(-10.0);
    [self.point pop_addAnimation:animPoint forKey:@"leftPoint"];
    
    [UIView animateWithDuration: 0.3f animations:^{
        self.icoMixBtn.alpha = 1;
        CGRect frameIcoBtn = self.icoMixBtn.frame;
        frameIcoBtn.origin.y = self.icoMixBtn.frame.origin.y - 10;
        self.icoMixBtn.frame = frameIcoBtn;
        
        self.labelMixBtn.alpha = 1;
        CGRect frameLabelBtn = self.labelMixBtn.frame;
        frameLabelBtn.origin.x = self.labelMixBtn.frame.origin.x - 10;
        self.labelMixBtn.frame = frameLabelBtn;

    } completion:^(BOOL finished) {}];
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
    
    UIView *productView = [[UIView alloc] init];
    UIImageView *productImageView;
    UIImage *productImage = [[UIImage alloc] init];
    UILabel *productTitle = [[UILabel alloc] init];
    UILabel *productType = [[UILabel alloc] init];
    
    if (nbProduct > indexPath.row) {
        NSLog(@"%@", [[self.userProducts objectAtIndex: indexPath.row] objectForKey:@"pathMiniImg"]);
        productImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[self.userProducts objectAtIndex: indexPath.row] objectForKey:@"pathMiniImg"]]];
    } else {
        productImage = [UIImage imageNamed:@"default_product.png"];
    }
    
    [productView setFrame:CGRectMake(0, 0, 145, 200)];
    productView.tag = indexPath.row;
    cell.tag = indexPath.row;
    
    productImageView = [[UIImageView alloc] initWithImage: productImage];
    CGRect imgFrame = productImageView.frame;
    if (indexPath.row % 2 == 0) {
        imgFrame.origin.x = 25;
    } else {
        imgFrame.origin.x = 0;
    }
    
    imgFrame.origin.y = 0;
    imgFrame.size.width = 122;
    imgFrame.size.height = 122;
    productImageView.frame = imgFrame;
    
    [productTitle setFrame:CGRectMake(25, 125, 100, 40)];
    productTitle.textColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0];
    productTitle.font = [UIFont fontWithName:@"Bariol-Bold" size:22];
    productTitle.lineBreakMode = NSLineBreakByWordWrapping;
    productTitle.numberOfLines = 0;
    
    if (nbProduct > indexPath.row) {
        productTitle.text = [NSString stringWithFormat:@"%@", [[self.userProducts objectAtIndex: indexPath.row] objectForKey:@"label"]];
        
        if (indexPath.row % 2 != 0) {
            [productTitle setFrame:CGRectMake(0, 125, 100, 22)];
        }
    }
    
    [productType setFrame:CGRectMake(25, 160, 120, 40)];
    productType.textColor = [UIColor colorWithRed:0.16 green:0.06 blue:0.39 alpha:1.0];
    productType.font = [UIFont fontWithName:@"Bariol-Regular" size:18];
    productType.lineBreakMode = NSLineBreakByWordWrapping;
    productType.numberOfLines = 0;
    [productTitle sizeToFit];
    
    if (nbProduct > indexPath.row) {
//        productType.text = [NSString stringWithFormat:@"%@", [[self.userProducts objectAtIndex: indexPath.row] objectForKey:@"slogan"]];
        productType.text = @"Eau de toilette";
        if (indexPath.row % 2 != 0) {
            [productType setFrame:CGRectMake(0, 160, 120, 40)];
        }
    }
    
    if (nbProduct > indexPath.row) {
        UITapGestureRecognizer *goToProduct = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToProduct:)];
        [goToProduct setNumberOfTapsRequired: 1];
        [productView addGestureRecognizer:goToProduct];
    }
    
    [productView addSubview: productImageView];
    [productView addSubview: productTitle];
    [productView addSubview: productType];
    [cell addSubview:productView];
    countCell ++;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(145, 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToProduct"]) {
        ProductViewController *controller = (ProductViewController *)segue.destinationViewController;
        controller.product = self.selectedProduct;
    }
}

- (void)goToProduct:(UITapGestureRecognizer *) recognizer {
    UIView *selectedView = (UIView *)recognizer.view;
    self.selectedProduct = (NSInteger *)selectedView.tag;
    [self performSegueWithIdentifier:@"goToProduct" sender:recognizer];
}

- (void)goToMix:(UITapGestureRecognizer *) recognizer {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MixCenters" bundle:nil];
    MixCenter_ContentViewController *mixCenter = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:mixCenter animated:YES];
}

@end
