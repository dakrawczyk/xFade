//
//  DFSArtistViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 5/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSArtistViewController.h"
#import "DFSArtistCell.h"
#import "DFSSongsViewController.h"


@interface DFSArtistViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *artistsArray;

@end

@implementation DFSArtistViewController

+ (DFSArtistViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSArtistViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.artistsArray = [self getArtists];
}

-(NSArray*)getArtists
{
    MPMediaQuery *query=[MPMediaQuery artistsQuery];
    NSArray *artists=[query collections];
//    NSMutableOrderedSet *orderedArtistSet = [NSMutableOrderedSet orderedSet];
    
//    for(MPMediaItemCollection *collection in artists)
//    {
//        NSString *artistTitle = [[collection representativeItem] valueForProperty:MPMediaItemPropertyArtist];
//        unichar firstCharacter = [artistTitle characterAtIndex:0];
//        unichar lastCharacter = [artistTitle characterAtIndex:[artistTitle length] - 1];
//        
//        if ([[NSCharacterSet whitespaceCharacterSet] characterIsMember:firstCharacter] ||
//            [[NSCharacterSet whitespaceCharacterSet] characterIsMember:lastCharacter]) {
//            NSLog(@"\"%@\" has whitespace!", artistTitle);
//            NSString *trimmedArtistTitle = [artistTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            [orderedArtistSet addObject:trimmedArtistTitle];
//        } else { // No whitespace
//            [orderedArtistSet addObject:artistTitle];
//        }
//    }
//    return [orderedArtistSet array];
    return  artists;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.artistsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"artistCell";
    
    DFSArtistCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DFSArtistCell alloc]init];
    }
    
    
    MPMediaItemCollection *collection  = self.artistsArray[indexPath.row];
    
    cell.artistNameLabel.text = [[collection representativeItem] valueForProperty:MPMediaItemPropertyArtist];

    
    cell.numberOfAlbumsLabel.text = [NSString stringWithFormat:@"Songs: %lu",(unsigned long)[collection count]];
    

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DFSSongsViewController *songsVC = [DFSSongsViewController newFromStoryboard];
    songsVC.collection = self.artistsArray[indexPath.row];
    
    [self.navigationController pushViewController:songsVC animated:YES];
    
}

@end
