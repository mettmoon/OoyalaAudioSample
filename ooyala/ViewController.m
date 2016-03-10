//
//  ViewController.m
//  ooyala
//
//  Created by Moon Hayden on 3/10/16.
//  Copyright © 2016 unkown. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <OoyalaSDK/OOOoyalaAPIClient.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>

const NSString *ooyalaAPIKey = @"<#OoyalaAPIKey#>";
const NSString *ooyalaSecretKey = @"<#OoyalaSecretKey#>";
const NSString *pcode = @"<#PCODE#>";
const NSString *domainString = @"https://api.ooyala.com";
const NSString *embedCode = @"<#EmbedCode#>";



@interface ViewController ()
@property (nonatomic, strong) OOOoyalaPlayerViewController *playerViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error){
        NSLog(@"error in setCategory:%@",error.description);
    }
    error = nil;
    [[AVAudioSession sharedInstance] setActive:true error:&error];
    if (error){
        NSLog(@"error in setActive:%@",error.description);
    }
    error = nil;
    
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (error) {
        NSLog(@"error in overrideOutputAudioPort:%@",error.description);
    }
    OOPlayerDomain *playerDomain = [[OOPlayerDomain alloc] initWithString:domainString];
    OOOoyalaAPIClient *apiClient = [[OOOoyalaAPIClient alloc] initWithAPIKey:ooyalaAPIKey secret:ooyalaSecretKey pcode:pcode domain:playerDomain];
    OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithOoyalaAPIClient:apiClient];
    OOOoyalaPlayerViewController *playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
    
    self.playerViewController = playerViewController;
    [self addChildViewController:playerViewController];
    [player setActionAtEnd:OOOoyalaPlayerActionAtEndStop];
    [playerViewController.player setEmbedCode:embedCode];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:nil object:playerViewController.player];
}
- (void)notificationHandler:(NSNotification *)noti{
    NSString *name = noti.name;
    if ([name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
        if (self.playerViewController.player.state == OOOoyalaPlayerStateReady) {
            [self.playerViewController.player play];
        }
    }
    NSLog(@"notification name:%@",name);
    
    
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
