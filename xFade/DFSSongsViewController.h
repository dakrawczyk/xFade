//
//  DFSSongsViewController.h
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFSSongsViewController : UIViewController

@property (nonatomic, strong) MPMediaItemCollection *collection;

+ (DFSSongsViewController*)newFromStoryboard;

@end
