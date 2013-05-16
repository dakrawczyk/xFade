//
//  DFSNowPlayingViewController.h
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFSNowPlayingViewController : UIViewController

+ (DFSNowPlayingViewController*)newFromStoryboard;

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@end
