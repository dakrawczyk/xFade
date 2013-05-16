//
//  DFSAlbumViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 5/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSAlbumViewController.h"

@interface DFSAlbumViewController ()

@end

@implementation DFSAlbumViewController

+ (DFSAlbumViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSAlbumViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


@end
