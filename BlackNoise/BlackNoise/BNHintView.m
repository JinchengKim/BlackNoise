//
//  BNHintView.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/30.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNHintView.h"

@interface BNHintView()
@property (nonatomic, strong) UIView *hintBgView;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, assign) BOOL showHint;
@end

@implementation BNHintView
+ (instancetype)sharedHintView {
    
    static BNHintView *hintView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hintView = [[BNHintView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,64)];

    });
    return hintView;
}

+ (void)showHint:(NSString *)message; {
    BNHintView *hintView = [BNHintView sharedHintView];
    if (!hintView.showHint) {
        [[UIApplication sharedApplication].keyWindow addSubview:hintView];
        hintView.showHint = YES;
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeThisView) object:nil];
    }
    
    hintView.hintLabel.text = message;
    [self removeViewAfterDelay:3];
}
+ (void)showHint:(NSString *)message onView:(UIView *)view {

    BNHintView *hintView = [BNHintView sharedHintView];
    if (!hintView.showHint) {
        [view addSubview:hintView];

        hintView.showHint = YES;
        
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeThisView) object:nil];
    }
    [self removeViewAfterDelay:3];
    hintView.hintLabel.text = message;
}

+ (void)removeViewAfterDelay:(NSTimeInterval)ti{
//    BNHintView *hintView = [BNHintView sharedHintView];
    [self performSelector:@selector(removeThisView) withObject:nil afterDelay:ti];
}

+ (void)removeThisView{
    BNHintView *hintView = [BNHintView sharedHintView];
    [hintView removeFromSuperview];
    hintView.showHint = NO;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hintBgView];
        [self addSubview:self.hintLabel];
        [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.hintBgView.mas_left);
            make.right.equalTo(self.hintBgView.mas_right);
            make.top.equalTo(self.hintBgView.mas_top).offset(28);
            make.bottom.equalTo(self.hintBgView.mas_bottom).offset(-8);
        }];
        self.showHint = NO;
    }
    
    return self;
}

#pragma mark - Getter and Setter
- (UILabel *)hintLabel{
    if (_hintLabel == nil) {
        _hintLabel = [UILabel new];
        _hintLabel.textColor = [UIColor whiteColor];
        _hintLabel.font = FONT(18);
        _hintLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hintLabel;
}

- (UIView *)hintBgView{
    if (_hintBgView == nil) {
        _hintBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _hintBgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return _hintBgView;
}
@end
