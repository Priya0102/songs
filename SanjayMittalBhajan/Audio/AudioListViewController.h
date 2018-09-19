//
//  AudioListViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 04/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>
{
    dispatch_queue_t queue;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *audioListArr,*filteredArray;

@property(nonatomic,retain)NSString *indxp,*status,*message,*details,*currentPageNo,*totalCount,*totalPageSize,*fileIdStr,*filenameStr,*bhajanTitle;

@property(nonatomic,retain)UIImage *audioImg;
@property (nonatomic,strong) NSMutableArray *imgarray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
