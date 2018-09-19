//
//  CalendarTableViewCell.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *krishnaPaksahEkadashi;
@property (weak, nonatomic) IBOutlet UILabel *shuklaPakshaDwadashi;
@property (weak, nonatomic) IBOutlet UILabel *shuklaPakshaEkadashi;
@property (weak, nonatomic) IBOutlet UILabel *purnima;
@property (weak, nonatomic) IBOutlet UILabel *amavasya;
@property (weak, nonatomic) IBOutlet UIView *calenderView;
@property (weak, nonatomic) IBOutlet UILabel *month;


@end
