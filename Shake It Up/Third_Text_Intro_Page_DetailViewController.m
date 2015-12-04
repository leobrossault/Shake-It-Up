//
//  Third_Text_Intro_Page_DetailViewController.m
//  Shake It Up
//
//  Created by Léo Brossault on 30/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "Third_Text_Intro_Page_DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Third_Text_Intro_Page_DetailViewController ()
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (weak, nonatomic) IBOutlet UIView *thirdAnimContainer;


@end

@implementation Third_Text_Intro_Page_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"intro3" ofType:@"mp4"];
    self.urlVideo = [NSURL fileURLWithPath: self.pathVideo];
    self.asset = [AVAsset assetWithURL: self.urlVideo];
    self.playerItem = [[AVPlayerItem alloc] initWithAsset: self.asset];
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer: self.avPlayer];
    self.avPlayerLayer.frame = self.thirdAnimContainer.bounds;
    [self.thirdAnimContainer.layer addSublayer: self.avPlayerLayer];
    
    currentSlide = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkCurrent:(NSInteger) current {
    if (current == 2) {
        [self.avPlayer play];
    }
}

@end
