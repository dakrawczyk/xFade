//
//  DFSSplashViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 5/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSSplashViewController.h"

@interface DFSSplashViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@end

@implementation DFSSplashViewController

+ (DFSSplashViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSSplashViewController"];
}

-(void)awakeFromNib
{
    self.firstImageView.alpha = 1;
    self.secondImageView.alpha = 1;
}

-(void)performLoadingAnimationWithBlock:(void (^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.6 delay:0 options:nil animations:^{
            self.firstImageView.alpha = 1;
            self.secondImageView.alpha = 1;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.8
                                  delay:1
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 self.firstImageView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:.4 delay:.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                                     self.view.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     block();
                                 }];
                                 

                             }];

        }];
        
    });

    
}


-(void)performLoadingAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.5 delay:.5 options:nil animations:^{
            self.firstImageView.alpha = 0;
        } completion:^(BOOL finished) {
            nil;
        }];
    });

    
    
}
@end
