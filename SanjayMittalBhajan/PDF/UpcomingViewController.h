//
//  UpcomingViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *contactPersonArr,*venueArr,*organisationArr,*dayArr,*dateEventArr,*eventCountArr,*eventArr;
@property(nonatomic,retain)NSString *indxp,*status,*message,*details;

@end
