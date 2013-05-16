//
//  DFSAppDelegate.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#define kBlueColor [UIColor colorWithRed:(82.0/255.0) green:(104.0/255.0) blue:(152.0/255.0) alpha:1]

#import "DFSAppDelegate.h"

#import "JASidePanelController.h"
#import "DFSRightHUDViewController.h"
#import "DFSLeftHUDViewController.h"
#import "DFSRootViewController.h"

@implementation DFSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[JASidePanelController alloc] init];
    self.viewController.shouldDelegateAutorotateToVisiblePanel = NO;
    self.rootViewController = [[DFSRootViewController alloc]init];
    self.rootViewController.showLaunch = YES;
    
    self.viewController.leftPanel = [DFSLeftHUDViewController newFromStoryboard];
    self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    
    
    UIImage* navBg = [UIImage imageNamed:@"bg_global_topNav"];
    

    [[UINavigationBar appearance] setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];


    
    [[UINavigationBar appearance] setTitleTextAttributes:
                              @{UITextAttributeTextColor: kBlueColor,
                          UITextAttributeTextShadowColor: [UIColor clearColor],
                                     UITextAttributeFont: [UIFont fontWithName:kHelveticaNeueBold size:18]}];

    
//    UIBarButtonItem *bButton = self.viewController.leftButtonForCenterPanel;
//    [bButton setBackgroundImage:[UIImage imageNamed:@"ui_global_hudIcon"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];    
//    self.viewController.leftButtonForCenterPanel = bButton;
    self.viewController.rightPanel = [DFSRightHUDViewController newFromStoryboard];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
