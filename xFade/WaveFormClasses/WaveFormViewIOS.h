//
//  WaveFormView.h
//  WaveFormTest
//
//  Created by Gyetván András on 7/11/12.
//  Copyright (c) 2012 DroidZONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AVFoundation/AVFoundation.h>
#import "WaveSampleProvider.h"
#import "WaveSampleProviderDelegate.h"

@interface WaveFormViewIOS : UIControl<WaveSampleProviderDelegate>
{
	UIActivityIndicatorView *progress;
	CGPoint* sampleData;
	int sampleLength;
	WaveSampleProvider *wsp;	
	AVPlayer *player;
	float playProgress;
	NSString *infoString;
	NSString *timeString;
	UIColor *green;
	UIColor *gray;
	UIColor *lightgray;
	UIColor *darkgray;
	UIColor *white;
	UIColor *marker;
}

//- (void) openAudio:(NSString *)path;
- (void) openAudioURL:(NSURL *)url;

@end
