//
//  OpenImageViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 08/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *galleryId;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImg;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property(nonatomic,retain)NSString *indxp,*galleryidStr;

@end
