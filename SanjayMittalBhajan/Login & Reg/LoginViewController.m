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
    [_textFieldUsername becomeFirstResponder];
    
    _textFieldPassword.delegate=self;
    _textFieldUsername.delegate=self;
    

    UIColor *color = [UIColor grayColor];
    _textFieldUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    _textFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.imageViewLogin.layer.cornerRadius = self.imageViewLogin.frame.size.width / 2;
    self.imageViewLogin.clipsToBounds = YES;
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
    
    NSDictionary *data = @{ @"username":self.textFieldUsername.text ,
                                  @"password": self.textFieldPassword.text
                                  };
 
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:login]]];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:nil timeoutInterval:60];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:jsonData];
    
    NSString *retStr = [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];
    
    NSLog(@"Return String%@",retStr);
   
    NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"response data:%@",maindic);
    
    
    self.status=[maindic objectForKey:@"status"];
    self.message=[maindic objectForKey:@"message"];
    
    NSArray *detailArr=[maindic objectForKey:@"details"];
    
    NSLog(@"status==%@& message=%@ details==%@",self.status,self.message,detailArr);

    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        
    }];
    if ([self.status isEqual:@"false"]) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Entered credential is incorrect" preferredStyle:UIAlertControllerStyleAlert];
        
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
    else{
        
        NSDictionary *dic=[maindic objectForKey:@"body"];
        
        NSLog(@"user login dic%@",dic);
        
        
        Login *c=[[Login alloc]init];
        
        c.userId=[dic objectForKey:@"userId"];
        c.username=[dic objectForKey:@"username"];
        c.address=[dic objectForKey:@"address"];
        c.email=[dic objectForKey:@"email"];
        c.contactNum=[dic objectForKey:@"contactNumber"];
        c.enabled=[dic objectForKey:@"enabled"];
        c.userrole=[dic objectForKey:@"userRole"];
        
        NSLog(@"Username==%@ & Userrole==%@",c.username,c.userrole);
        
       
       
        
        
        
    }
}



@end
