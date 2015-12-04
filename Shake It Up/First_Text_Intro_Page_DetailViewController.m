//
//  Text_Intro_Page_DetailViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 06/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "First_Text_Intro_Page_DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface First_Text_Intro_Page_DetailViewController ()
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (weak, nonatomic) IBOutlet UIView *firstAnimContainer;
@end

@implementation First_Text_Intro_Page_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"intro1" ofType:@"mp4"];
    self.urlVideo = [NSURL fileURLWithPath: self.pathVideo];
    self.asset = [AVAsset assetWithURL: self.urlVideo];
    self.playerItem = [[AVPlayerItem alloc] initWithAsset: self.asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer: self.avPlayer];

    self.avPlayerLayer.frame = self.firstAnimContainer.bounds;
    [self.firstAnimContainer.layer addSublayer: self.avPlayerLayer];
    [self.avPlayer play];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
