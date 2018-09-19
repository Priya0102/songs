//
//  CalendarViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSString *indxp,*status,*message,*details;
@property (nonatomic,strong) NSMutableArray *calendarArr;
@end
