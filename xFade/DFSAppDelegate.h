//
//  DFSAppDelegate.h
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#define kHelveticaNeueCondensedBold @"HelveticaNeue-CondensedBold"
#define kHelveticaNeueMedium @"HelveticaNeue-Medium"
#define kHelveticaNeueBold @"HelveticaNeue-Bold"
#define kHelveticaNeueRegular @"HelveticaNeue"
#define kGeorgiaRegular @"Georgia"
#define kGeorgiaMedium @"Georgia-Medium"
#define kGeorgiaBold @"Georgia-Bold"


#import <UIKit/UIKit.h>
#import "DFSRootViewController.h"

@class JASidePanelController;
@interface DFSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) JASidePanelController *viewController;
@property (nonatomic, strong) DFSRootViewController *rootViewController;

@end
