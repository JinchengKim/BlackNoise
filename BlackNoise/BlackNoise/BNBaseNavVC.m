//
//  BNBaseNavVC.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNBaseNavVC.h"
#import "UIImage+Screenshot.h"
#import "UIImage+ImageEffects.h"

@interface BNBaseNavVC ()
@property (nonatomic, strong) UIImageView *bgView;
@end

@implementation BNBaseNavVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
    self.view.backgroundColor = CLEARCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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

- (void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    _bgView.image = _bgImage;
}
@end
