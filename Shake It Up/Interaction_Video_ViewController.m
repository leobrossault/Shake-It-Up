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

// Video Attributes
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@end

@implementation Interaction_Video_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationController *navigation = self.navigationController;
    [navigation hideMenu];
    
    // Do any additional setup after loading the view.
    nbTouch = 0;
    firstTouch = 0;
    videoEnded = 0;
    self.btnDiscoverProduct.hidden = true;
    
    // Get video and play
    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"pigeon" ofType:@"mp4"];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)videoDidFinishPlaying:(NSNotification *) notification {
    if (videoEnded == 0) {
        self.imgEndVideo.hidden = false;
        self.indicStart.hidden = false;
        self.btnDiscoverProduct.hidden = false;
        videoEnded = 1;
    }

    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"tropicale" ofType:@"mp4"];
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

- (IBAction)discoverProduct:(id)sender {
    [self.delegate videoDidFinish];
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
