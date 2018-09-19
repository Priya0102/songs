//
//  GalleryViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 01/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.



#import "GalleryViewController.h"
#import "Gallery.h"
#import "GalleryCollectionViewCell.h"
#import "Constant.h"
#import "Base.h"
#import "SubGalleryCollectionViewCell.h"
#import "InnerGalleryViewController.h"
#import "OpenImageViewController.h"

@interface GalleryViewController ()
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _galleryArr=[[NSMutableArray alloc]init];
   
    _thumbnailArr=[[NSMutableArray alloc]init];
    
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    
    _collectionView2.delegate=self;
    _collectionView2.dataSource=self;
    
    [self parsingGallery];
    [self parsingGallery2];
}

-(void)parsingGallery{
    
    [_galleryArr removeAllObjects];
    
NSString *username = @"admin";
NSString *password = @"Adm1n@123";

NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];

NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
NSDictionary *headers = @{ @"content-type": @"json/application",
                           @"authorization": base64str };


NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/getGalleryFolders/1"]
                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
[request setHTTPMethod:@"GET"];
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
        
        NSArray *bodyArr=[bodyDic objectForKey:@"galleries"];
        
        
        if(bodyArr.count==0)
        {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no gallery folder." preferredStyle:UIAlertControllerStyleAlert];
            
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
                NSString *str1=[[temp objectForKey:@"galleryId"]description];
                NSString *str2=[[temp objectForKey:@"directoryPath"]description];
                NSString *str3=[[temp objectForKey:@"directoryName"]description];
                NSString *str4=[[temp objectForKey:@"thumbnailPath"]description];
                NSString *str5=[[temp objectForKey:@"thumbnailName"]description];
                NSString *str6=[[temp objectForKey:@"imagePath"]description];
                NSString *str7=[[temp objectForKey:@"imageName"]description];
                NSString *str8=[[temp objectForKey:@"videoPath"]description];
                NSString *str9=[[temp objectForKey:@"videoName"]description];
                NSString *str10=[[temp objectForKey:@"parentId"]description];
                NSString *str11=[[temp objectForKey:@"directory"]description];
                NSLog(@"date=%@  day=%@ venue=%@ organisation=%@",str1,str2,str3,str4);
                
                
                [self->_galleryArr addObject:temp];
                NSLog(@"gallery ListArr ARRAYY%@",self->_galleryArr);
            }
        }
        [self.myCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadData];
        });
        
    }
}];
[dataTask resume];
}

-(void)parsingGallery2{
    
    [_thumbnailArr removeAllObjects];
    
    NSString *username = @"admin";
    NSString *password = @"Adm1n@123";
    
    NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
    NSDictionary *headers = @{ @"content-type": @"json/application",
                               @"authorization": base64str };
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/getGalleryFolders/1"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
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
            
            [[NSUserDefaults standardUserDefaults] setObject:self.currentPageNo forKey:@"currentPageNo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSArray *bodyArr=[bodyDic objectForKey:@"galleries"];
            
            
            if(bodyArr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no gallery folder." preferredStyle:UIAlertControllerStyleAlert];
                
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
                    NSString *str1=[[temp objectForKey:@"galleryId"]description];
                    NSString *str2=[[temp objectForKey:@"directoryPath"]description];
                    NSString *str3=[[temp objectForKey:@"directoryName"]description];
                    NSString *str4=[[temp objectForKey:@"thumbnailPath"]description];
                    NSString *str5=[[temp objectForKey:@"thumbnailName"]description];
                    NSString *str6=[[temp objectForKey:@"imagePath"]description];
                    NSString *str7=[[temp objectForKey:@"imageName"]description];
                    NSString *str8=[[temp objectForKey:@"videoPath"]description];
                    NSString *str9=[[temp objectForKey:@"videoName"]description];
                    NSString *str10=[[temp objectForKey:@"parentId"]description];
                    NSString *str11=[[temp objectForKey:@"directory"]description];
                    
                    NSLog(@"date=%@  day=%@ venue=%@ organisation=%@",str1,str2,str3,str4);
                    
                    
                    [self->_thumbnailArr addObject:temp];
                    NSLog(@"gallery ListArr ARRAYY%@",self->_thumbnailArr);
                }
            }
            [self.collectionView2 performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView2 reloadData];
            });
            
        }
    }];
    [dataTask resume];
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(collectionView==_myCollectionView){
        return 1;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView==_myCollectionView) {
          return _galleryArr.count;
    }
    return _thumbnailArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell==nil) {
//        cell=[[UICollectionViewCell alloc]initWithStyle:UICollectionViewCellDragStateNone reuseIdentifier:@"cell"];
//    }
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"]
if (collectionView==_myCollectionView){
    
    GalleryCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableDictionary *ktemp=[_galleryArr objectAtIndex:indexPath.row];
    cell.directory.text=[[ktemp objectForKey:@"directory"]description];
    
    if ([cell.directory.text isEqual:@"1"]) {
        
        cell.galleryid.text=[[ktemp objectForKey:@"galleryId"]description];
        cell.directoryName.text=[[ktemp objectForKey:@"directoryName"]description];
       
          }
      else{
    
       NSLog(@"No gallery folder...");
        cell.hidden=YES;
        cell.contentView.hidden = YES;
           }
    return  cell;
    }
    else{
        SubGalleryCollectionViewCell *cell=[_collectionView2 dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        NSMutableDictionary *ktemp=[_thumbnailArr objectAtIndex:indexPath.row];
          cell.directory.text=[[ktemp objectForKey:@"directory"]description];
        
        if ([cell.directory.text isEqual:@"0"]) {
        cell.imagePath.text=[[ktemp objectForKey:@"imagePath"]description];
        cell.imageName.text=[[ktemp objectForKey:@"imageName"]description];
        cell.thumbnailPath.text=[[ktemp objectForKey:@"thumbnailPath"]description];
        cell.thumbnailName.text=[[ktemp objectForKey:@"thumbnailName"]description];
        cell.videoPath.text=[[ktemp objectForKey:@"videoPath"]description];
        cell.videoName.text=[[ktemp objectForKey:@"videoName"]description];
        cell.parentId.text=[[ktemp objectForKey:@"parentId"]description];
           

        NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"imagePath"]description]];
            NSLog(@"URL PATH=%@",urlstr);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    cell.galleryImgView.image = img1;
                    
                });
            });
            
        return  cell;
        }
        else{
            cell.hidden=YES;
            cell.contentView.hidden = YES;
    }
        
    return  cell;
}
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    GalleryCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableDictionary *ktemp=[_galleryArr objectAtIndex:indexPath.row];

    cell.galleryid.text=[[ktemp objectForKey:@"galleryId"]description];
   
    _galleryIdStr=cell.galleryid.text;
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"in did select GALLERY id=%@",cell.galleryid.text);

   
    [self performSegueWithIdentifier:@"subGalleryDetails" sender:self];
   
    [self performSegueWithIdentifier:@"openImage1" sender:self];
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"subGalleryDetails"])
    {
        InnerGalleryViewController *kvc = [segue destinationViewController];
        kvc.galleryidStr=_galleryIdStr;
        kvc.indxp=_indxp;
        NSLog(@"in prepare for segue GALLERY id=%@",_galleryIdStr);
    }
    if ([[segue identifier] isEqualToString:@"openImage1"])
    {
        OpenImageViewController *kvc = [segue destinationViewController];
        kvc.galleryidStr=_galleryIdStr;
        kvc.indxp=_indxp;
        NSLog(@"in prepare for segue GALLERY id=%@",_galleryIdStr);
    }
}

@end
