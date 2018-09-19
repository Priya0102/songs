//
//  GalleryViewController.h
//  SanjayMittalBhajan
//
//  Created by Punit on 01/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSMutableArray *galleryArr,*thumbnailArr;
@property(nonatomic,retain)NSString *indxp,*galleryIdStr,*titleStr,*status,*message,*currentPageNo,*totalCount,*totalPageSize;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView2;

@end

                      
