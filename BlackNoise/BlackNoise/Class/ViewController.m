//
//  ViewController.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/12.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "ViewController.h"
#import "MenuMainVC.h"

#import "UIButtonEx.h"
#import "MainDefaultCollectionViewCell.h"
#import "BNHintView.h"

#import <AVFoundation/AVFoundation.h>
#import "BNAudioPlayer.h"
#import "BNTimer.h"
#import "NSTimer+ABlock.h"

#define MenuBtn_Padding_Left 15
#define MenuBtn_Padding_Top 30
#define Btn_Height 38 * ScreenWidthRatioBase375
#define Btn_Width SCREEN_WIDTH/3
#define SBtn_width SCREEN_WIDTH/4
#define Btn_top CircleLength*3 + CircleMarginTop

#define kMainDefaultCollectionViewCell @"kMainDefaultCollectionViewCell"

@interface ViewController () <AVAudioPlayerDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CAAnimationDelegate>
@property (nonatomic, strong) BNAudioPlayer *player;

@property (nonatomic, strong) UIButtonEx *menuBtn;
@property (nonatomic, strong) UIButtonEx *dayCardBtn;
@property (nonatomic, strong) UIButtonEx *beginBtn;
@property (nonatomic, strong) UIButtonEx *stopBtn;
@property (nonatomic, strong) UIButtonEx *resumeBtn;
@property (nonatomic, strong) UIButtonEx *endBtn;
@property (nonatomic, strong) MainDefaultCollectionViewCell *indexCell;
@property (nonatomic, strong) UIImageView *tempBgView;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UICollectionView *coverCollectionView;
@property (nonatomic, strong) UIButtonEx *statisticBtn;
@property (nonatomic, strong) UILabel *aphorismLabel;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int64_t playSec;
@property (nonatomic, assign) BNPlayerState playerState;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}

- (void)setUpViews{
    
    [self.view addSubview:self.bgScrollView];
    [self.view addSubview:self.coverCollectionView];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self.view addSubview:self.menuBtn];
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(MenuBtn_Padding_Left);
        make.top.equalTo(self.view.mas_top).offset(MenuBtn_Padding_Top);
    }];
    
    [self.view addSubview:self.dayCardBtn];
    [self.dayCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-MenuBtn_Padding_Left);
        make.top.equalTo(self.view.mas_top).offset(MenuBtn_Padding_Top);
    }];
    
    [self.view addSubview:self.beginBtn];
    [self.beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Btn_Width, Btn_Height));
        make.top.equalTo(self.view.mas_top).offset(Btn_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.stopBtn];
    [self.stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SBtn_width, Btn_Height));
        make.top.equalTo(self.view.mas_top).offset(Btn_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.resumeBtn];
    [self.resumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SBtn_width, Btn_Height));
        make.top.equalTo(self.view.mas_top).offset(Btn_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.view addSubview:self.endBtn];
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SBtn_width, Btn_Height));
        make.top.equalTo(self.view.mas_top).offset(Btn_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    [self.view addSubview:self.statisticBtn];
    [self.statisticBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
    
    [self.view addSubview:self.aphorismLabel];
    [self.aphorismLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.statisticBtn.mas_top).offset(-40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - timer
- (void)resumeTimer{
    if (![self.timer isValid]) {
        return ;
    }
    
    [self.timer setFireDate:[NSDate date]];

}

- (void)stopTimer{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)beginTimer{
    WeakSelf
    self.timer = [NSTimer timerWithTimeInterval:1.0f userInfo:nil repeats:YES block:^(NSTimer *timer){
        if (weakSelf.playSec-- == 0){
            [weakSelf timeOverAnimation];
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

- (void)endTimer{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - animation

- (void)beginBtnClickAnimation{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat top = self.beginBtn.top;
                         self.beginBtn.frame = CGRectMake((SCREEN_WIDTH - SBtn_width)/2, top, SBtn_width, Btn_Height);
                         self.beginBtn.alpha = 0;
                         self.stopBtn.hidden = NO;
                         self.stopBtn.alpha = 0.5;
    }
                     completion:^(BOOL finish){
                         if (finish){
                             self.beginBtn.hidden = YES;
                             self.view.userInteractionEnabled = YES;
                         }
    }];
}

- (void)stopBtnClickAnimation{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat top = self.stopBtn.top;
                         CGFloat padding = (SCREEN_WIDTH - SBtn_width*2 - 15)/2;
                         self.resumeBtn.hidden = NO;
                         self.endBtn.hidden = NO;
                         self.endBtn.alpha = 0.5;
                         self.resumeBtn.alpha = 1;
                         self.resumeBtn.frame = CGRectMake(padding, top, self.endBtn.width, self.endBtn.height);
                         self.endBtn.frame = CGRectMake(SCREEN_WIDTH - SBtn_width - padding, top, self.endBtn.width, self.endBtn.height);
                         
                         self.stopBtn.alpha = 0;
                     }
                     completion:^(BOOL finish){
                         if (finish){
                             self.stopBtn.hidden = YES;
                             self.view.userInteractionEnabled = YES;
                         }
                     }];

}

- (void)resumeBtnClickAnimation{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.endBtn.alpha = 0;
                         self.resumeBtn.alpha = 0;
                         self.resumeBtn.frame = self.stopBtn.frame;
                         self.endBtn.frame = self.stopBtn.frame;
                         
                         self.stopBtn.alpha = 0.5;
                         self.stopBtn.hidden = NO;
                     }
                     completion:^(BOOL finish){
                         if (finish){
                             self.endBtn.hidden = YES;
                             self.resumeBtn.hidden = YES;
                             self.view.userInteractionEnabled = YES;
                         }
                     }];
}

- (void)endBtnClickAnimation{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.endBtn.alpha = 0;
                         self.resumeBtn.alpha = 0;
                         self.resumeBtn.frame = self.stopBtn.frame;
                         self.endBtn.frame = self.stopBtn.frame;
                         
                         self.beginBtn.hidden = NO;
                         self.beginBtn.alpha = 1;
                         self.beginBtn.frame = CGRectMake(SCREEN_WIDTH/3, self.endBtn.top, Btn_Width, Btn_Height);
                     }
                     completion:^(BOOL finish){
                         if (finish){
                             self.endBtn.hidden = YES;
                             self.resumeBtn.hidden = YES;
                             self.view.userInteractionEnabled = YES;
                         }
                     }];
}

#pragma mark - action
- (void)playMusic{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"Muse" ofType:@"m4a"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:musicFilePath]) {
        NSData *song = [[NSData alloc] initWithContentsOfFile:musicFilePath];
        self.player = [[BNAudioPlayer alloc] initWithData:song error:nil];
        [self.player play];
    }
}

- (void)presentMenuVC{
    MenuMainVC *vc = [[MenuMainVC alloc] init];
    vc.bgImage = self.screenImage;
    UINavigationController *navVC = [[UINavigationController alloc] init];
    navVC.viewControllers = @[vc];
    ALPHAUPVIEW(navVC);
}

- (void)presentDayCardVC{
    
}

- (void)beginBtnClick{
    int page = (int)(self.coverCollectionView.contentOffset.x/SCREEN_WIDTH);
    self.coverCollectionView.contentOffset = CGPointMake(page * SCREEN_WIDTH,self.coverCollectionView.contentOffset.y);
    self.indexCell = (MainDefaultCollectionViewCell *)[self.coverCollectionView cellForItemAtIndexPath:[self.coverCollectionView indexPathForItemAtPoint:CGPointMake(page * SCREEN_WIDTH + 1, 1)]];
    self.playSec = (self.indexCell.sec <= 0 ? 300 : self.indexCell.sec) + 1;
    [self beginTimer];
    WeakSelf
    self.indexCell.changeSoundState = ^(){
        if([[[NSUserDefaults standardUserDefaults] objectForKey:kHaveSound] isEqualToString:@"YES"]){
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kHaveSound];
            weakSelf.playerState = BNPlayerStatePlaying;
            [BNHintView showHint:@"已关闭白噪声"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kHaveSound];
            weakSelf.playerState = BNPlayerStatePlaying;
            [BNHintView showHint:@"白噪声已开启"];
        }
    };
    [self beginBtnClickAnimation];
    
    self.playerState = BNPlayerStatePlaying;
    [self.coverCollectionView setScrollEnabled:NO];
    
    self.player = [BNAudioPlayer initPlayerWithPage:self.indexCell.pageNum];
    [self.player play];
}

- (void)stopBtnClick{
     
    [self stopBtnClickAnimation];
    
    [self stopTimer];
    self.playerState = BNPlayerStateStop;
    [self.player pause];
}

- (void)resumeBtnClick{
    
    [self resumeBtnClickAnimation];
    
    [self resumeTimer];
    self.playerState = BNPlayerStatePlaying;
    [self.player play];
}

- (void)endBtnClick{
     
    [self endBtnClickAnimation];
    
    [self endTimer];
    self.playerState = BNPlayerStateEnd;
    [self.coverCollectionView setScrollEnabled:YES];
    
    [self.player stop];
}

- (void)timeOverAnimation{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.stopBtn.alpha = 0;
                         
                         self.beginBtn.hidden = NO;
                         self.beginBtn.alpha = 1;
                         self.beginBtn.frame = CGRectMake(SCREEN_WIDTH/3, self.endBtn.top, Btn_Width, Btn_Height);
                     }
                     completion:^(BOOL finish){
                         if (finish){
                             self.stopBtn.hidden = YES;
                             self.view.userInteractionEnabled = YES;
                         }
                     }];
    [self endTimer];
    self.playerState = BNPlayerStateEnd;
    [self.coverCollectionView setScrollEnabled:YES];
    [self.player stop];
}

#pragma mark - playerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"player is finished");
    }
}

#pragma mark - collection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainDefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainDefaultCollectionViewCell forIndexPath:indexPath];
    if (cell == nil){
        cell = [[MainDefaultCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    cell.pageNum = indexPath.row;
    return cell;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.coverCollectionView]) {
        CGFloat offset = (scrollView.contentOffset.x/(SCREEN_WIDTH * 5)) * 100;
        [self.bgScrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }else if([scrollView isEqual:self.bgScrollView]){
        
    }
}

#pragma mark - Setters & Getters
- (AVAudioPlayer *)player{
    if (_player == nil) {
        _player = [BNAudioPlayer initEmptyPlayer];
        _player.delegate = self;
    }
    return _player;
}

- (UIButtonEx *)menuBtn{
    if (_menuBtn == nil) {
        _menuBtn = [UIButtonEx new];
        _menuBtn.frame = CellButtonFrame26;
        [_menuBtn setBackgroundImage:IMG(@"menu_icon") forState:UIControlStateNormal];
        [_menuBtn addTarget:self action:@selector(presentMenuVC) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _menuBtn;
}

- (UIButtonEx *)dayCardBtn{
    if (_dayCardBtn == nil) {
        _dayCardBtn = [UIButtonEx new];
        _dayCardBtn.frame = CellButtonFrame26;
        [_dayCardBtn setBackgroundImage:IMG(@"daycard_icon") forState:UIControlStateNormal];
        [_dayCardBtn addTarget:self action:@selector(presentDayCardVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dayCardBtn;
}

- (UIButtonEx *)beginBtn{
    if (_beginBtn == nil) {
        _beginBtn = [UIButtonEx buttonWithType:UIButtonTypeCustom];
        _beginBtn.titleLabel.font = FONT(Btn_Height/2-2);
        _beginBtn.layer.masksToBounds = YES;
        _beginBtn.layer.cornerRadius = Btn_Height/2;
        [_beginBtn setHighlightedCoverColor:RGBA(0,0,0,0.1)];
        [_beginBtn setBackgroundColor:RGB(237, 76, 76) forState:UIControlStateNormal];
        [_beginBtn setTitle:@"开始专注" forState:UIControlStateNormal];
        [_beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginBtn;
}

- (UIButtonEx *)stopBtn{
    if (_stopBtn == nil) {
        _stopBtn = [UIButtonEx buttonWithType:UIButtonTypeCustom];
        _stopBtn.titleLabel.font = FONT(Btn_Height/2-2);
        _stopBtn.layer.masksToBounds = YES;
        _stopBtn.layer.cornerRadius = Btn_Height/2;
        _stopBtn.layer.borderWidth = 1;
        [_stopBtn setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopBtn setHighlightedCoverColor:RGBA(255,255,255,0.1)];
        [_stopBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_stopBtn addTarget:self action:@selector(stopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _stopBtn.hidden = YES;
        _stopBtn.alpha = 0;

    }
    return _stopBtn;
}

- (UIButtonEx *)resumeBtn{
    if (_resumeBtn== nil) {
        _resumeBtn = [UIButtonEx buttonWithType:UIButtonTypeCustom];
        _resumeBtn.titleLabel.font = FONT(Btn_Height/2-2);
        _resumeBtn.layer.masksToBounds = YES;
        _resumeBtn.layer.cornerRadius = Btn_Height/2;
        [_resumeBtn setBackgroundColor:RGB(32, 204, 50) forState:UIControlStateNormal];
        [_resumeBtn setHighlightedCoverColor:RGBA(0,0,0,0.1)];
        [_resumeBtn setTitle:@"继续" forState:UIControlStateNormal];
        [_resumeBtn addTarget:self action:@selector(resumeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _resumeBtn.hidden = YES;
        _resumeBtn.alpha = 0;
    }
    return _resumeBtn;
}

- (UIButtonEx *)endBtn{
    if (_endBtn == nil) {
        _endBtn = [UIButtonEx buttonWithType:UIButtonTypeCustom];
        _endBtn.titleLabel.font = FONT(Btn_Height/2-2);
        _endBtn.layer.masksToBounds = YES;
        _endBtn.layer.cornerRadius = Btn_Height/2;
        _endBtn.layer.borderWidth = 1;
        [_endBtn setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_endBtn setHighlightedCoverColor:RGBA(255,255,255,0.1)];
        [_endBtn setTitle:@"放弃" forState:UIControlStateNormal];
        [_endBtn addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _endBtn.hidden = YES;
        _endBtn.alpha = 0;
    }
    return _endBtn;
}

- (UICollectionView *)coverCollectionView{
    if (_coverCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        _coverCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _coverCollectionView.backgroundColor = CLEARCOLOR;
        _coverCollectionView.showsVerticalScrollIndicator = NO;
        _coverCollectionView.showsHorizontalScrollIndicator = NO;
        _coverCollectionView.delegate = self;
        _coverCollectionView.dataSource = self;
        _coverCollectionView.pagingEnabled = YES;
        _coverCollectionView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, SCREEN_HEIGHT);
        [_coverCollectionView registerClass:[MainDefaultCollectionViewCell class] forCellWithReuseIdentifier:kMainDefaultCollectionViewCell];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        leftView.backgroundColor = RGBA(216, 216, 216,0.2);
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(5*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        rightView.backgroundColor = RGBA(255, 166, 0,0.2);
        [_coverCollectionView addSubview:leftView];
        [_coverCollectionView addSubview:rightView];
    }
    return _coverCollectionView;
}

- (UIScrollView *)bgScrollView{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH + 100, SCREEN_HEIGHT);
        _bgScrollView.delegate = self;
        
        self.tempBgView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, 555, SCREEN_HEIGHT)];
        self.tempBgView.image = IMG(@"6_default_background");
        self.tempBgView.contentMode = UIViewContentModeScaleToFill;
        [_bgScrollView addSubview:self.tempBgView];
    }
    return _bgScrollView;
}

- (UILabel *)aphorismLabel{
    if (_aphorismLabel == nil) {
        _aphorismLabel = [UILabel new];
        _aphorismLabel.font = CircleDefaultzFont(14);
        _aphorismLabel.alpha = 0.5;
        _aphorismLabel.text = @"路迢迢，十万百千里，披荆斩棘，一路将尘埃荡涤";
        _aphorismLabel.textColor = [UIColor whiteColor];
    }
    return _aphorismLabel;
}

- (UIButtonEx *)statisticBtn{
    if (_statisticBtn == nil) {
        _statisticBtn = [UIButtonEx buttonWithType:UIButtonTypeCustom];
        _statisticBtn.titleLabel.font = CircleDefaultzFont(14);
        _statisticBtn.titleLabel.textColor = [UIColor whiteColor];
        _statisticBtn.alpha = 0.5;
        [_statisticBtn setBackgroundImage:IMG(@"stats_button") forState:UIControlStateNormal];
        [_statisticBtn setTitle:@"00" forState:UIControlStateNormal];
    }
    return _statisticBtn;
}

- (MainDefaultCollectionViewCell *)indexCell{
    if (_indexCell == nil) {
        _indexCell = [[MainDefaultCollectionViewCell alloc] init];
    }
    return _indexCell;
}


- (void)setPlayerState:(BNPlayerState)playerState{
    _playerState = playerState;
    if (_playerState == BNPlayerStatePlaying){
        if (![[NSUserDefaults standardUserDefaults] objectForKey:kHaveSound]){
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kHaveSound];
        }else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:kHaveSound] isEqualToString:@"YES"]) {
                _playerState = BNPlayerStateSound;
                if (self.player && [self.player isPlaying]) {
                    [self.player stop];
                    self.player = [BNAudioPlayer initPlayerWithPage:self.indexCell.pageNum];
                    [self.player play];
                }
            }else{
                _playerState = BNPlayerStateNoSound;
                if (self.player && [self.player isPlaying]) {
                    [self.player stop];
                    self.player = [BNAudioPlayer initEmptyPlayer];
                    [self.player play];
                }
            }
        }
    }
    self.indexCell.playerState = _playerState;
}

- (void)setPlaySec:(int64_t)playSec{
    _playSec = playSec;
    [self.indexCell setCountDownLabelLefSec:_playSec];
}
@end
