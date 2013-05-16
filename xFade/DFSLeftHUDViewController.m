//
//  DFSLeftHUDViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 5/6/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSLeftHUDViewController.h"
#import "JASidePanelController.h"
#import "DFSRootViewController.h"

#import "DFSSongsViewController.h"
#import "DFSArtistViewController.h"
#import "DFSAlbumViewController.h"


#define kParalaxViewYOrigin -164

@interface DFSLeftHUDViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *paralaxView;
@property (weak, nonatomic) IBOutlet UIImageView *paralaxImageView;

@property (nonatomic, strong) NSArray *hudChoicesArray;

@end

@implementation DFSLeftHUDViewController

+ (DFSLeftHUDViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSLeftHUDViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.hudChoicesArray = @[@"",@"",@"Songs",@"Albums",@"Artists",@"Genres",@"",@"Settings",@"Feedback"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hudChoicesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"hudChoice";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        CGRect frame =  cell.imageView.frame;
        frame.origin.x = frame.origin.x - 5;
        frame.origin.y = frame.origin.y - 2;
        cell.imageView.frame = frame;
    }
    
    if (indexPath.row > 1 && indexPath.row < 6)
    {
        cell.imageView.image = [UIImage imageNamed:@"ui_hud_viewInactive"];
        cell.backgroundColor = [UIColor clearColor];
        if (cell.selected)
        {
            cell.imageView.image = [UIImage imageNamed:@"ui_hud_viewActive"];
            cell.backgroundColor = [UIColor colorWithRed:(67.0/255.0) green:(67.0/255.0) blue:(67.0/255.0) alpha:1];

        }
    }
    
    if (indexPath.row == 7)
        cell.imageView.image = [UIImage imageNamed:@"ui_hud_settingsIcon"];

    if (indexPath.row == 8)
        cell.imageView.image = [UIImage imageNamed:@"ui_hud_feedbackIcon"];

    
    cell.textLabel.text = self.hudChoicesArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controllerForCenterPanel;
    switch (indexPath.row)
    {
        case 2: //Songs
        {
            controllerForCenterPanel = [DFSSongsViewController newFromStoryboard];
        }
            break;
        case 3: //Albums
        {
            controllerForCenterPanel = [DFSAlbumViewController newFromStoryboard];
        }
            break;
        case 4: //Artists
        {
            controllerForCenterPanel = [DFSArtistViewController newFromStoryboard];
        }
            break;
        case 5: //Genres
        {
            controllerForCenterPanel = [DFSSongsViewController newFromStoryboard];

        }
            break;
        case 7: //Settings
        {
            controllerForCenterPanel = [DFSSongsViewController newFromStoryboard];

        }
            break;
        case 8: //Feedback
        {
            controllerForCenterPanel = [DFSSongsViewController newFromStoryboard];

        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    
    DFSAppDelegate *ap = [[UIApplication sharedApplication]delegate];
    
    
    DFSRootViewController *rootVC = ap.rootViewController;
    [rootVC setCurrentVC:controllerForCenterPanel];
    
    [ap.viewController showCenterPanelAnimated:YES];
    [self.tableView reloadData];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = self.paralaxView.frame;
    frame.origin.y = kParalaxViewYOrigin - scrollView.contentOffset.y;
    self.paralaxView.frame = frame;
    
}





@end
