//
//  FeedbackViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 01/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *contactNum;
@property (weak, nonatomic) IBOutlet UITextField *feedbackText;
@property (strong,nonatomic) NSString *status,*message;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewReg;
@end
