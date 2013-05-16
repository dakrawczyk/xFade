//
//  DFSSongsViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSSongCell.h"
#import "DFSSongsViewController.h"

@interface DFSSongsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *songsTableView;

@property (nonatomic, strong) NSArray *songsArray;

@end

@implementation DFSSongsViewController


+ (DFSSongsViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSSongsViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.collection)
    {
        self.songsArray = [self.collection items];
    }
    else
        self.songsArray = [[MPMediaQuery songsQuery] items];
    
}


#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"songCell";
    
    DFSSongCell *cell = [self.songsTableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DFSSongCell alloc]init];
    }
    
    
     MPMediaItem *item = self.songsArray[indexPath.row];

    cell.titleLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    cell.artistLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    cell.bpmLabel.text =[NSString stringWithFormat:@"%@",[item valueForProperty:MPMediaItemPropertyBeatsPerMinute]] ;
    
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    cell.albumImageView.image = [artwork imageWithSize:CGSizeMake(48, 48)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.songsTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[DFSMusicPlayerManager sharedInstance]loadSongDeckA:self.songsArray[indexPath.row]];
    [[DFSMusicPlayerManager sharedInstance] playSongA:self.songsArray[indexPath.row]];
}

@end
