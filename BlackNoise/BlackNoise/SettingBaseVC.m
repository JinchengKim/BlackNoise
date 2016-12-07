//
//  SettingBaseVC.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "SettingBaseVC.h"
#import "SettingVCPopAnimator.h"
#import "SettingVCPushAnimator.h"

#import "UIButtonEx.h"


@interface SettingBaseVC ()
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@property (nonatomic, strong) SettingVCPushAnimator *pushAnimator;
@property (nonatomic, strong) SettingVCPopAnimator *popAnimator;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation SettingBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pushAnimator = [SettingVCPushAnimator new];
    self.popAnimator = [SettingVCPopAnimator new];
    [self addPopGesture];
    [self.navigationController.navigationBar setHidden:YES];
//    [self setNavBarType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)setNavBarType{
    self.navigationController.navigationBar.translucent = YES;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    UIColor *color = CLEARCOLOR;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(content, [color CGColor]);
    CGContextFillRect(content, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
- (void)addFakeNavBar{
    [self.view addSubview:self.bottomLine];
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 28));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.bottomLine.mas_top).offset(-8);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.bottom.equalTo(self.bottomLine.mas_top).offset(-8);
    }];
}

- (void)setNavTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)hideFakeNavBar{
    [self.bottomLine removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.backBtn removeFromSuperview];
}

#pragma mark - animation

- (void)addPopGesture{
    UIScreenEdgePanGestureRecognizer *popRegognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRegognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRegognizer];
}

-(void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer{
    //计算用户拖动距离
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged){
        [self.interactionController updateInteractiveTransition:progress];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            [self.interactionController finishInteractiveTransition];
        }else{
            [self.interactionController cancelInteractiveTransition];
        }
        
        self.interactionController = nil;
    }
}



#pragma mark -delegate


-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactionController;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush)
        return  [SettingVCPushAnimator new];
    
    if (operation == UINavigationControllerOperationPop)
        return  [SettingVCPopAnimator new];
    
    
    return nil;
}

- (void)popThisVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter and Setter
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = FONT(18);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButtonEx new];
        _backBtn.frame = CellButtonFrame28;
        [_backBtn setBackgroundImage:IMG(@"menu_back_icon") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(popThisVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH- 5, 0.5)];
        self.bottomLine.alpha = 0.5;
        self.bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}

@end
