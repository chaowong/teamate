#import "FormCell_1.h"
#import "Model_1.h"
#import "JZTextView.h"
#import "MKMessagePhotoView.h"


@interface FormCell_1 ()<MKMessagePhotoViewDelegate>

@end

@implementation FormCell_1

//初始化自定义Cell对象的时候用
+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(FORM_CELL_TYPE)type
{
    //唯一标识，用于CELL重用
    static NSString *ID = @"FormCell2";
    // 先从缓存池中取,如果缓存池中没有可循环利用的cell,先去storyboard中找到合适的cell
    FormCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，再新建并添加标识，当cell移除屏幕时则放入缓存池便于复用
    if(cell==nil){
        cell = [[FormCell_1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID viewType:type];
    }
    return cell;
}

//初始化自定义Cell对象的时候用
- (instancetype)cellWithTableView:(UITableView *)tableView
{
    //唯一标识，用于CELL重用
    static NSString *ID = @"FormCell2";
    // 先从缓存池中取,如果缓存池中没有可循环利用的cell,先去storyboard中找到合适的cell
    FormCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，再新建并添加标识，当cell移除屏幕时则放入缓存池便于复用
    if(cell==nil){
        cell = [[FormCell_1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier viewType:(FORM_CELL_TYPE)viewType
{
    NSLog(@"======%u=====",viewType);
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        [self addSubViews];
        // 根据类型添加约束
        switch (viewType) {
            case 0:
                [self addConstraint_0];
                break;
            case 1:
                [self addConstraint_1];
                break;
            default:
                break;
        }
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
    self.textView.myPlaceholder=model.placeHolder;
    self.rightLabel.text = model.subTitle;
}

- (void)addSubViews
{
    //[self.contentView addSubview:self.leftMainTitle];
   
}

- (void)addConstraint_0
{
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.photoView];
    
    self.textView.sd_layout
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .topSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(self.contentView.width)
    .heightIs(80);
    
    self.photoView.sd_layout
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .topSpaceToView(self.textView,0)
    .widthIs(self.contentView.width)
    .heightIs(80);
    
}

- (void)addConstraint_1
{
    self.leftMainTitle.sd_layout
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(15);
    
    self.textView.sd_layout
    .leftSpaceToView(self.contentView,self.leftMainTitle.width+2*DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(self.contentView.width-DEFUALT_MARGIN_SIDES)
    .heightIs(80);
    
    self.photoView.sd_layout
    .leftSpaceToView(self.contentView,self.leftMainTitle.width+2*DEFUALT_MARGIN_SIDES)
    .topSpaceToView(self.textView,0)
    .widthIs(self.contentView.width-DEFUALT_MARGIN_SIDES)
    .heightIs(80);
    
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

-(JZTextView *)textView
{
    if (!_textView) {
        _textView = [[JZTextView alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
        //1.设置提醒文字
        //_textView.backgroundColor = [UIColor redColor];
        _textView.myPlaceholder=@"提示信息...";
        //2.设置提醒文字颜色
        _textView.myPlaceholderColor= [UIColor lightGrayColor];
    }
    return _textView;
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

-(MKMessagePhotoView *)photoView
{
    if (!_photoView) {
        _photoView = [[MKMessagePhotoView alloc]initWithFrame:CGRectMake(5,10,kWidth, 80)];
        _photoView.delegate = self;
    }
    return _photoView;
}

@end
