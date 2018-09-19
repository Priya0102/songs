//
//  OpenImageViewController.m
//  SanjayMittalBhajan
#import "OpenImageViewController.h"
#import "Base.h"
@interface OpenImageViewController ()
{
    NSString *finalUrl;
}
@end

@implementation OpenImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.galleryId.text=_galleryidStr;
    NSLog(@"_galleryidStr ID===%@",_galleryidStr);
    
    NSString *str1=[@"/" stringByAppendingFormat:@"%@",_galleryidStr];
    NSLog(@"***str1***%@",str1);
    NSString *str2=[mainUrl stringByAppendingFormat:@"%@",galleryImage];
    NSLog(@"***str2***%@",str2);
    
    finalUrl=[str2 stringByAppendingFormat:@"%@",str1];
    NSLog(@"***finalUrl***%@",finalUrl);
    
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->finalUrl]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
             self.galleryImg.image = img1;
            
        });
    });
    
    
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
