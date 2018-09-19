//
//  CalendarViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarTableViewCell.h"
#import "Base.h"
@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _calendarArr=[[NSMutableArray alloc]init];
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    [self dataCalendarParsing];
}

-(void)dataCalendarParsing
{
    [_calendarArr removeAllObjects];
    NSString *username = @"admin";
    NSString *password = @"Adm1n@123";
    
    NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
    NSDictionary *headers = @{ @"content-type": @"json/application",
                               @"authorization": base64str };
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/Calender"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
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
            NSArray *bodyArr=[maindic objectForKey:@"body"];
            
            NSLog(@"status==%@& message=%@ details==%@ body arr==%@",self.status,self.message,detailArr,bodyArr);
            
            for(NSDictionary *subDic in bodyArr){
           // NSDictionary *subDic=[maindic objectForKey:@"body"];
             NSLog(@"subDic==%@",subDic);
            NSArray *ekadashArr=[subDic objectForKey:@"ekadash"];
            NSLog(@"ekadashArr==%@",ekadashArr);
            
            if(ekadashArr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no data." preferredStyle:UIAlertControllerStyleAlert];
                
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
                
                for(NSDictionary *temp in ekadashArr)
                {
                    NSString *str1=[[temp objectForKey:@"month"]description];
                    NSString *str2=[[temp objectForKey:@"krishnaPaksahEkadashi"]description];
                    NSString *str3=[[temp objectForKey:@"shuklaPakshaDwadashi"]description];
                    NSString *str4=[[temp objectForKey:@"shuklaPakshaEkadashi"]description];
                    NSString *str5=[[temp objectForKey:@"purnima"]description];
                    NSString *str6=[[temp objectForKey:@"amavasya"]description];
                    
                    NSLog(@"date=%@  day=%@ venue=%@ organisation=%@  contactPerson=%@  contactNumber=%@",str1,str2,str3,str4,str5,str6);
                    
                    
                    [self->_calendarArr addObject:temp];
                    NSLog(@"_eventArr ARRAYY%@",self->_calendarArr);
                }
            }
            [self->_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
            
        }
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
    return _calendarArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableDictionary *ktemp=[_calendarArr objectAtIndex:indexPath.row];
    
    cell.month.text=[[ktemp objectForKey:@"month"]description];
    cell.krishnaPaksahEkadashi.text=[[ktemp objectForKey:@"krishnaPaksahEkadashi"]description];
    cell.shuklaPakshaDwadashi.text=[[ktemp objectForKey:@"shuklaPakshaDwadashi"]description];
    cell.shuklaPakshaEkadashi.text=[[ktemp objectForKey:@"shuklaPakshaEkadashi"]description];
    cell.purnima.text=[[ktemp objectForKey:@"purnima"]description];
    cell.amavasya.text=[[ktemp objectForKey:@"amavasya"]description];

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 172;
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
