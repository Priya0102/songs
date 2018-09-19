//
//  Login.h
//  SanjayMittalBhajan
//
//  Created by Punit on 31/07/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

@property (nonatomic,strong) NSString *userId,*username,*address,*email,*contactNum,*enabled,*userrole;
/*   {
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
 }
 }*/

@end
