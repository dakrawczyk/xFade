//
//  DFSRightHUDViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 5/6/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSRightHUDViewController.h"

@interface DFSRightHUDViewController ()

@end

@implementation DFSRightHUDViewController

+ (DFSRightHUDViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSRightHUDViewController"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
