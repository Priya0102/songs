//
//  WebViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic,strong) NSString *myURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicaor;
@end
