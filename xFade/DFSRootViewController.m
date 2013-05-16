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

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    if (self.showLaunch)
    {
        DFSSplashViewController *splashVC = [DFSSplashViewController newFromStoryboard];
        splashVC.view.frame = CGRectMake(0, 0, 320, 568);
        [[[[UIApplication sharedApplication]keyWindow]rootViewController].view addSubview:splashVC.view];
        [splashVC performLoadingAnimationWithBlock:^{
            [splashVC.view removeFromSuperview];            
        }];
        self.showLaunch = NO;
    }
    

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
        self.currentVC.view.frame = CGRectMake(self.currentVC.view.frame.origin.x, self.currentVC.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.nowPlayingVC.view.frame.size.height);

    }
    [self addChildViewController:self.currentVC];
    [self.view addSubview:self.currentVC.view];
}


-(void)updateNowPlaying
{
    MPMediaItem *item = [[DFSMusicPlayerManager sharedInstance]deckACurrentItem];
    self.nowPlayingVC.titleLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    self.nowPlayingVC.artistLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    self.nowPlayingVC.albumImageView.image = [artwork imageWithSize:CGSizeMake(80, 80)];

}
-(void)showNowPlaying
{
    if (!self.nowPlayingVC)
    {
        self.nowPlayingVC = [DFSNowPlayingViewController newFromStoryboard];
        
        self.nowPlayingVC.view.frame = CGRectMake(0, self.view.frame.size.height, self.nowPlayingVC.view.frame.size.width, self.nowPlayingVC.view.frame.size.height);
        
        [self updateNowPlaying];

        
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
@end
