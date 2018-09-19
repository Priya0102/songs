//
//  PdfViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *pdfListArr,*filteredArray;

@property(nonatomic,retain)NSString *indxp,*status,*message,*details,*currentPageNo,*totalCount,*totalPageSize;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
