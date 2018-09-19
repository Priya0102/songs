//
//  PdfTableViewCell.h
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *audioImg;
@property (weak, nonatomic) IBOutlet UILabel *pdfPath;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailPath;
@property (weak, nonatomic) IBOutlet UILabel *filename;
@property (weak, nonatomic) IBOutlet UILabel *pdfSize;
@property (weak, nonatomic) IBOutlet UILabel *downloadUrl;
@property (weak, nonatomic) IBOutlet UILabel *tags;

@end
