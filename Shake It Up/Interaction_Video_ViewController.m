//
//  Interaction_Video_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Interaction_Video_ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "NavigationController.h"

@interface Interaction_Video_ViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *imgEndVideo;
@property (assign, nonatomic) UITouch *globalTouch;
@property (weak, nonatomic) IBOutlet UILabel *indicStart;
@property (weak, nonatomic) IBOutlet UIButton *btnDiscoverProduct;
@property (weak, nonatomic) IBOutlet UIImageView *icoBtnDiscover;

// Video Attributes
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

//Overlay
@property (weak, nonatomic) IBOutlet UIView *overlay;

@end

@implementation Interaction_Video_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationController *navigation = self.navigationController;
    [navigation hideMenu];
    
    // Get actual Product
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Remove previous View Controller
    NSInteger count = [self.navigationController.viewControllers count];
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex: count - 2];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    // Do any additional setup after loading the view.
    nbTouch = 0;
    firstTouch = 0;
    videoEnded = 0;
    self.btnDiscoverProduct.hidden = true;
    self.icoBtnDiscover.hidden = true;
    
    // Img end Video
    NSString *pathImg = [NSString stringWithFormat:@"%@_3", [[defaults objectForKey:@"actualProduct"] objectForKey:@"video"]];
    [self.imgEndVideo setImage:[UIImage imageNamed: pathImg]];
    
    // Get video and play
    NSString *path = [NSString stringWithFormat:@"%@_1", [[defaults objectForKey:@"actualProduct"] objectForKey:@"video"]];
    self.pathVideo = [[NSBundle mainBundle] pathForResource: path ofType:@"mp4"];
    self.urlVideo = [NSURL fileURLWithPath: self.pathVideo];
    self.asset = [AVAsset assetWithURL: self.urlVideo];
    self.playerItem = [[AVPlayerItem alloc] initWithAsset: self.asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer: self.avPlayer];
    
    // Send notification when ended
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object: self.playerItem];
    
    self.avPlayerLayer.frame = self.view.bounds;
    [self.videoView.layer addSublayer: self.avPlayerLayer];
    [self.avPlayer play];
    
    #pragma init overlay
    self.overlay.backgroundColor = [UIColor colorWithRed:0.06 green:0.01 blue:0.26 alpha:0.9];
    
    UITapGestureRecognizer *tapOverlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayAction:)];
    [self.overlay addGestureRecognizer:tapOverlay];
    
    // Line bottom btn
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint: CGPointMake(25, 0)];
    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.lineWidth = 2.5;
    line.strokeStart = 0;
    line.strokeEnd = 1;
    line.lineCap = kCALineCapRound;
    line.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [line setFrame:CGRectMake(146, 30, 25, 2.5)];
    [self.btnDiscoverProduct.layer addSublayer:line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)videoDidFinishPlaying:(NSNotification *) notification {
    if (videoEnded == 0) {
        self.imgEndVideo.hidden = false;
        self.icoBtnDiscover.hidden = false;
        self.btnDiscoverProduct.hidden = false;
        videoEnded = 1;
        
        [UIView animateWithDuration: 1.0 animations:^(void) {
            self.overlay.alpha = 1;
        }];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [NSString stringWithFormat:@"%@_2", [[defaults objectForKey:@"actualProduct"] objectForKey:@"video"]];
    self.pathVideo = [[NSBundle mainBundle] pathForResource: path ofType:@"mp4"];
    self.urlVideo = [NSURL fileURLWithPath: self.pathVideo];
    self.asset = [AVAsset assetWithURL: self.urlVideo];
    self.playerItem = [[AVPlayerItem alloc] initWithAsset: self.asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer: self.avPlayer];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object: self.playerItem];
    
    self.avPlayerLayer.frame = self.view.bounds;
    [self.videoView.layer addSublayer: self.avPlayerLayer];
    [self.avPlayer play];
    videoEnded = 1;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.globalTouch = touch;
    lastPoint = [touch locationInView:self.view];
    firstTouch = 0;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (firstTouch == 0) {
        firstTouch = 1;
        nbTouch ++;
    }
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.imgEndVideo.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    if (nbTouch < 2 ) {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.0);
        self.indicStart.hidden = true;
    } else {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 100.0);
    }
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
    self.imgEndVideo.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}

- (void) overlayAction:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration: 1.0 animations:^(void) {
        self.overlay.alpha = 0;
    }];
}

- (IBAction)discoverProduct:(id)sender {
//    [self.delegate videoDidFinish];
    [self performSegueWithIdentifier:@"discoverProduct" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"discoverProduct"]) {
        //Send data
//        [self.avPlayer replaceCurrentItemWithPlayerItem: NULL];
        [self.avPlayer pause];
    }
}


@end
