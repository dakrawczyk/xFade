//
//  DFSSplashViewController.h
//  xFade
//
//  Created by Dave Krawczyk on 5/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFSSplashViewController : UIViewController

+ (DFSSplashViewController*)newFromStoryboard;

-(void)performLoadingAnimationWithBlock:(void (^)(void))block;
-(void)performLoadingAnimation;



@end
