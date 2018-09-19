//
//  EventsViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 03/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "EventsViewController.h"
#import "Base.h"
#import "Constant.h"
#import "EventsTableViewCell.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _backgroundView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(225.0/225.0) green:(0.0/225.0) blue:(84.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(244.0/225.0) green:(219.0/225.0) blue:(72.0/255.0)alpha:1.0].CGColor];
    
    [_backgroundView.layer insertSublayer:gradient atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroundView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(0.0, 0.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _backgroundView.bounds;
    maskLayer.path = maskPath.CGPath;
    _backgroundView.layer.mask = maskLayer;
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _contactPersonArr=[[NSMutableArray alloc]init];
    _venueArr=[[NSMutableArray alloc]init];
    _organisationArr=[[NSMutableArray alloc]init];
    _dayArr=[[NSMutableArray alloc]init];
    _eventCountArr=[[NSMutableArray alloc]init];
    _dateEventArr=[[NSMutableArray alloc]init];
    _eventArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self dataEventParsing];
}
-(void)dataEventParsing
{
    [_contactPersonArr removeAllObjects];
    [_venueArr removeAllObjects];
    [_organisationArr removeAllObjects];
    [_dayArr removeAllObjects];
    [_eventCountArr removeAllObjects];
    [_dateEventArr removeAllObjects];
    [_eventArr removeAllObjects];
    
    NSString *username = @"admin";
    NSString *password = @"Adm1n@123";
    
    NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
    NSDictionary *headers = @{ @"content-type": @"json/application",
                               @"authorization": base64str };
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/events/eventsList"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
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
            
            if(bodyArr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no event data." preferredStyle:UIAlertControllerStyleAlert];
                
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
                    NSString *str1=[[temp objectForKey:@"date"]description];
                    NSString *str2=[[temp objectForKey:@"day"]description];
                    NSString *str3=[[temp objectForKey:@"venue"]description];
                    NSString *str4=[[temp objectForKey:@"organisation"]description];
                    NSString *str5=[[temp objectForKey:@"contactPerson"]description];
                    NSString *str6=[[temp objectForKey:@"contactNumber"]description];
                    NSString *str7=[[temp objectForKey:@"imagePath"]description];
                    NSString *str8=[[temp objectForKey:@"eventCount"]description];
                    
                    NSLog(@"date=%@  day=%@ venue=%@ organisation=%@  contactPerson=%@  contactNumber=%@ imagePath=%@ eventCount=%@",str1,str2,str3,str4,str5,str6,str7,str8);
                    
                    
                    [self->_eventArr addObject:temp];
                    NSLog(@"_eventArr ARRAYY%@",self->_eventArr);
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
    return _eventArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventsTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  
    NSMutableDictionary *ktemp=[_eventArr objectAtIndex:indexPath.row];

    cell.contactPerson.text=[[ktemp objectForKey:@"contactPerson"]description];
    cell.contactNumber.text=[[ktemp objectForKey:@"contactNumber"]description];
    cell.venue.text=[[ktemp objectForKey:@"venue"]description];
    cell.organisation.text=[[ktemp objectForKey:@"organisation"]description];
    cell.day.text=[[ktemp objectForKey:@"day"]description];
    cell.dateEvent.text=[[ktemp objectForKey:@"date"]description];
    cell.eventCount.text=[[ktemp objectForKey:@"eventCount"]description];
    cell.imageid.text=[[ktemp objectForKey:@"imagePath"]description];
    
    NSLog(@"CONTACT NUMBER%@ CONTACT PERSON%@   ",cell.contactNumber.text, cell.contactPerson.text);
    
    NSString *urlstr = [imgUrl stringByAppendingString:[[ktemp objectForKey:@"imagePath"]description]];
    NSLog(@"URL PATH=%@",urlstr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];

        dispatch_async(dispatch_get_main_queue(), ^{

            cell.imageBhajan.image = img1;

        });
    });
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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
