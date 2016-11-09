//
//  MKMessagePhotoView.h
//
//  Created by Mory on 16/3/12.
//  Copyright © 2016年 MCWonders. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MKComposePhotosView.h"
#import "ZYQAssetPickerController.h"
#import "TZImagePickerController.h"
#define kZBMessageShareMenuPageControlHeight 30

@class MKMessagePhotoView;
@protocol MKMessagePhotoViewDelegate <NSObject>

@optional
- (void)didSelectePhotoMenuItem:(MKComposePhotosView *)shareMenuItem atIndex:(NSInteger)index;

-(void)addPicker:(ZYQAssetPickerController *)picker;          //UIImagePickerController
-(void)addPickers:(TZImagePickerController *)picker1;          //UIImagePickerController

-(void)addUIImagePicker:(UIImagePickerController *)picker;

@end
typedef void(^passValueBlock)(NSArray *name);

@interface MKMessagePhotoView : UIView<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,MKComposePhotosViewDelegate,ZYQAssetPickerControllerDelegate>{
    ///下拉菜单
    UIActionSheet *myActionSheet;
    
    ///图片2进制路径
    NSString* filePath;
}
@property(nonatomic,strong) UIScrollView *scrollview;

/**
 *  第三方功能Models
 */
@property (nonatomic, strong )NSMutableArray *array;

@property(nonatomic,strong) NSMutableArray *itemArray;

@property (nonatomic, assign) id <MKMessagePhotoViewDelegate> delegate;

@property(nonatomic ,copy)passValueBlock passValue;
@property (nonatomic,strong) UIScrollView  *photoScrollView;

@end
