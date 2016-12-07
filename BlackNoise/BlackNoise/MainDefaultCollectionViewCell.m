//
//  MainDefaultCollectionViewCell.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/16.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "MainDefaultCollectionViewCell.h"
#import "BNRippleLayer.h"
#import "BNProgressLayer.h"
#import "MinPickerView.h"
#import "CountDownMinLabel.h"
#import "BNTimer.h"

@interface MainDefaultCollectionViewCell() <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *circleBtn;
@property (nonatomic, strong) MinPickerView *pickerView;
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPageControl *pageControler;
@property (nonatomic, strong) CountDownMinLabel *countDownLabel;
@property (nonatomic, strong) UIView *backContentView;
@property (nonatomic, strong) UIView *frontContentView;

@property (nonatomic, strong) BNRippleLayer *rippleLayer;
@property (nonatomic, strong) BNProgressLayer *progressLayer;

@property (nonatomic, strong) NSMutableArray *pickerData;
@end

@implementation MainDefaultCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.pickerData = [NSMutableArray arrayWithObjects:,nil];
        self.pickerData = [NSMutableArray arrayWithCapacity:14];
        [self.pickerData addObject:@"05"];
        [self.pickerData addObject:@"10"];
        [self.pickerData addObject:@"15"];
        [self.pickerData addObject:@"20"];
        [self.pickerData addObject:@"25"];
        [self.pickerData addObject:@"30"];
        [self.pickerData addObject:@"35"];
        [self.pickerData addObject:@"40"];
        [self.pickerData addObject:@"45"];
        [self.pickerData addObject:@"50"];
        [self.pickerData addObject:@"55"];
        [self.pickerData addObject:@"60"];
        [self.pickerData addObject:@"90"];
        [self.pickerData addObject:@"120"];
        
        [self setUpViews];
        self.playerState = BNPlayerStateStandby;
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setUpViews{
    self.backgroundColor = CLEARCOLOR;
    [self addSubview:self.bgView];
    
    [self.layer addSublayer:self.progressLayer];
    [self.layer addSublayer:self.rippleLayer];
    
    [self addSubview:self.backContentView];
    [self addSubview:self.frontContentView];
    
    [self.frontContentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.frontContentView.mas_centerX);
        make.centerY.equalTo(self.frontContentView.mas_centerY);
    }];
    
    [self.frontContentView addSubview:self.pageControler];
    [self.pageControler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.frontContentView.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.backContentView addSubview:self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView.mas_centerX);
        make.centerY.equalTo(self.backContentView.mas_centerY);
    }];

    [self addSubview:self.pickerView];
    [self addSubview:self.minLabel];
    

    [self addSubview:self.circleBtn];
}

#pragma mark - Layer


#pragma mark - Animation

-(void)beginPlayingAnimation{
    [self.rippleLayer resumeAnimation];
}

- (void)pausePlayingAnimation{
    [self.rippleLayer stopAnimation];
}

- (void)resumePlayingAnimation{
    [self.rippleLayer resumeAnimation];
}

- (void)endPlayingAnimation{
    [self.rippleLayer endAnimation];
}

- (void)noSoundPlayingAnimation{
    [self.rippleLayer endAnimation];
}

- (void)haveSoundPlayingAnimation{
    [self.rippleLayer beginAnimation];
}

- (void)showPickerView{
    [UIView animateWithDuration:1 animations:^{
        [self.pickerView setHidden:NO];
        [self.minLabel setHidden:NO];
        
        [self.frontContentView setHidden:YES];
        [self.circleBtn setHidden:YES];
    }];
}

- (void)hidePickerView{
    [UIView animateWithDuration:1 animations:^{
        [self.pickerView setHidden:YES];
        [self.minLabel setHidden:YES];
        
        [self.frontContentView setHidden:NO];
        [self.circleBtn setHidden:NO];
    }];
}

- (void)hideTitleLabelAndShowTimer{
    self.backContentView.layer.transform = CATransform3DMakeRotation(M_PI, 0, -1, 0);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.frontContentView.alpha = 0;
        self.frontContentView.layer.transform = CATransform3DMakeRotation(M_PI,0,1,0);
    }completion:^(BOOL flag){
        if (flag) {
            self.frontContentView.hidden = YES;
        }
    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
        self.backContentView.layer.transform = CATransform3DMakeRotation(M_PI*2 , 0, -1, 0);
        self.backContentView.alpha = 1;
        self.backContentView.hidden = NO;
                     }completion:^(BOOL flag){
                     }];
    
    self.pickerView.hidden = YES;
    self.minLabel.hidden = YES;
    self.circleBtn.hidden = NO;
}

- (void)showTitleLabelAndHideTimer{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         self.backContentView.alpha = 0;
                         self.backContentView.layer.transform = CATransform3DMakeRotation(M_PI,0,1,0);
                     }completion:^(BOOL flag){
                         if (flag) {
                            self.backContentView.hidden = YES;
                         }
                     }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.frontContentView.hidden = NO;
        self.frontContentView.alpha = 1;
        self.frontContentView.layer.transform = CATransform3DMakeRotation(0,0,1,0);
    }completion:^(BOOL flag){}];
}

#pragma mark - Action
- (void)circleBtnClick{
    
    if (self.playerState == BNPlayerStateStandby) {
        [self showPickerView];
    }else if(self.playerState >= BNPlayerStatePlaying){
        if (self.changeSoundState) {
            self.changeSoundState();
        }
    }
}



- (void)voidAction{
    
}

#pragma mark - delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 14;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    [(MinPickerView *)pickerView stopTimer];
    
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CircleLength/2, 40)];
    NSString *min = [self.pickerData objectAtIndex:row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CircleLength/2, 40)];
    label.font = FONT(CircleLength/5);
    label.textColor = [UIColor whiteColor];
    label.text = min;
    label.textAlignment = NSTextAlignmentCenter;
    [rowView addSubview:label];
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [(MinPickerView *)pickerView addTimer];
    self.sec =  [self.pickerData[row] intValue] * 60;
}


#pragma mark - Setter and Getter

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = self.bounds;
        _bgView.backgroundColor = RandomColor;
        _bgView.alpha = 0.2;
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(0, 0, CircleLength * 2, CircleLength * 2 );
        _titleLabel.font = CircleDefaultzFont(40);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIButton *)circleBtn{
    if (_circleBtn == nil) {
        _circleBtn = [[UIButton alloc] init];
        _circleBtn.frame = CGRectMake(0, 0, CircleLength * 2, CircleLength * 2);
        _circleBtn.layer.cornerRadius = CircleLength;
        _circleBtn.center = self.progressLayer.position;
        [_circleBtn addTarget:self action:@selector(circleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleBtn;
}

- (BNRippleLayer *)rippleLayer{
    if (_rippleLayer == nil) {
        _rippleLayer = [BNRippleLayer layer];
        _rippleLayer.frame = CGRectMake(SCREEN_WIDTH/2 - ProgressLength, CircleMarginTop, ProgressLength * 2, ProgressLength * 2);
    }
    return _rippleLayer;
}

- (BNProgressLayer *)progressLayer{
    if (_progressLayer == nil) {
        _progressLayer = [BNProgressLayer layer];
        _progressLayer.frame = CGRectMake(SCREEN_WIDTH/2 - ProgressLength, CircleMarginTop, ProgressLength * 2, ProgressLength * 2);
    }
    return _progressLayer;
}

- (UIPageControl *)pageControler{
    if (_pageControler == nil) {
        _pageControler = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - CircleLength)/2, CircleLength + CircleMarginTop + CircleLength/2, CircleLength, 20)];
        _pageControler.backgroundColor = [UIColor clearColor];
        _pageControler.pageIndicatorTintColor = RGBA(255, 255, 255, 0.5);;
        _pageControler.currentPageIndicatorTintColor = RGBA(255, 255, 255, 1);
        _pageControler.numberOfPages = 5;
    }
    return _pageControler;
}

- (MinPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[MinPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 0, CircleLength , CircleLength);
        _pickerView.center = self.progressLayer.position;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.hidden = YES;
        UISwipeGestureRecognizer *swipeUpGe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(voidAction)];
        swipeUpGe.direction=UISwipeGestureRecognizerDirectionUp;
        [_pickerView addGestureRecognizer:swipeUpGe];
        WeakSelf
        _pickerView.hideBlock = ^(BOOL hidden){
            if (hidden) {
                [weakSelf hidePickerView];
            }
        };
    }
    return _pickerView;
}

- (UILabel *)minLabel{
    if (_minLabel == nil) {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CircleLength, 40)];
        _minLabel.font = FONT(CircleLength/5-8);
        _minLabel.textAlignment = NSTextAlignmentLeft;
        _minLabel.textColor = [UIColor whiteColor];
        _minLabel.alpha = 0.5;
        _minLabel.text = @"分钟";
        _minLabel.hidden = YES;
        _minLabel.center = self.progressLayer.position;
        _minLabel.left = self.pickerView.right - CircleLength/4;
    }
    return _minLabel;
}

- (CountDownMinLabel *)countDownLabel{
    if (_countDownLabel == nil) {
        _countDownLabel = [[CountDownMinLabel alloc] initWithFrame:CGRectMake(0, 0, CircleLength, CircleLength/3)];
        _countDownLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:CircleLength/3 + 3];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
        _countDownLabel.textColor = [UIColor whiteColor];
        _countDownLabel.center = self.backContentView.center;
    }
    return _countDownLabel;
}

- (UIView *)backContentView{
    if (_backContentView == nil) {
        _backContentView = [[UIView alloc] init];
        _backContentView.frame = CGRectMake(0, 0, CircleLength * 2, CircleLength * 2);
        _backContentView.center = self.progressLayer.position;
        _backContentView.backgroundColor = CLEARCOLOR;
        _backContentView.hidden = YES;
        _backContentView.alpha = 0;
    }
    return _backContentView;
}

- (UIView *)frontContentView{
    if (_frontContentView == nil) {
        _frontContentView = [[UIView alloc] init];
        _frontContentView.frame = CGRectMake(0, 0, CircleLength * 2 , CircleLength * 2);
        _frontContentView.center = self.progressLayer.position;
        _frontContentView.backgroundColor = CLEARCOLOR;
        
    }
    return _frontContentView;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer){
            
        }];

    }
    return _timer;
}

- (void)setPageNum:(int8_t)pageNum{
    _pageNum = pageNum;
    _pageControler.currentPage = _pageNum;
    [_pageControler sizeForNumberOfPages:_pageNum];
    NSArray *titles = @[@"晚上好",@"雨天",@"森林",@"冥想",@"咖啡"];
    NSArray *colors = @[RGB(216, 216, 216),RGB(74, 144, 226),RGB(126, 211, 33),RGB(189, 16, 224),RGB(255, 166, 0)];
    self.titleLabel.text = titles[_pageNum];
    _bgView.backgroundColor = colors[_pageNum];
    
}

- (void)setPlayerState:(BNPlayerState)playerState{
    
    if (_playerState == BNPlayerStateEnd ||
        _playerState == BNPlayerStateStandby ) {
        if (playerState >= BNPlayerStatePlaying) {
            [self hideTitleLabelAndShowTimer];
            [self.countDownLabel setTotalSec:1000];
        }
    }
    _playerState = playerState;
    switch (_playerState) {
        case BNPlayerStateStandby:

            break;
        case BNPlayerStatePlaying:
        {
        }
            break;
        case BNPlayerStateStop:
        {
            [self pausePlayingAnimation];
        }
            break;
        case BNPlayerStateEnd:
            
        {
            [self endPlayingAnimation];
            [self showTitleLabelAndHideTimer];
            _playerState = BNPlayerStateStandby;
        }
            break;
        case BNPlayerStateSound:
        {
            [self haveSoundPlayingAnimation];
        }
            break;
        case BNPlayerStateNoSound:
        {
            [self noSoundPlayingAnimation];
        }
            break;
    }
}

- (void)setCountDownLabelLefSec:(int64_t)sec{
    [self.countDownLabel setTextWithSec:sec];
}


- (void)setSec:(int32_t)sec{
    _sec = sec;
}

@end
