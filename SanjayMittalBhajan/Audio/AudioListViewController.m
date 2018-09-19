//
//  AudioListViewController.m
//  SanjayMittalBhajan


#import "AudioListViewController.h"
#import "Base.h"

#import "AudioTableViewCell.h"
#import "AudioPlayViewController.h"
@interface AudioListViewController ()
{
        BOOL isFiltered;
}
@end

@implementation AudioListViewController
@synthesize searchBar;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
     searchBar.delegate = (id)self;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _audioListArr=[[NSMutableArray alloc]init];
    [self dataAudioParsing];
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

        for (NSDictionary *temp in _audioListArr)
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

-(void)dataAudioParsing{
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
        [_audioListArr removeAllObjects];
        NSString *username = @"admin";
        NSString *password = @"Adm1n@123";
        
        NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
        NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
        
        NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
        NSDictionary *headers = @{ @"content-type": @"json/application",
                                   @"authorization": base64str };
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/audio/audio-list?pageNo=1"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
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
                NSLog(@"totalCount==%@",self.totalCount);
                
                
                 NSArray *bodyArr=[bodyDic objectForKey:@"body"];
                
                
                if(bodyArr.count==0)
                {
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no audio data." preferredStyle:UIAlertControllerStyleAlert];
                    
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
                        NSString *str2=[[temp objectForKey:@"audioPath"]description];
                        NSString *str3=[[temp objectForKey:@"fileName"]description];
                        NSString *str4=[[temp objectForKey:@"audioSize"]description];
                        NSString *str5=[[temp objectForKey:@"pdfFileName"]description];
                        NSString *str6=[[temp objectForKey:@"fileId"]description];
                        NSString *str7=[[temp objectForKey:@"tags"]description];
                        NSString *str8=[[temp objectForKey:@"bhajanTitle"]description];
                        
                        NSLog(@"date=%@  day=%@ venue=%@ organisation=%@  contactPerson=%@  contactNumber=%@ imagePath=%@ eventCount=%@",str1,str2,str3,str4,str5,str6,str7,str8);
                        
                        
                        [self->_audioListArr addObject:temp];
                        NSLog(@"_audioListArr ARRAYY%@",self->_audioListArr);
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
    if(isFiltered)
        rowCount = _filteredArray.count;
    else
        rowCount = _audioListArr.count;
    
    return rowCount;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  if(isFiltered){
    NSMutableDictionary *ktemp=[_filteredArray objectAtIndex:indexPath.row];
    
    cell.audioTitle.text=[[ktemp objectForKey:@"bhajanTitle"]description];
    cell.thumbnailPath.text=[[ktemp objectForKey:@"thumbnailsPath"]description];
    cell.audioPath.text=[[ktemp objectForKey:@"audioPath"]description];
    cell.audioSize.text=[[ktemp objectForKey:@"audioSize"]description];
    cell.tags.text=[[ktemp objectForKey:@"tags"]description];
    cell.fileId.text= [[ktemp objectForKey:@"fileId"]description];
    cell.fileName.text=[[ktemp objectForKey:@"fileName"]description];
    
    NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"thumbnailsPath"]description]];
    NSLog(@"URL PATH=%@",urlstr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.audioImg.image = img1;
            
        });
    });
        return cell;
  }
  else{
      NSMutableDictionary *ktemp=[_audioListArr objectAtIndex:indexPath.row];
      
      cell.audioTitle.text=[[ktemp objectForKey:@"bhajanTitle"]description];
      cell.thumbnailPath.text=[[ktemp objectForKey:@"thumbnailsPath"]description];
      cell.audioPath.text=[[ktemp objectForKey:@"audioPath"]description];
      cell.audioSize.text=[[ktemp objectForKey:@"audioSize"]description];
      cell.tags.text=[[ktemp objectForKey:@"tags"]description];
      cell.fileId.text= [[ktemp objectForKey:@"fileId"]description];
      cell.fileName.text=[[ktemp objectForKey:@"fileName"]description];
      
      NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"thumbnailsPath"]description]];
      NSLog(@"URL PATH=%@",urlstr);
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
          
          dispatch_async(dispatch_get_main_queue(), ^{
              
              cell.audioImg.image = img1;
              
          });
      });
      return cell;
  }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AudioTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _fileIdStr=cell.fileId.text;

    _filenameStr=cell.fileName.text;
    _bhajanTitle=cell.audioTitle.text;
    _audioImg=cell.audioImg.image;
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"indexpath==%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"audioListDetails"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"audioListDetails"])
    {
        
        AudioPlayViewController *kvc = [segue destinationViewController];
        
        kvc.fileNameStr=_filenameStr;
        kvc.fileIdStr=_fileIdStr;
        kvc.bhajanTitleStr=_bhajanTitle;
        kvc.indxpath=_indxp;
        kvc.kimg=_audioImg;
        kvc.kimgarray=_imgarray;
        
        NSLog(@"indexpath in prepare for segue==%@",_fileIdStr);
    }
}


@end
