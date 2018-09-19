//
//  VideoTableViewCell.h
//  SanjayMittalBhajan
//
//  Created by Punit on 04/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backgroundViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *imgVideo;
@property (weak, nonatomic) IBOutlet UILabel *videoLbl;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailPath;
@property (weak, nonatomic) IBOutlet UILabel *videoPath;
@property (weak, nonatomic) IBOutlet UILabel *videoSize;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;


@end
