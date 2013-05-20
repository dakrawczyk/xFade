//
//  DFSMusicPlayerManager.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSAppDelegate.h"
#import "DFSMusicPlayerManager.h"

@interface DFSMusicPlayerManager()


@end

@implementation DFSMusicPlayerManager

+(id) sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


-(void)loadSongDeckA:(MPMediaItem *)item
{
    self.audioPlayerA = [[AVAudioPlayer alloc]initWithContentsOfURL:[item valueForProperty:MPMediaItemPropertyAssetURL]  error:nil];
    self.deckACurrentItem = item;
    [self.audioPlayerA prepareToPlay];
    
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];


}

-(void)playSongA:(MPMediaItem*)item
{
//    [self.myPlayer setQueueWithItemCollection:[[MPMediaItemCollection alloc]initWithItems:[NSArray arrayWithObject:item]]];
//    [self.myPlayer play];

    [self.audioPlayerA play];
    self.deckACurrentItem = item;
    
    [self.rootVC showNowPlaying];
    
}
-(void)loadSongDeckB:(MPMediaItem *)item
{
    self.audioPlayerB = [[AVAudioPlayer alloc]initWithContentsOfURL:[item valueForProperty:MPMediaItemPropertyAssetURL]  error:nil];
    self.audioPlayerB.volume = 0;
    [self.audioPlayerB prepareToPlay];
    
}

-(void)playSongB:(MPMediaItem*)item
{
    //    [self.myPlayer setQueueWithItemCollection:[[MPMediaItemCollection alloc]initWithItems:[NSArray arrayWithObject:item]]];
    //    [self.myPlayer play];
    
    [self.audioPlayerB play];
    self.deckBCurrentItem = item;
    
    [self.rootVC showNowPlaying];
    
}


-(void)swapDeckB
{
    
    [self.audioPlayerA stop];
    self.audioPlayerA = nil;
    self.audioPlayerA = self.audioPlayerB;
    self.deckACurrentItem = self.deckBCurrentItem;
    self.deckBCurrentItem = nil;
    self.audioPlayerB = nil;
    [self.rootVC showNowPlaying];
}

-(CGFloat)currentPlayTime
{
    return self.audioPlayerA.currentTime;
}

-(void)pauseCurrentPlayer
{
    if (self.audioPlayerA.isPlaying)
    {
        [self.audioPlayerA pause];
    }
    else
    {
        [self.audioPlayerA play];
    }
}

@end
