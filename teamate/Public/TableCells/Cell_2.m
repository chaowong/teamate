#import "Cell_2.h"
#import "Model_1.h"

@implementation Cell_2

//初始化自定义Cell对象的时候用
- (instancetype)cellWithTableView:(UITableView *)tableView
{
    //唯一标识，用于CELL重用
    static NSString *ID = @"CommonCell2";
    // 先从缓存池中取,如果缓存池中没有可循环利用的cell,先去storyboard中找到合适的cell
    Cell_2 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，再新建并添加标识，当cell移除屏幕时则放入缓存池便于复用
    if(cell==nil){
        cell = [[Cell_2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.leftIconImage.image = [UIImage imageNamed:model.imageUrl];
    self.leftMainTitle.text= model.mainTitle;
    self.rightLabel.text = model.subTitle;
}

- (void)addSubViews{
    [self.contentView addSubview:self.leftIconImage];
    [self.contentView addSubview:self.leftMainTitle];
    [self.contentView addSubview:self.rightLabel];
}

- (void)addConstraint{

    self.leftIconImage.sd_layout
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightIs(40)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
    self.leftMainTitle.sd_layout
    .leftSpaceToView(self.leftIconImage,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(100)
    .heightIs(15);
    
    self.rightLabel.sd_layout
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(105)
    .heightIs(30);
}

- (UIImageView *)leftIconImage{
    if (!_leftIconImage) {
        _leftIconImage = [[UIImageView alloc] init];
        _leftIconImage.image = [UIImage imageNamed:@"go-to-work"];
        _leftIconImage.layer.cornerRadius = BTN_CORNER_RADIUS;
        _leftIconImage.layer.masksToBounds = YES;
    }
    return _leftIconImage;
}

- (UILabel *)leftMainTitle{
    if (!_leftMainTitle) {
        _leftMainTitle = [[UILabel alloc] init];
        _leftMainTitle.text = @"主标题";
        _leftMainTitle.font = kFont(15);
    }
    return _leftMainTitle;
    
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = GZFontWithSize(14);
        _rightLabel.textColor = TXT_COLOR;
    }
    return _rightLabel;
}

@end
