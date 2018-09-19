//
//  InnerGalleryViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 08/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InnerGalleryViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSMutableArray *galleryArr,*thumbnailArr;
@property(nonatomic,retain)NSString *indxp,*galleryidStr,*titleStr,*status,*message,*currentPageNo,*totalCount,*totalPageSize;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView2;
@property (weak, nonatomic) IBOutlet UILabel *galleryId;

@end
