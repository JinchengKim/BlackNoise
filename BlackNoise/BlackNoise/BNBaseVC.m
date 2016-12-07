//
//  BNBaseVC.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/15.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNBaseVC.h"
#import "UIImage+Screenshot.h"
#import "UIImage+ImageEffects.h"

@interface BNBaseVC ()

@end

@implementation BNBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
    self.view.backgroundColor = CLEARCOLOR;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.coverView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters and Getters
- (UIImage *)screenImage{
    return [[UIImage screenshot] applyLightEffect];
}

- (UIImageView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.image = self.bgImage;
        _bgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgView;
}

- (UIImageView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.image = self.bgImage;
        _coverView.contentMode = UIViewContentModeScaleToFill;
        _coverView.alpha = 0;
        _coverView.hidden = YES;
    }
    return _coverView;
}

- (void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    _bgView.image = _bgImage;
    _coverView.image = _bgImage;
}
@end
