//
//  RegisterViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 01/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "RegisterViewController.h"
#import "Base.h"
#import "Constant.h"
#import "Login.h"
#import "Role.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViewReg.layer.cornerRadius = self.imageViewReg.frame.size.width / 2;
    self.imageViewReg.clipsToBounds = YES;
    
    UIColor *color = [UIColor grayColor];
    _username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    _address.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color}];
    _email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter email" attributes:@{NSForegroundColorAttributeName: color}];
    _mobilenum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact No." attributes:@{NSForegroundColorAttributeName: color}];
    _password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    _confirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName: color}];
    
}

- (IBAction)createAccountBtnClicked:(id)sender {
    
    [self requestRegistrationdata];
}

-(void)requestRegistrationdata{
    
    NSDictionary *data = @{ @"username":self.username.text ,
     @"address":self.address.text ,
     @"email":self.email.text ,
     @"contactNumber":self.mobilenum.text ,
     @"password": self.password.text
     };
     
     NSError *error;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
     
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:registration]]];
     
     NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:nil timeoutInterval:60];
     [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
     [req setHTTPMethod:@"POST"];
     [req setHTTPBody:jsonData];
     
     NSString *retStr = [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];
     
     NSLog(@"Return resistration String%@",retStr);
     
    NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"response data:%@",maindic);
    
    self.status=[maindic objectForKey:@"status"];
    self.message=[maindic objectForKey:@"message"];
    
    NSArray *detailArr=[maindic objectForKey:@"details"];
    
    NSLog(@"status==%@& message=%@ details==%@",self.status,self.message,detailArr);
    
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        
    }];
    if ([self.status isEqual:@"true"]) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Registered successfully" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 //[self performSegueWithIdentifier:@"Home" sender:self];
                                 
                                 
                             }];
        
        [alertView addAction:ok];
//        [[NSUserDefaults standardUserDefaults] setObject:self.email.text forKey:@"email"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self presentViewController:alertView animated:YES completion:nil];
        

    }
    else{
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
