//
//  DFSSongsViewController.m
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSSongCell.h"
#import "DFSIndexedListView.h"
#import "DFSSongsViewController.h"

@interface DFSSongsViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *songsTableView;

@property (nonatomic, strong) NSArray *songsArray;
@property (nonatomic, strong) NSNumber *currentSyncingCell;
@property (nonatomic, strong) NSMutableDictionary *songDict;
@property (nonatomic, strong) DFSIndexedListView *indexedListView;
@property (nonatomic, strong) NSTimer *indexedListTimer;

@end

@implementation DFSSongsViewController


+ (DFSSongsViewController*)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: @"DFSSongsViewController"];
}

-(void)awakeFromNib
{
    self.songDict = [[NSMutableDictionary alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.collection)
    {
        self.songsArray = [self.collection items];
        self.title = [[self.collection representativeItem] valueForProperty:MPMediaItemPropertyArtist];
    }
    else
        self.songsArray = [[MPMediaQuery songsQuery] items];
    


    
    [self organizeSongs];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.indexedListView = [[DFSIndexedListView alloc]initWithFrame:CGRectMake(0, 22, 61, 514)];
    self.indexedListView.alpha = 0;
    [self.view addSubview:self.indexedListView];

}

-(void)organizeSongs
{
    [self.songDict removeAllObjects];
    
    
    for (MPMediaItem *item in self.songsArray)
    {
        NSString *firstLetter = [[[item valueForProperty:MPMediaItemPropertyTitle] substringToIndex:1] uppercaseString];
        if (![firstLetter isEqualToString:@" "])
        {
            if ([firstLetter floatValue])
            {
                firstLetter = @"#";
            }else if ([firstLetter isEqualToString:@"0"]) {
                firstLetter = @"#";
            }
            if (self.songDict[firstLetter])
            {
                NSMutableArray *s = self.songDict[firstLetter];
                
                [s addObject:item];
                [self.songDict setObject:s forKey:firstLetter];
            }else
            {
                NSMutableArray *s = [[NSMutableArray alloc]init];;
                
                [s addObject:item];
                [self.songDict setObject:s forKey:firstLetter];
            }
        }
    }
    
    self.songsArray = [NSArray arrayWithArray:[self.songDict allKeys]];
    
    self.songsArray = [self.songsArray sortedArrayUsingSelector:
                          @selector(localizedCaseInsensitiveCompare:)];

}

-(void)showIndexedList
{
    [UIView animateWithDuration:.2 animations:^{
        self.indexedListView.alpha = 1;
    }];
}

-(void)hideIndexedList
{
    [UIView animateWithDuration:.2 animations:^{
        self.indexedListView.alpha = 0;
    }];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self showIndexedList];
    [self.indexedListTimer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.indexedListTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideIndexedList) userInfo:nil repeats:NO];
}

#pragma mark - TableView

// ---------------- Indexed List
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    if (section > self.songsArray.count) {
//        return nil;
//    }
//    NSArray * array = self.songDict[self.songsArray[section]];
//    if ([array count] > 0) {
//        return self.songsArray[section];
//    }
//    return nil;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
//}
//------------------ End Indexed List

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.songsArray[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.songDict[self.songsArray[section]];
    return [array count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    

    cell.syncButton.tag = indexPath.row;
    
     NSArray *array = self.songDict[self.songsArray[indexPath.section]];
     MPMediaItem *item = array[indexPath.row];

    cell.titleLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    cell.artistLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    cell.bpmLabel.text =[NSString stringWithFormat:@"%@",[item valueForProperty:MPMediaItemPropertyBeatsPerMinute]] ;
    
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    cell.albumImageView.image = [artwork imageWithSize:CGSizeMake(61, 61)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFSSongCell *cell =  (DFSSongCell *)[self.songsTableView cellForRowAtIndexPath:indexPath];
    
    NSArray *array = self.songDict[self.songsArray[indexPath.section]];

    if (cell.syncButton.selected)
    {
        [[DFSMusicPlayerManager sharedInstance]swapDeckB];
        [cell slideForOpen:NO];
        cell.syncButton.selected = NO;
        self.songsTableView.scrollEnabled = YES;

    }else
    {
        [self.songsTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [[DFSMusicPlayerManager sharedInstance]loadSongDeckA:array[indexPath.row]];
        [[DFSMusicPlayerManager sharedInstance] playSongA:array[indexPath.row]];
    }
}

- (IBAction)syncPressed:(UIButton *)button
{

    button.selected = !button.selected;
    if (button.selected)
    {
        if (self.currentSyncingCell)
        {
            [self closeCellAtIndex:[self.currentSyncingCell intValue]];
        }
        self.currentSyncingCell = @(button.tag);
        [[DFSMusicPlayerManager sharedInstance]loadSongDeckB:self.songsArray[button.tag]];
        [[DFSMusicPlayerManager sharedInstance] playSongB:self.songsArray[button.tag]];
        self.songsTableView.scrollEnabled = NO;
        [self.songsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:button.tag inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }else
    {
        [self closeCellAtIndex:button.tag];
    }
}

-(void)closeCellAtIndex:(int)idx
{
    [[[DFSMusicPlayerManager sharedInstance] audioPlayerB]stop];
    [[DFSMusicPlayerManager sharedInstance] setDeckBCurrentItem:nil];
    DFSSongCell *cell =  (DFSSongCell *)[self.songsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
    cell.syncButton.selected = NO;
    [cell slideForOpen:NO];
    self.currentSyncingCell = nil;

    self.songsTableView.scrollEnabled = YES;
}



@end
