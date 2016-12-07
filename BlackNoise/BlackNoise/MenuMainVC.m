//
//  MenuMainVC.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/15.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "MenuMainVC.h"
#import "SettingMainVC.h"

#import "UIButtonEx.h"
#import "MenuMainTableViewCell.h"

#define Btn_Padding_Left 15
#define Btn_Padding_Top 30
#define Animation_Padding 50
#define Cell_Height 50 * ScreenWidthRatioBase375

#define TableViewBottomPadding 25*ScreenWidthRatioBase375
#define TableViewTopPadding 80*ScreenWidthRatioBase375

@interface MenuMainVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
//@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIButtonEx *dismissBtn;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *iconTitle;
@property (nonatomic, strong) UILabel *iconSubTitle1;
@property (nonatomic, strong) UILabel *iconSubTitle2;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *bottomLable;

@end

@implementation MenuMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViews{
    
    [self.view addSubview:self.dismissBtn];
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(Btn_Padding_Left);
        make.top.equalTo(self.view.mas_top).offset(Btn_Padding_Top);
    }];
    
    [self.view addSubview:self.bottomLable];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLable.mas_top).offset(-TableViewBottomPadding);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 5*Cell_Height));
    }];
    
    [self.view addSubview:self.iconSubTitle2];
    [self.iconSubTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.tableView.mas_top).offset(-TableViewTopPadding);
    }];
    
    [self.view addSubview:self.iconSubTitle1];
    [self.iconSubTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.iconSubTitle2.mas_top);
    }];
    
    [self.view addSubview:self.iconTitle];
    [self.iconTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.iconSubTitle1.mas_top).offset(-5);
    }];
    
    [self.view addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(87, 87));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.iconTitle.mas_top).offset(-10);
    }];
    
    self.tableView.alpha = 0;
    self.dismissBtn.alpha = 0;
    self.iconView.alpha = 0;
    self.iconTitle.alpha = 0;
    self.iconSubTitle1.alpha = 0;
    self.iconSubTitle2.alpha = 0;
    self.bottomLable.alpha = 0;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tableView.alpha == 0) {
        [self animation];
    }
}

- (void)animation{
    self.tableView.bottom += 100;
    
    self.dismissBtn.bottom += 100;
    
    self.iconView.bottom +=100;
    
    self.iconTitle.bottom +=100;
    
    self.iconSubTitle1.bottom +=100;
    
    self.iconSubTitle2.bottom +=100;
    
    self.bottomLable.bottom +=100;
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        self.tableView.bottom -= 100;

        self.dismissBtn.bottom -= 100;

        self.iconView.bottom -=100;

        self.iconTitle.bottom -=100;

        self.iconSubTitle1.bottom -=100;

        self.iconSubTitle2.bottom -=100;

        self.bottomLable.bottom -=100;
                         
                         self.tableView.alpha = 1;
                         self.dismissBtn.alpha = 1;
                         self.iconView.alpha = 1;
                         self.iconTitle.alpha = 1;
                         self.iconSubTitle1.alpha = 0.3;
                         self.iconSubTitle2.alpha = 0.3;
                         self.bottomLable.alpha = 0.1;
    }
                     completion:nil];
    
}

#pragma mark - Actions
- (void)dismissThisVC{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Cell_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuMainTableViewCell *cell = [MenuMainTableViewCell cellWithTableView:tableView reuseIdentifier:@"kMenuMainTableViewCell"];
    
    if (indexPath.row == 0){
        cell.cellLable.text = @"设置";
        cell.cellIconView.image = IMG(@"menu_settings");
    }else if (indexPath.row == 1){
        cell.cellLable.text = @"意见反馈";
        cell.cellIconView.image = IMG(@"menu_feedback");
    }else if (indexPath.row == 2){
        cell.cellLable.text = @"给我打分";
        cell.cellIconView.image = IMG(@"menu_rate");
    }else if (indexPath.row == 3){
        cell.cellLable.text = @"分享给朋友";
        cell.cellIconView.image = IMG(@"menu_share");
    }else if (indexPath.row == 4){
        cell.cellLable.text = @"关于";
        cell.cellIconView.image = IMG(@"menu_about");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if  (indexPath.row == 0){
        SettingMainVC *vc = [[SettingMainVC alloc] init];
        vc.bgImage = self.bgImage;

        PUSHVIEW(vc);
    }else if  (indexPath.row == 1){
    
    }else if  (indexPath.row == 2){
    
    }else if  (indexPath.row == 3){
    
    }else if  (indexPath.row == 4){
    
    }
}

#pragma mark - Setters & Getters

- (UIButtonEx *)dismissBtn{
    if (_dismissBtn == nil) {
        _dismissBtn = [UIButtonEx new];
        _dismissBtn.frame = CellButtonFrame28;
        [_dismissBtn setBackgroundImage:IMG(@"global_close_icon") forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissThisVC) forControlEvents:UIControlEventTouchUpInside];

    }
    return _dismissBtn;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.image = IMG(@"Logo_160");
        _iconView.layer.cornerRadius = 16;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)iconTitle{
    if (_iconTitle == nil) {
        _iconTitle = [UILabel new];
        _iconTitle.font = FONT(18);
        _iconTitle.text = @"潮汐";
        _iconTitle.textColor = [UIColor whiteColor];
        _iconTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _iconTitle;
}

- (UILabel *)iconSubTitle1{
    if (_iconSubTitle1 == nil) {
        _iconSubTitle1 = [UILabel new];
        _iconSubTitle1.text = @"保持专注，遇见心流";
        _iconSubTitle1.alpha = 0.3;
        _iconSubTitle1.font = FONT(12);
        _iconSubTitle1.textColor = [UIColor whiteColor];
        _iconSubTitle1.textAlignment = NSTextAlignmentCenter;
    }
    return _iconSubTitle1;
}

- (UILabel *)iconSubTitle2{
    if (_iconSubTitle2 == nil) {
        _iconSubTitle2 = [UILabel new];
        _iconSubTitle2.text = @"一段美好的专注时光";
        _iconSubTitle2.alpha = 0.3;
        _iconSubTitle2.font = FONT(12);
        _iconSubTitle2.textColor = [UIColor whiteColor];
        _iconSubTitle2.textAlignment = NSTextAlignmentCenter;
    }
    return _iconSubTitle2;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Cell_Height * 5) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = CLEARCOLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UILabel *)bottomLable{
    if (_bottomLable == nil) {
        _bottomLable = [UILabel new];
        _bottomLable.text = @"XONE LAB";
        _bottomLable.alpha = 0.1;
        _bottomLable.font = FONT(14);
        _bottomLable.textColor = [UIColor whiteColor];
        _bottomLable.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLable;
}
@end
