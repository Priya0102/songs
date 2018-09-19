//
//  AboutViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 02/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _aboutView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(225.0/225.0) green:(0.0/225.0) blue:(84.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(244.0/225.0) green:(219.0/225.0) blue:(72.0/255.0)alpha:1.0].CGColor];
    
    [_aboutView.layer insertSublayer:gradient atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_aboutView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(0.0, 0.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _aboutView.bounds;
    maskLayer.path = maskPath.CGPath;
    _aboutView.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
