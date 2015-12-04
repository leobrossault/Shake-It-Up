//
//  Second_Text_Intro_Page_DetailViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 30/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Second_Text_Intro_Page_DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Second_Text_Intro_Page_DetailViewController ()
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (weak, nonatomic) IBOutlet UIView *secondAnimContainer;

@end

@implementation Second_Text_Intro_Page_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"intro2" ofType:@"mp4"];
    self.urlVideo = [NSURL fileURLWithPath: self.pathVideo];
    self.asset = [AVAsset assetWithURL: self.urlVideo];
    self.playerItem = [[AVPlayerItem alloc] initWithAsset: self.asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer: self.avPlayer];
    
    self.avPlayerLayer.frame = self.secondAnimContainer.bounds;
    [self.secondAnimContainer.layer addSublayer: self.avPlayerLayer];
    [self.avPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
