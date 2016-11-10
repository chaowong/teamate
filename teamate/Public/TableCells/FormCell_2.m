#import "FormCell_2.h"
#import "Model_1.h"

@implementation FormCell_2

//初始化自定义Cell对象的时候用
- (instancetype)cellWithTableView:(UITableView *)tableView
{
    //唯一标识，用于CELL重用
    static NSString *ID = @"FormCell2";
    // 先从缓存池中取,如果缓存池中没有可循环利用的cell,先去storyboard中找到合适的cell
    FormCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，再新建并添加标识，当cell移除屏幕时则放入缓存池便于复用
    if(cell==nil){
        cell = [[FormCell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        [self addSubViews];
        // 添加约束
        [self addConstraint];
    }
    return self;
}

/**
 重写set方法，模型传递
 @param model 模型
 */
-(void)setModel:(Model_1 *)model
{
    _model = model;
    self.leftMainTitle.text= model.mainTitle;
    //self.rightLabel.text = model.subTitle;
    UIColor *color = [UIColor lightGrayColor];
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.placeHolder attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)addSubViews
{
    [self.contentView addSubview:self.leftMainTitle];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.rightLabel];
}

- (void)addConstraint
{
    self.leftMainTitle.sd_layout
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(15);
    
    self.textField.sd_layout
    .leftSpaceToView(self.leftMainTitle,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(self.contentView.width-DEFUALT_MARGIN_SIDES)
    .heightIs(30);
    
    self.rightLabel.sd_layout
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(105)
    .heightIs(30);
}

- (UILabel *)leftMainTitle
{
    if (!_leftMainTitle) {
        _leftMainTitle = [[UILabel alloc] init];
        _leftMainTitle.text = @"标题";
        _leftMainTitle.font = kFont(17);
    }
    return _leftMainTitle;
    
}

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
        UIColor *color = [UIColor lightGrayColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"提示文字..." attributes:@{NSForegroundColorAttributeName: color}];
    }
    return _textField;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = GZFontWithSize(14);
        _rightLabel.textColor = TXT_COLOR;
    }
    return _rightLabel;
}

@end
