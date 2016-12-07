//
//  MenuMainTableViewCell.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/15.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuMainTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellIconView;
@property (nonatomic, strong) UILabel *cellLable;
+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier;
@end
