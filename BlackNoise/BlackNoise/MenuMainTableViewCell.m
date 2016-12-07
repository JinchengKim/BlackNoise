//
//  MenuMainTableViewCell.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/15.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "MenuMainTableViewCell.h"

@interface MenuMainTableViewCell()
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation MenuMainTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    MenuMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
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
    
    self.cellIconView = [[UIImageView alloc] initWithFrame:CellButtonFrame28];
    self.cellIconView.contentMode = UIViewContentModeScaleToFill;
    
    self.arrowView = [[UIImageView alloc] initWithFrame:CellButtonFrame26];
    self.arrowView.contentMode = UIViewContentModeScaleToFill;
    self.arrowView.image = IMG(@"menu_rightarrow_icon");
    
    self.cellLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.cellLable.font = FONT(15);
    self.cellLable.textColor = [UIColor whiteColor];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.bottom - 0.5, SCREEN_WIDTH - 30, 0.5)];
    self.bottomLine.backgroundColor = [UIColor whiteColor];
    self.bottomLine.alpha = 0.5;
    
    [self.contentView addSubview:self.cellIconView];
    [self.cellIconView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(28, 28));
    }];
    
    [self.contentView addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.cellLable];
    [self.cellLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.cellIconView.mas_right).offset(15);
        make.right.equalTo(self.arrowView.mas_right).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.bottomLine];
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
