//
//  NoteTableviewCell.h
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PlaceholderTextView.h"
@interface NoteTableviewCell : BaseTableViewCell
@property (nonatomic ,strong)UILabel *leftlabel;
@property (nonatomic, strong) PlaceholderTextView * textView;

@end
