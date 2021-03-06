//
//  LTAlertView.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/15.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTAlertView.h"

@interface LTAlertView ()
@property (nonatomic ,weak) UIView *backgroundView;
@property (nonatomic ,weak) UIView *contentView;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UIView *phoneView;
@property (nonatomic ,weak) UILabel *phoneNumLabel;
@property (nonatomic ,weak) UILabel *phoneLabel;
@property (nonatomic ,weak) UIButton *sendMsgButton;
@property (nonatomic ,weak) UIView *topLineView;
@property (nonatomic ,weak) UIView *telView;
@property (nonatomic ,weak) UILabel *telNumLabel;
@property (nonatomic ,weak) UILabel *telLabel;
@property (nonatomic ,weak) UIView *centerLineView;
@property (nonatomic ,weak) UIView *sortTelView;
@property (nonatomic ,weak) UILabel *sortTelNumLabel;//短号
@property (nonatomic ,weak) UILabel *sortTelLabel;
@property (nonatomic ,weak) UIButton *contactBtn;
@end

@implementation LTAlertView

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    if (self) {
        [self setUI];
        NSLog(@"dict:%@",dict);
        self.nameLabel.text = [dict objectForKey:@"realname"];
        self.phoneNumLabel.text = [dict objectForKey:@"phone"]?[dict objectForKey:@"phone"]:@"";
    }
    
    return self;
}

- (void)setUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    self.backgroundView = backgroundView;
    [self addSubview:backgroundView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleBtnClick)];
    [backgroundView addGestureRecognizer:tap];
    
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor blueColor];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:24];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:nameLabel];
    
    UIView *phoneView = [[UIView alloc] init];
    self.phoneView = phoneView;
    phoneView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:phoneView];
    
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    self.phoneNumLabel = phoneNumLabel;
    phoneNumLabel.textColor = [UIColor grayColor];
    phoneNumLabel.font = [UIFont systemFontOfSize:14.f];
    [phoneView addSubview:phoneNumLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    self.phoneLabel = phoneLabel;
    phoneLabel.text = @"手机";
    phoneLabel.textColor = [UIColor grayColor];
    phoneLabel.font = [UIFont systemFontOfSize:14.f];
    [phoneView addSubview:phoneLabel];
    
    UIButton *sendMsgButton = [[UIButton alloc] init];
    self.sendMsgButton = sendMsgButton;
    [sendMsgButton setTitle:@"发送短信" forState:UIControlStateNormal];
    [sendMsgButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendMsgButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    sendMsgButton.layer.cornerRadius = 4.f;
    sendMsgButton.layer.masksToBounds = YES;
    sendMsgButton.layer.borderWidth = 0.5f;
    sendMsgButton.layer.borderColor = [UIColor grayColor].CGColor;
    [phoneView addSubview:sendMsgButton];
    
    UIView *topLineView = [[UIView alloc] init];
    self.topLineView = topLineView;
    topLineView.backgroundColor = [UIColor grayColor];
    [phoneView addSubview:topLineView];
    
    UIView *telView = [[UIView alloc] init];
    self.telView = telView;
    telView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:telView];
    
    UILabel *telNumLabel = [[UILabel alloc] init];
    self.telNumLabel = telNumLabel;
    telNumLabel.textColor = [UIColor grayColor];
    telNumLabel.font = [UIFont systemFontOfSize:14.f];
    [telView addSubview:telNumLabel];
    
    UILabel *telLabel = [[UILabel alloc] init];
    self.telLabel = telLabel;
    telLabel.text = @"座机";
    telLabel.textColor = [UIColor grayColor];
    telLabel.font = [UIFont systemFontOfSize:14.f];
    [telView addSubview:telLabel];
    
    UIView *centerLineView = [[UIView alloc] init];
    self.centerLineView = centerLineView;
    centerLineView.backgroundColor = [UIColor grayColor];
    [telView addSubview:centerLineView];
    
    UIView *sortTelView = [[UIView alloc] init];
    self.sortTelView = sortTelView;
    sortTelView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:sortTelView];
    
    UILabel *sortTelNumLabel = [[UILabel alloc] init];
    self.sortTelNumLabel = sortTelNumLabel;
    sortTelNumLabel.textColor = [UIColor grayColor];
    sortTelNumLabel.font = [UIFont systemFontOfSize:14.f];
    [sortTelView addSubview:sortTelNumLabel];
    
    UILabel *sortTelLabel = [[UILabel alloc] init];
    self.sortTelLabel = sortTelLabel;
    sortTelLabel.text = @"短号";
    sortTelLabel.textColor = [UIColor grayColor];
    sortTelLabel.font = [UIFont systemFontOfSize:14.f];
    [sortTelView addSubview:sortTelLabel];
    
    UIButton *contactBtn = [[UIButton alloc] init];
    self.contactBtn = contactBtn;
    contactBtn.backgroundColor = [UIColor clearColor];
    [contactBtn setTitle:@"与TA沟通" forState:UIControlStateNormal];
    [contactBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:contactBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = _MainScreen_Width - 86;
    CGFloat contentH = 243;
    self.contentView.bounds = CGRectMake(0, 0, contentW, contentH);
    self.contentView.center = self.center;
    
    self.nameLabel.frame = CGRectMake(0, 0, contentW, 80);
    
    self.phoneView.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), contentW, 60);
    self.phoneNumLabel.frame = CGRectMake(12, 0, contentW-12*2-60, 30);
    self.phoneLabel.frame = CGRectMake(12, 30, self.phoneNumLabel.frame.size.width, 30);
    self.sendMsgButton.frame = CGRectMake(contentW-12-60, 15, 60, 30);
    self.topLineView.frame = CGRectMake(0, self.phoneView.frame.size.height-0.5, contentW, 0.5);
    
    self.telView.frame = CGRectMake(0, CGRectGetMaxY(self.phoneView.frame), contentW, 60);
    self.telNumLabel.frame = CGRectMake(12, 0, contentW-12*2, 30);
    self.telLabel.frame = CGRectMake(12, 30, self.telNumLabel.frame.size.width, 30);
    self.centerLineView.frame = CGRectMake(0, self.telView.frame.size.height-0.5, contentW, 0.5);
    
    self.sortTelView.frame = CGRectMake(0, CGRectGetMaxY(self.telView.frame), contentW, 60);
    self.sortTelNumLabel.frame = CGRectMake(12, 0, contentW-12*2, 30);
    self.sortTelLabel.frame = CGRectMake(12, 30, self.sortTelNumLabel.frame.size.width, 30);
    
    self.contactBtn.frame = CGRectMake(0, CGRectGetMaxY(self.sortTelView.frame), contentW, 48);
    
    self.contentView.bounds = CGRectMake(0, 0, contentW, CGRectGetMaxY(self.contactBtn.frame));
    self.contentView.center = self.center;
}

- (void)cancleBtnClick{
    if (_cancelButtonClicked) {
        self.cancelButtonClicked();
        [self removeFromSuperview];
    }  else {
        [self removeFromSuperview];
    }
}

- (void)sureBtnClick{
    if (_contactButtonClicked) {
        self.contactButtonClicked();
    }
    [self removeFromSuperview];
}

- (void)contactCustomerServiceLinkClicked
{
    if (_sendMsgButtonClicked) {
        self.sendMsgButtonClicked();
    }
    [self removeFromSuperview];
}

@end

@interface LTLiuchengAlertView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) UIView *contentView;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) UIButton *cancelBtn;
@property (nonatomic ,strong) NSArray *array;
@end

@implementation LTLiuchengAlertView

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    if (self) {
        self.array = array;
        [self setLiuchenUI];
        [self.tableView reloadData];
    }
    
    return self;
}

- (void)setLiuchenUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LTLiuchengTableViewCell"];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [contentView addSubview:tableView];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    self.cancelBtn = cancelBtn;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = _MainScreen_Width - 86;
    CGFloat contentH = 243;
    self.contentView.bounds = CGRectMake(0, 0, contentW, contentH);
    self.contentView.center = self.center;
    
    CGFloat tableH = (self.array.count?self.array.count:1)*44;
    if (tableH+48 > _MainScreen_Height-86) {
        tableH = _MainScreen_Height-86-48;
    }
    self.tableView.frame = CGRectMake(0, 0, contentW, tableH);
    
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), contentW, 48);
    
    self.contentView.bounds = CGRectMake(0, 0, contentW, CGRectGetMaxY(self.cancelBtn.frame));
    self.contentView.center = self.center;
}

- (void)cancleBtnClick{
    if (_cancelButtonClicked) {
        self.cancelButtonClicked();
        [self removeFromSuperview];
    }  else {
        [self removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LTLiuchengTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
    
    UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, 0.5, 44.f)];
    hLineView.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:hLineView];
    
    UIView *rView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 4, 4)];
    rView.layer.cornerRadius = 2.f;
    rView.layer.masksToBounds = YES;
    rView.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:rView];
    if (indexPath.row == 0) {
        rView.backgroundColor = [UIColor colorWithRed:25/255.f green:200/255.f blue:35/255.f alpha:1.0];
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, self.contentView.frame.size.width-28, 22)];
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [NSString stringWithFormat:@"流程%ld",indexPath.row+1];
    [cell addSubview:titleLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 22, self.contentView.frame.size.width-28, 22)];
    descLabel.font = [UIFont systemFontOfSize:12.f];
    descLabel.textColor = [UIColor colorWithRed:25/255.f green:200/255.f blue:35/255.f alpha:1.0];
    [cell addSubview:descLabel];
    descLabel.text = [dict objectForKey:@"title"];
//    NSLog(@"%@", dict);
    
    return cell;
}

@end

@interface LTListAlertView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) UIView *contentView;
@property (nonatomic ,weak) UILabel *titleLabel;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) UIButton *cancelBtn;
@property (nonatomic ,strong) NSArray *array;
@end

@implementation LTListAlertView

- (instancetype)initWithArray:(NSArray *)array title:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    if (self) {
        self.array = array;
        [self setListUI];
        self.titleLabel.text = title;
        [self.tableView reloadData];
    }
    
    return self;
}

- (void)setListUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    [contentView addSubview:titleLabel];
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LTListTableViewCell"];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [contentView addSubview:tableView];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    self.cancelBtn = cancelBtn;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = _MainScreen_Width - 86;
    CGFloat contentH = 243;
    self.contentView.bounds = CGRectMake(0, 0, contentW, contentH);
    self.contentView.center = self.center;
    
    self.titleLabel.frame = CGRectMake(12, 0, self.contentView.frame.size.width-24, 40);
    CGFloat tableH = (self.array.count?self.array.count:1)*32;
    if (tableH+48+40 > _MainScreen_Height-86) {
        tableH = _MainScreen_Height-86-48-40;
    }
    self.tableView.frame = CGRectMake(0, 40, contentW, tableH);
    
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), contentW, 48);
    
    self.contentView.bounds = CGRectMake(0, 0, contentW, CGRectGetMaxY(self.cancelBtn.frame));
    self.contentView.center = self.center;
}

- (void)cancleBtnClick{
    if (_cancelButtonClicked) {
        self.cancelButtonClicked();
        [self removeFromSuperview];
    }  else {
        [self removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LTListTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.contentView.frame.size.width-12, 32)];
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [dict objectForKey:@"name"];
    [cell addSubview:titleLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_checkItemClicked) {
        self.checkItemClicked([self.array objectAtIndex:indexPath.row]);
        [self removeFromSuperview];
    }  else {
        [self removeFromSuperview];
    }
}

@end

@interface LTMultiSelectAlertView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) UIView *contentView;
@property (nonatomic ,weak) UILabel *titleLabel;
@property (nonatomic ,weak) UIButton *selectAllBtn;
@property (nonatomic ,weak) UIView *topLineView;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) UIView *bottomLineView;
@property (nonatomic ,weak) UIButton *confirmBtn;
@property (nonatomic ,weak) UIButton *cancelBtn;
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSMutableArray *selectArray;
@property (nonatomic ,strong) NSString *key;

@end

@implementation LTMultiSelectAlertView

- (instancetype)initWithArray:(NSArray *)array title:(NSString *)title listTitlekey:(NSString *)key canSelectAll:(BOOL)selectAll
{
    self = [super initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    if (self) {
        self.array = array;
        self.key = key;
        self.selectArray = [NSMutableArray new];
        [self setListUI:selectAll];
        self.titleLabel.text = title;
        [self.tableView reloadData];
    }
    
    return self;
}

- (void)setListUI:(BOOL)selectAll{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    [contentView addSubview:titleLabel];
    
    UIButton *selectAllBtn = [[UIButton alloc] init];
    self.selectAllBtn = selectAllBtn;
    [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [selectAllBtn addTarget:self action:@selector(selectAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:selectAllBtn];
    
    UIView *topLineView = [[UIView alloc] init];
    self.topLineView = topLineView;
    topLineView.backgroundColor = [UIColor colorWithRed:232/255.f green:232/255.f blue:232/255.f alpha:232/255.f];
    [contentView addSubview:topLineView];
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LTMultiSelectTableViewCell"];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [contentView addSubview:tableView];
    
    UIView *bottomLineView = [[UIView alloc] init];
    self.bottomLineView = bottomLineView;
    bottomLineView.backgroundColor = [UIColor colorWithRed:232/255.f green:232/255.f blue:232/255.f alpha:232/255.f];
    [contentView addSubview:bottomLineView];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    self.confirmBtn = confirmBtn;
    confirmBtn.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    confirmBtn.layer.cornerRadius = 4.f;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confirmBtn];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    self.cancelBtn = cancelBtn;
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.layer.cornerRadius = 4.f;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancelBtn.layer.borderWidth = 0.5;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = _MainScreen_Width - 86;
    CGFloat contentH = 243;
    self.contentView.bounds = CGRectMake(0, 0, contentW, contentH);
    self.contentView.center = self.center;
    
    self.titleLabel.frame = CGRectMake(12, 0, self.contentView.frame.size.width-24, 40);
    self.selectAllBtn.frame = CGRectMake(self.contentView.frame.size.width-68, 0, 60, 40);
    self.topLineView.frame = CGRectMake(0, 39.5, self.contentView.frame.size.width, 0.5);
    CGFloat tableH = (self.array.count?self.array.count:1)*40;
    if (tableH+48+40 > _MainScreen_Height-86) {
        tableH = _MainScreen_Height-86-48-40;
    }
    self.tableView.frame = CGRectMake(0, 40, contentW, tableH);
    self.bottomLineView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.contentView.frame.size.width, 0.5);
    
    self.confirmBtn.frame = CGRectMake(8, CGRectGetMaxY(self.tableView.frame)+8, (contentW-24)/2.f, 40);
    self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.confirmBtn.frame)+8, CGRectGetMaxY(self.tableView.frame)+8, (contentW-24)/2.f, 40);
    
    self.contentView.bounds = CGRectMake(0, 0, contentW, CGRectGetMaxY(self.cancelBtn.frame)+8);
    self.contentView.center = self.center;
}

- (void)confirmBtnClick{
    if (_confirmButtonClicked) {
        self.confirmButtonClicked(self.selectArray);
        [self removeFromSuperview];
    }else{
        [self removeFromSuperview];
    }
}

- (void)cancleBtnClick{
    if (_cancelButtonClicked) {
        self.cancelButtonClicked();
        [self removeFromSuperview];
    }  else {
        [self removeFromSuperview];
    }
}

- (void)selectAllBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"全选"]) {
        //全选
        self.selectArray = [NSMutableArray arrayWithArray:self.array];
        [self.selectAllBtn setTitle:@"取消全选" forState:UIControlStateNormal];
    }else{
        //取消全选
        self.selectArray = [NSMutableArray new];;
        [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
    BOOL selected = NO;
    if ([self.selectArray containsObject:dict]) {
        selected = YES;
    }else{
        selected = NO;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"LTMultiSelectTableViewCell_%ld_%d", indexPath.row, selected];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 20, 20)];
    if ([self.selectArray containsObject:dict]) {
        checkImageView.image = SY_IMAGE(@"radiobutton_pressed");
    }else{
        checkImageView.image = SY_IMAGE(@"radiobutton_numal");
    }
    [cell addSubview:checkImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.contentView.frame.size.width-48, 40)];
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [dict objectForKey:self.key];
    [cell addSubview:titleLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
    if ([self.selectArray containsObject:dict]) {
        [self.selectArray removeObject:dict];
    }else{
        [self.selectArray addObject:dict];
    }
    if (self.selectArray.count == self.array.count) {
        [self.selectAllBtn setTitle:@"取消全选" forState:UIControlStateNormal];
    }else{
        [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
    NSArray <NSIndexPath *> *indexPathArray = @[indexPath];
    [tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
