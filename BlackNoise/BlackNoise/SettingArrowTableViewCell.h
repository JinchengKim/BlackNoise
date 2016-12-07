//
//  SettingArrowTableViewCell.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/25.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingArrowTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *cellLable;
@property (nonatomic, strong) UILabel *subLabel;

+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setTitle:(NSString*)title subTitle:(NSString*)subTitle;
@end
