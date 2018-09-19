//
//  AudioTableViewCell.h
//  SanjayMittalBhajan
//
//  Created by Punit on 04/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backgroundViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *audioImg;
@property (weak, nonatomic) IBOutlet UILabel *audioTitle;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailPath;
@property (weak, nonatomic) IBOutlet UILabel *audioPath;
@property (weak, nonatomic) IBOutlet UILabel *audioSize;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *fileId;
@property (weak, nonatomic) IBOutlet UILabel *fileName;

@end
