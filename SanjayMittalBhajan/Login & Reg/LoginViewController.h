//
//  LoginViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 31/07/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
/*{
"status": true,
"message": "SUCCESS",
"details": [
            "LoggedIn Successfull"
            ],
"body": {
    "userId": 9,
    "username": "Pintu1",
    "address": "Nagpur",
    "email": "abc@gmail.com",
    "contactNumber": "1234516789",
    "enabled": true,
    "userRole": {
        "roleId": 1,
        "role": "ROLE_USER"
    }
}*/

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogin;
@property (nonatomic,retain) NSString *status,*success,*message,*details;

@end
