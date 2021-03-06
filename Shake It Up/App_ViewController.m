//
//  App_ViewController.m
//  Shake It Up
//
//  Created by BROSSAULT Leo on 02/11/2015.
//  Copyright © 2015 BROSSAULT Leo. All rights reserved.
//

#import "NavigationController.h"
#import "App_ViewController.h"
#import "MixCenter_ViewController.h"
#import "Text_Intro_PageViewController.h"
#import "Action_Shaker_ViewController.h"
#import "Interaction_Video_ViewController.h"
#import "MixCenter_ContentViewController.h"
#import "GenderMixCenter_ViewController.h"
#import "BodyMixCenter_ViewController.h"
#import "HomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface App_ViewController () <ActionShakerDelegate, VideoInteractionDelegate, Home_DefaultDelegate>

// Video Attributes
@property (strong, nonatomic) NSString *pathVideo;
@property (strong, nonatomic) NSURL *urlVideo;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@end

@implementation App_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavigationController *navigation = (NavigationController *)self.navigationController;
    [navigation hideMenu];
    
    // Splashscreen
    // Get video and play
    
    self.pathVideo = [[NSBundle mainBundle] pathForResource:@"splashscreen" ofType:@"mp4"];
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)goToIntro:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Intro" bundle:nil];
    Text_Intro_PageViewController *intro = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:intro animated:YES];
}

- (IBAction)goToMixCenter:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MixCenters" bundle:nil];
    MixCenter_ContentViewController *mixCenter = [sb instantiateInitialViewController];
    
    [self.navigationController pushViewController:mixCenter animated:YES];
}

- (IBAction)goToGenderMixCenter:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GenderMixCenter" bundle:nil];
    GenderMixCenter_ViewController *gendeMixCenter = [sb instantiateInitialViewController];
    
    [self.navigationController pushViewController:gendeMixCenter animated:YES];
}

- (IBAction)goToBodyMixCenter:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BodyPartMixCenter" bundle:nil];
    BodyMixCenter_ViewController *bodyMixCenter = [sb instantiateInitialViewController];
    
    [self.navigationController pushViewController:bodyMixCenter animated:YES];
}

- (IBAction)goToShaker:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Shaker" bundle:nil];
    Action_Shaker_ViewController *shaker = [sb instantiateInitialViewController];
    shaker.delegate = self;
    [self.navigationController pushViewController:shaker animated:YES];
}

- (IBAction)goToVideo:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Video" bundle:nil];
    Interaction_Video_ViewController *video = [sb instantiateInitialViewController];
    video.delegate = self;
    [self.navigationController pushViewController:video animated:YES];
}

- (IBAction)launchApp:(id)sender {
    if ([self isFirstRunning] == YES) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Intro" bundle:nil];
        Text_Intro_PageViewController *intro = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:intro animated:YES];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        HomeViewController *home = [sb instantiateInitialViewController];
        home.delegate = self;
        [self.navigationController pushViewController:home animated:YES];
        
    }
}

- (BOOL) isFirstRunning {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isFirstRun"]) {
        return NO;
    }
    
    [defaults setObject:[NSDate date] forKey:@"isFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

#pragma mark - MixCenterDelegate


- (void) videoDidFinish {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)videoDidFinishPlaying:(NSNotification *) notification {
    if ([self isFirstRunning] == YES) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Intro" bundle:nil];
        Text_Intro_PageViewController *intro = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:intro animated:NO];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        HomeViewController *home = [sb instantiateInitialViewController];
        home.delegate = self;
        [self.navigationController pushViewController:home animated:NO];
    }
}

@end
