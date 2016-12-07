//
//  SettingBaseVC.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNBaseVC.h"

@interface SettingBaseVC : BNBaseVC<UINavigationControllerDelegate>
- (void)setNavTitle:(NSString *)title;

- (void)hideFakeNavBar;
- (void)addFakeNavBar;
@end
