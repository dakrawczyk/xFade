//
//  DFSSongCell.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#define kSongCellWidthWithAlbum (320 - 61)

#import "DFSSongCell.h"

@interface DFSSongCell()
@property (weak, nonatomic) IBOutlet UILabel *songAPercentLabel;

@property (weak, nonatomic) IBOutlet UILabel *songBPercentLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation DFSSongCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureFired:)];
    panGesture.delegate = self;
    [self.topView addGestureRecognizer:panGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer respondsToSelector:@selector(translationInView:)]) {
        CGPoint velocity = [gestureRecognizer velocityInView:self];

        if (ABS(velocity.x)<ABS(velocity.y))
        {
            return NO;
        }
        
    }
    return YES;
    
}


-(void)panGestureFired:(UIPanGestureRecognizer *)panGesture
{
    if (!self.syncButton.selected)
    {
        return;
    }
    
    if (!self.bottomAlbumImageView.image)
    {
       MPMediaItem *item = [[DFSMusicPlayerManager sharedInstance]deckACurrentItem];
        MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
        self.bottomAlbumImageView.image = [artwork imageWithSize:CGSizeMake(61, 61)];
    }
    
    CGPoint translation = [panGesture translationInView:self];
    CGFloat newXValue = self.topView.frame.origin.x + translation.x;
    
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (ABS(translation.x)>ABS(translation.y)) //ignore vertical movement
            {
                if ((newXValue <= kSongCellWidthWithAlbum) && (newXValue >= -1))
                {
                    
                    self.topView.frame = CGRectMake(newXValue, 0, self.frame.size.width, self.frame.size.height);
                    [panGesture setTranslation:CGPointMake(0, 0) inView:self];
                    
                    [self adjustVolume];
                    

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

-(void)slideForOpen:(BOOL)open
{
    CGFloat newXValue = 0;
    
    if (open)
    {
        newXValue = kSongCellWidthWithAlbum;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self.topView.frame = CGRectMake(newXValue, 0, self.frame.size.width, self.frame.size.height);
    }];
    
}


-(void)adjustVolume
{
    CGFloat volPercent = self.topView.frame.origin.x / kSongCellWidthWithAlbum;
    if (volPercent < .5)
    {
        CGFloat valueB = (((volPercent)*2));
        
        [[DFSMusicPlayerManager sharedInstance]audioPlayerB].volume = valueB;
        [[DFSMusicPlayerManager sharedInstance]audioPlayerA].volume = 1;
        
        ;
        self.songBPercentLabel.text =[[[DFSNumberFormatters defaultFormatters] numberFormatPercentageWithDecimals:0] stringFromNumber:@(valueB)];
        self.songAPercentLabel.text = [NSString stringWithFormat:@"100%%"];

    }
    
    if (volPercent > .5)
    {
        [[DFSMusicPlayerManager sharedInstance]audioPlayerA].volume =(1-(volPercent))*2;
        [[DFSMusicPlayerManager sharedInstance]audioPlayerB].volume = 1;
        
        self.songAPercentLabel.text =[[[DFSNumberFormatters defaultFormatters] numberFormatPercentageWithDecimals:0] stringFromNumber:@((1-(volPercent))*2)];
        self.songBPercentLabel.text = [NSString stringWithFormat:@"100%%"];
    }
    
}


@end
