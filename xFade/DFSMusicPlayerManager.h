//
//  DFSMusicPlayerManager.h
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFSRootViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface DFSMusicPlayerManager : NSObject

@property (nonatomic, strong) DFSRootViewController *rootVC;

@property (nonatomic, strong) AVAudioPlayer *audioPlayerA;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerB;

@property (nonatomic, strong) MPMediaItem *deckACurrentItem;
@property (nonatomic, strong) MPMediaItem *deckBCurrentItem;

+(id) sharedInstance;

-(void)playSongA:(MPMediaItem*)item;
-(void)loadSongDeckA:(MPMediaItem *)item;

-(void)playSongB:(MPMediaItem*)item;
-(void)loadSongDeckB:(MPMediaItem *)item;

-(void)swapDeckB;

-(void)pauseCurrentPlayer;

-(CGFloat)currentPlayTime;

@end
