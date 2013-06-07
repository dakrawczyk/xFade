//
//  DFSIndexedListView.m
//  xFade
//
//  Created by Dave Krawczyk on 6/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSIndexedListView.h"

@interface DFSIndexedListView()

@end

@implementation DFSIndexedListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView* xibView = [[[NSBundle mainBundle] loadNibNamed:@"DFSIndexedListView" owner:self options:nil] objectAtIndex:0];
        [xibView setFrame:[self frame]];
        self = (DFSIndexedListView *)xibView;

    }
    return self;
}
- (IBAction)panDetected:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture locationInView:self];
    

    CGFloat percent = translation.y / self.frame.size.height;
    
    NSLog(@"%f",percent);
    
    
}

@end
