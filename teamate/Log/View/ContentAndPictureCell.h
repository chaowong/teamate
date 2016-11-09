//
//  ContentAndPictureCell.h
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PlaceholderTextView.h"
@class MKMessagePhotoView;
@interface ContentAndPictureCell : BaseTableViewCell
@property (nonatomic, strong) PlaceholderTextView * textView;
@property (nonatomic, strong) MKMessagePhotoView *photosView;
@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
@end
