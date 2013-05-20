//
//  DFSNowPlayingViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//
#define kNowPlayingHeight 84 
#define kDrawerHeight 82
#define kMaxProgressViewWidth 248

#import "DFSNowPlayingViewController.h"

@interface DFSNowPlayingViewController ()


@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (nonatomic, strong) NSTimer *updateProgressViewTimer;
@property (nonatomic, strong) DFSRootViewController *rootVC;
@end

@implementation DFSNowPlayingViewController

+ (DFSNowPlayingViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSNowPlayingViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    self.updateProgressViewTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgressView) userInfo:nil repeats:YES];
    
    DFSAppDelegate *ap = [[UIApplication sharedApplication]delegate];
    self.rootVC = ap.rootViewController;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureFired:)];
    [self.view addGestureRecognizer:panGesture];

}


-(void)updateProgressView
{
    MPMediaItem *item =[[DFSMusicPlayerManager sharedInstance] deckACurrentItem];
    
    if (!item) {
        self.progressView.hidden =YES;
        return;
    }else
    {
        self.progressView.hidden = NO;
    }

    CGFloat playbackDuration = [[item valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
    CGFloat currentValue = [[DFSMusicPlayerManager sharedInstance] currentPlayTime];
    
    
    CGFloat percent = currentValue/playbackDuration;
    
    self.progressView.frame = CGRectMake(0, 0, percent*kMaxProgressViewWidth, self.progressView.frame.size.height);
}

-(void)panGestureFired:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:self.view];
    CGFloat newYValue = self.view.frame.origin.y + translation.y;

    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (ABS(translation.x)<ABS(translation.y)) //ignore horizontal movement
            {
                if ((newYValue > (self.rootVC.view.frame.size.height - self.view.frame.size.height)))
                {
                    self.view.frame = CGRectMake(self.view.frame.origin.x, newYValue, self.view.frame.size.width, self.view.frame.size.height);
                    [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
                }

            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - audio control methods

- (IBAction)previousTapped:(id)sender
{
}

- (IBAction)nowPlayingViewTapped:(id)sender
{
    [[DFSMusicPlayerManager sharedInstance]pauseCurrentPlayer];

}

- (IBAction)playPauseTapped:(id)sender
{
    [[DFSMusicPlayerManager sharedInstance]pauseCurrentPlayer];
    
}

- (IBAction)nextTapped:(id)sender
{
}

- (IBAction)airplayTapped:(id)sender
{

}

#pragma mark - remote control events


@end
