//
//  InnerGalleryCollectionViewCell.h
//  SanjayMittalBhajan
//
//  Created by Punit on 08/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InnerGalleryCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView *galleryImgView;

@property (weak, nonatomic) IBOutlet UILabel *directoryName;
@property (weak, nonatomic) IBOutlet UILabel *galleryid;
@property (weak, nonatomic) IBOutlet UILabel *imagePath;
@property (weak, nonatomic) IBOutlet UILabel *directory;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailPath;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailName;
@property (weak, nonatomic) IBOutlet UILabel *videoPath;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *parentId;
@end
