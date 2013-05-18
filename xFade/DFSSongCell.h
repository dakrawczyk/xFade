//
//  DFSSongCell.h
//  xFade
//
//  Created by Dave Krawczyk on 4/30/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DFSSongCellDelegate <NSObject>
//
//-(void)syncPressedOnCell
//
//@end

@interface DFSSongCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *syncButton;

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bottomAlbumImageView;

-(void)slideForOpen:(BOOL)open;

@end
