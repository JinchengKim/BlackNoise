//
//  SettingSwitchTableViewCell.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/25.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "SettingSwitchTableViewCell.h"

@interface SettingSwitchTableViewCell()
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation SettingSwitchTableViewCell


+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    SettingSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 28*2, 28)];
    self.switchBtn.onTintColor = RGBA (180, 180, 180,0.6);
    [self.contentView addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
//    self.switchBtn.tintColor = CLEARCOLOR/
    
    self.cellLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.cellLable.font = FONT(15);
    self.cellLable.textColor = [UIColor whiteColor];
    
    self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.subLabel.font = FONT(15);
    self.subLabel.textColor = [UIColor whiteColor];
    self.subLabel.alpha = 0.8;
    self.subLabel.textAlignment = NSTextAlignmentRight;
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.bottom - 0.5, SCREEN_WIDTH - 30, 0.5)];
    self.bottomLine.backgroundColor = [UIColor whiteColor];
    self.bottomLine.alpha = 0.5;
    
    [self.contentView addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.switchBtn.mas_right).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    [self.contentView addSubview:self.cellLable];
    [self.cellLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.switchBtn.mas_right).offset(15);
        make.bottom.equalTo(self.subLabel.mas_bottom).offset(-5);
    }];
    
    
    [self.contentView addSubview:self.bottomLine];
}

- (void)setTitle:(NSString*)title subTitle:(NSString*)subTitle{
    self.cellLable.text = title;
    self.subLabel.text = subTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
