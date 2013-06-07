//
//  DFSViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#define kNowPlayingHeight 84

#import "DFSRootViewController.h"
#import "DFSSongsViewController.h"
#import "DFSNowPlayingViewController.h"
#import "DFSSplashViewController.h"

@interface DFSRootViewController ()

@property (nonatomic, strong) DFSNowPlayingViewController *nowPlayingVC;
@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) DFSSplashViewController *splashVC;
@end

@implementation DFSRootViewController

+ (DFSRootViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSRootViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DFSMusicPlayerManager sharedInstance] setRootVC:self];
    
//    self.title = @"xFade";
//    
//    [self.navigationController setTitle:@"xFade"];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ui_global_logo"]];
    UIBarButtonItem *barButton = self.navigationItem.leftBarButtonItem;
//    [barButton setBackButtonBackgroundImage:[UIImage imageNamed:@"ui_global_hudIcon"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButton setBackgroundImage:[[UIImage alloc]init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButton setImage:[UIImage imageNamed:@"ui_global_hudIcon"]];
    self.navigationItem.leftBarButtonItem = barButton;
    

    DFSSongsViewController *songsVC = [DFSSongsViewController newFromStoryboard];
    self.currentVC = songsVC;

    if (self.showLaunch)
    {
        self.navigationController.navigationBarHidden = YES;
        self.splashVC = [DFSSplashViewController newFromStoryboard];
        self.splashVC.view.frame = CGRectMake(0, 0, 320, 568);
//        [[[[UIApplication sharedApplication]keyWindow]rootViewController].view addSubview:self.splashVC.view];
        [self.view addSubview:self.splashVC.view];
    }
    

    
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];    

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    if (self.showLaunch)
    {
        [self.splashVC performLoadingAnimationWithBlock:^{
            [self.splashVC.view removeFromSuperview];
            [self becomeFirstResponder];

            [self.navigationController setNavigationBarHidden:NO animated:YES];

        }];
        self.showLaunch = NO;
        
    }
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];

}
-(void)setCurrentVC:(UIViewController *)currentVC
{
    [self.currentVC.view removeFromSuperview];
    [self.currentVC removeFromParentViewController];
    _currentVC = currentVC;
    
    
    
    _currentVC = currentVC;
    self.currentVC.view.frame = self.view.bounds;
    if (self.nowPlayingVC)
    {
        self.currentVC.view.frame = CGRectMake(self.currentVC.view.frame.origin.x, self.currentVC.view.frame.origin.y, self.view.frame.size.width, self.nowPlayingVC.view.frame.origin.y+10);

    }
    [self addChildViewController:self.currentVC];
    [self.view addSubview:self.currentVC.view];
    [self.view bringSubviewToFront:self.nowPlayingVC.view];
}


-(void)updateNowPlaying
{
    MPMediaItem *item = [[DFSMusicPlayerManager sharedInstance]deckACurrentItem];
    self.nowPlayingVC.titleLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    self.nowPlayingVC.artistLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    self.nowPlayingVC.albumImageView.image = [artwork imageWithSize:CGSizeMake(80, 80)];
    
    


    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                               [item valueForProperty:MPMediaItemPropertyArtist], MPMediaItemPropertyArtist,
                                                               [item valueForProperty:MPMediaItemPropertyTitle], MPMediaItemPropertyTitle,
                                                               [item valueForProperty:MPMediaItemPropertyAlbumTitle], MPMediaItemPropertyAlbumTitle,
                                                               nil]];
    
//    AVAsset *asset = [AVAsset assetWithURL:[item valueForProperty:MPMediaItemPropertyAssetURL]];
    
}
-(void)showNowPlaying
{
    if (!self.nowPlayingVC)
    {
        self.nowPlayingVC = [DFSNowPlayingViewController newFromStoryboard];
        
        self.nowPlayingVC.view.frame = CGRectMake(0, self.view.frame.size.height, self.nowPlayingVC.view.frame.size.width, self.nowPlayingVC.view.frame.size.height);
        
        [self updateNowPlaying];

//        [[[UIApplication sharedApplication]keyWindow]addSubview:self.nowPlayingVC.view];
        [self.view addSubview:self.nowPlayingVC.view];
        [UIView animateWithDuration:.3 animations:^{
            self.nowPlayingVC.view.frame = CGRectMake(0, self.view.frame.size.height - kNowPlayingHeight, self.nowPlayingVC.view.frame.size.width, self.nowPlayingVC.view.frame.size.height);
            
            self.currentVC.view.frame = CGRectMake(self.currentVC.view.frame.origin.x, self.currentVC.view.frame.origin.y, self.view.frame.size.width, self.nowPlayingVC.view.frame.origin.y+10);
        }];

    }else
    {
        [self updateNowPlaying];

    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [[DFSMusicPlayerManager sharedInstance] pauseCurrentPlayer];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [[DFSMusicPlayerManager sharedInstance] pauseCurrentPlayer];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [[DFSMusicPlayerManager sharedInstance] pauseCurrentPlayer];
        }
    }
}


@end
