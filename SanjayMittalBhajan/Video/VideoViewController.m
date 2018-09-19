//
//  VideoViewController.m
//  SanjayMittalBhajan

#import "VideoViewController.h"
#import "VideoTableViewCell.h"
#import "Base.h"

@interface VideoViewController ()
{
    BOOL isFiltered;
}
@end

@implementation VideoViewController
@synthesize searchBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    searchBar.delegate=(id)self;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _videoListArr=[[NSMutableArray alloc]init];
   
    [self dataVideoParsing];
}
-(void)viewDidUnload{
    [self setSearchBar:nil];
    [super viewDidUnload];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"****searchText:%@",searchText);
    
    if(searchText.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
         _filteredArray=[[NSMutableArray alloc]init];
        for (NSDictionary *temp in _videoListArr)
        {
            NSRange nameRange = [[[temp objectForKey:@"tags"]description] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound)
            {
                [_filteredArray addObject:temp];
            }
        }
    }
    
    [self.tableview reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.tableview resignFirstResponder];
}
-(void)dataVideoParsing{
    
    [_videoListArr removeAllObjects];
    NSString *username = @"admin";
    NSString *password = @"Adm1n@123";
    
    NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
    NSDictionary *headers = @{ @"content-type": @"json/application",
                               @"authorization": base64str };
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/video/video-list?pageNo=1"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            
            NSLog(@"Success: %@", data);
            
            NSError *err;
            
            NSArray *jsonArray  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            NSLog(@"JSON DATA%@",jsonArray);
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"response data:%@",maindic);
            
            self.status=[maindic objectForKey:@"status"];
            self.message=[maindic objectForKey:@"message"];
            
            NSArray *detailArr=[maindic objectForKey:@"details"];
            NSDictionary *bodyDic=[maindic objectForKey:@"body"];
            
            NSLog(@"status==%@& message=%@ details==%@  bodyDic==%@",self.status,self.message,detailArr,bodyDic);
            
            self.currentPageNo=[bodyDic objectForKey:@"currentPageNo"];
            self.totalCount=[bodyDic objectForKey:@"totalCount"];
            self.totalPageSize=[bodyDic objectForKey:@"totalPageSize"];
            NSLog(@"status==%@",self.totalCount);
            
            NSArray *bodyArr=[bodyDic objectForKey:@"body"];
            
            
            if(bodyArr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no video data." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else {
                
                for(NSDictionary *temp in bodyArr)
                {
                    NSString *str1=[[temp objectForKey:@"thumbnailsPath"]description];
                    NSString *str2=[[temp objectForKey:@"videoPath"]description];
                    NSString *str3=[[temp objectForKey:@"fileName"]description];
                    NSString *str4=[[temp objectForKey:@"videoSize"]description];
                    NSString *str5=[[temp objectForKey:@"tags"]description];
                    NSString *str6=[[temp objectForKey:@"bhajanTitle"]description];
                  
                    
                    NSLog(@"date=%@  day=%@ venue=%@ organisation=%@  contactPerson=%@  contactNumber=%@",str1,str2,str3,str4,str5,str6);
                    
                    
                    [self->_videoListArr addObject:temp];
                    NSLog(@"_videoListArr ARRAYY%@",self->_videoListArr);
                }
            }
            [self->_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
            
        }
    }];
    [dataTask resume];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger rowCount;
    if (isFiltered)
        rowCount=_filteredArray.count;
    else
        rowCount=_videoListArr.count;
    return  rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (isFiltered) {
        NSMutableDictionary *ktemp=[_filteredArray objectAtIndex:indexPath.row];
        
        cell.videoLbl.text=[[ktemp objectForKey:@"bhajanTitle"]description];
        cell.thumbnailPath.text=[[ktemp objectForKey:@"thumbnailsPath"]description];
        cell.videoPath.text=[[ktemp objectForKey:@"videoPath"]description];
        cell.videoSize.text=[[ktemp objectForKey:@"videoSize"]description];
        cell.tags.text=[[ktemp objectForKey:@"tags"]description];
        
        NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"thumbnailsPath"]description]];
        NSLog(@"URL PATH=%@",urlstr);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgVideo.image = img1;
                
            });
        });
    
        return cell;
    }
    else{
    NSMutableDictionary *ktemp=[_videoListArr objectAtIndex:indexPath.row];
    
    cell.videoLbl.text=[[ktemp objectForKey:@"bhajanTitle"]description];
    cell.thumbnailPath.text=[[ktemp objectForKey:@"thumbnailsPath"]description];
    cell.videoPath.text=[[ktemp objectForKey:@"audioPath"]description];
    cell.videoSize.text=[[ktemp objectForKey:@"audioSize"]description];
    cell.tags.text=[[ktemp objectForKey:@"tags"]description];
    
    [cell.videoBtn addTarget:self action:@selector(videoPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"thumbnailsPath"]description]];
    NSLog(@"URL PATH=%@",urlstr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imgVideo.image = img1;
            
        });
    });
        return cell;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}
-(void)videoPlayBtn:(UIButton *)sender{
//    UIButton *button = (UIButton *)sender;
//    NSLog(@"indexPath.row: %ld", button.tag);
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"SampleVideo" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:path];
    AVPlayer *player=[AVPlayer playerWithURL:url];
    AVPlayerViewController *controller=[[AVPlayerViewController alloc]init];
    controller.player=player;
    
    //showing video in full screen
    controller.view.frame=self.view.bounds;
    [[self view] addSubview:controller.view];
    //play video
    [player play];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
