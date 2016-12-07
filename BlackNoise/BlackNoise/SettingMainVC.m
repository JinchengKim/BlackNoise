//
//  SettingMainVC.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "SettingMainVC.h"
#import "SettingArrowTableViewCell.h"
#import "SettingSwitchTableViewCell.h"

#define Btn_Padding_Left 15
#define Cell_Height 44

#define TableViewBottomPadding 25*ScreenWidthRatioBase375
#define TableViewTopPadding 80*ScreenWidthRatioBase375

@interface SettingMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView{
    [self addFakeNavBar];
    [self setNavTitle:@"设置"];
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 5;
    } else if (section == 3) {
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingArrowTableViewCell *arrowCell = [SettingArrowTableViewCell cellWithTableView:tableView reuseIdentifier:@"kSettingArrowTableViewCell"];
    SettingSwitchTableViewCell *switchCell = [SettingSwitchTableViewCell cellWithTableView:tableView reuseIdentifier:@"kSettingSwitchTableViewCell"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [arrowCell setTitle:@"专注时长" subTitle:@"120分钟"];
            return arrowCell;
        }
        
        if (indexPath.row == 1) {
            [arrowCell setTitle:@"休息" subTitle:nil];
            return arrowCell;
        }
        
        if (indexPath.row == 2) {
            [arrowCell setTitle:@"自动专注" subTitle:nil];
            return arrowCell;
        }
        
        if (indexPath.row == 3) {
            [switchCell setTitle:@"沉浸模式" subTitle:nil];
            return switchCell;
            
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [switchCell setTitle:@"白噪声" subTitle:nil];
            return switchCell;

        }
        
        if (indexPath.row == 1) {
            [switchCell setTitle:@"与音乐融合" subTitle:nil];
            return switchCell;

        }
        
        if (indexPath.row == 2) {
            [arrowCell setTitle:@"音量" subTitle:nil];
            return arrowCell;

        }

        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [arrowCell setTitle:@"专注提醒" subTitle:nil];
            return arrowCell;
            
        }
        
        if (indexPath.row == 1) {
            [switchCell setTitle:@"苹果健康" subTitle:nil];
            return switchCell;
            
        }
        
        if (indexPath.row == 2) {
            [switchCell setTitle:@"屏幕常亮" subTitle:nil];
            return switchCell;
            
        }
        if (indexPath.row == 3) {
            [switchCell setTitle:@"使用 3G/4G 网络" subTitle:nil];
            return switchCell;
            
        }

        if (indexPath.row == 4) {
            [arrowCell setTitle:@"语言" subTitle:@"简体中文"];
            return arrowCell;
            
        }

    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 20)];
    titleLabel.font = FONT(12);
    titleLabel.alpha = 0.4;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        titleLabel.text = @"专注设置";
    }else if(section == 1){
        titleLabel.text = @"白噪声设置";
    }else if(section == 2){
        titleLabel.text = @"高级";
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(15, 29.5, SCREEN_WIDTH-30, 0.5)];
    bottomLine.alpha = 0.4;
    
    bottomLine.backgroundColor = [UIColor whiteColor];
    [header addSubview:titleLabel];
    [header addSubview:bottomLine];
    return header;
}

#pragma mark - Setter and Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = CLEARCOLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;

}
@end
