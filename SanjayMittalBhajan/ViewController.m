//
//  ViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 30/07/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
/*
 //
 //  LoginViewController.m
 //  SanjayMittalBhajan
 //
 //  Created by Punit on 31/07/18.
 //  Copyright © 2018 Eshiksa. All rights reserved.
 //
 
 #import "LoginViewController.h"
 #import "ACFloatingTextField.h"
 #import "Constant.h"
 #import "Base.h"
 #import "Login.h"
 #import "Role.h"
 @interface LoginViewController ()<UITextFieldDelegate>
 //@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldtextFieldUsername;
 //@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldtextFieldPassword;
 
 @end
 
 @implementation LoginViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // [_textFieldtextFieldPassword becomeFirstResponder];
 }
 //- (IBAction)showErrorTap:(UIButton *)sender {
 //    [_textFieldtextFieldPassword showErrorWithText:@"textFieldPassword should not less than 6 characters."];
 //    [_textFieldtextFieldUsername showError];
 //}
 
 -(BOOL)textFieldShouldReturn:(UITextField *)textField {
 [_textFieldUsername resignFirstResponder];
 return true;
 }
 - (IBAction)loginclicked:(id)sender {
 
 
 UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
 indicator.frame=CGRectMake(self.view.window.center.x,self.view.window.center.y, 40.0, 40.0);
 indicator.center=self.view.center;
 [self.view addSubview:indicator];
 
 
 indicator.tintColor=[UIColor redColor];
 indicator.backgroundColor=[UIColor lightGrayColor];
 [indicator bringSubviewToFront:self.view];
 // [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
 [indicator startAnimating];
 if(self.textFieldUsername.text.length==0 && self.textFieldPassword.text.length==0)
 {
 UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter username and password" preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alertView dismissViewControllerAnimated:YES completion:nil];
 
 }];
 
 [alertView addAction:ok];
 [indicator stopAnimating];
 
 [self presentViewController:alertView animated:YES completion:nil];
 
 }
 if(self.textFieldUsername.text.length==0)
 {
 UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"First enter your username" preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alertView dismissViewControllerAnimated:YES completion:nil];
 
 }];
 
 [alertView addAction:ok];
 [indicator stopAnimating];
 
 [indicator stopAnimating];
 
 [self presentViewController:alertView animated:YES completion:nil];
 }
 if(self.textFieldPassword.text.length==0)
 {
 UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"First enter your password" preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alertView dismissViewControllerAnimated:YES completion:nil];
 
 }];
 
 [alertView addAction:ok];
 [indicator stopAnimating];
 
 [self presentViewController:alertView animated:YES completion:nil];
 }
 
 
 if(self.textFieldUsername.text.length>0 && self.textFieldPassword.text.length>0)
 {
 NSLog(@"hi");
 
 [self requestLogindata];
 }
 
 }
 
 
 
 -(void)requestLogindata{
 
 /* NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:login]];
 NSLog(@"mainstr1*********%@",mainstr1);
 
 
 NSDictionary *parameterDict = @{
 @"username":self.textFieldUsername.text,
 @"password":self.textFieldPassword.text,
 };
 
 NSLog(@"Parameter*********%@",parameterDict);
 
 //    [Constant executequery:mainstr1 strpremeter:parameterDict
 //                 withblock:^(NSData * dbdata, NSError *error) {
 //                     NSLog(@"data:%@",dbdata);
 //                     if (dbdata!=nil) {
 //                         NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
 //                         NSLog(@"response data:%@",maindic);
 //
 
 //                         self.status=[responseDict objectForKey:@"status"];
 //                         self.message=[responseDict objectForKey:@"message"];
 //
 //                        NSArray *detailArr=[responseDict objectForKey:@"details"];
 //
 //                        NSLog(@"status==%@& message=%@ details==%@",self.status,self.message,detailArr);
 //
 //
 //                         [[NSOperationQueue mainQueue]addOperationWithBlock:^{
 //
 //                         }];
 //                         if ([self.status isEqual:@"false"]) {
 //
 //                             UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Entered credential is incorrect" preferredStyle:UIAlertControllerStyleAlert];
 //
 //                             UIAlertAction* ok = [UIAlertAction
 //                                                  actionWithTitle:@"OK"
 //                                                  style:UIAlertActionStyleDefault
 //                                                  handler:^(UIAlertAction * action)
 //                                                  {
 //                                                      [alertView dismissViewControllerAnimated:YES completion:nil];
 //
 //                                                  }];
 //
 //                             [alertView addAction:ok];
 //                             [self presentViewController:alertView animated:YES completion:nil];
 //                         }
 //                         else{
 

NSString *mystr=[NSString stringWithFormat:@"username=%@&password=%@",self.textFieldUsername.text,self.textFieldPassword.text];

NSLog(@"parameterDict in currnt route list%@",mystr);

NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

NSURL * url = [NSURL URLWithString:@"http://35.200.153.165:8080/Sanjay_Mittal_Bhajans/user/login"];

NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];

[urlRequest setHTTPMethod:@"POST"];
[urlRequest setHTTPBody:[mystr dataUsingEncoding:NSUTF8StringEncoding]];
NSError *error=nil;
if(error)
{
}
NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                 {
                                     if(error)
                                     {
                                     }
                                     
                                     NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                     NSLog(@"text==%@",text);
                                     NSError *er=nil;
                                     NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
                                     if(er)
                                     {
                                     }
                                     NSLog(@"responseDict:%@",responseDict);
                                     
                                     NSDictionary *dic=[responseDict objectForKey:@"body"];
                                     
                                     NSLog(@"user login dic%@",dic);
                                     
                                     
                                     Login *c=[[Login alloc]init];
                                     
                                     c.userId=[dic objectForKey:@"userId"];
                                     c.username=[dic objectForKey:@"username"];
                                     c.address=[dic objectForKey:@"address"];
                                     c.email=[dic objectForKey:@"email"];
                                     c.contactNum=[dic objectForKey:@"contactNumber"];
                                     c.enabled=[dic objectForKey:@"enabled"];
                                     
                                     NSLog(@"Username==%@",c.username);
                                     
                                     NSDictionary *dic2=[dic objectForKey:@"userRole"];
                                     Role *r=[[Role alloc]init];
                                     r.roleId=[dic2 objectForKey:@"roleId"];
                                     r.role=[dic2 objectForKey:@"role"];
                                     
                                     
                                     NSLog(@"role==%@",r.role);
                                 }];
[dataTask resume];

}
@end

 
 */
