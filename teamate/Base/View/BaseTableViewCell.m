//
//  BaseTableViewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/27.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (UITableView *)tableView {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return  (UITableView *)self.superview.superview;
    } else {
        return (UITableView *)self.superview;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}


//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
////    //上分割线，
////    CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
////    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width , 1));
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 1));
//}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"CellID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

+ (instancetype)nibCellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"nibCellID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}


@end
