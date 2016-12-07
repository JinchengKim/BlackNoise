//
//  BNProgressLayer.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNProgressLayer.h"

@interface BNProgressLayer()
@property (nonatomic, strong) UIBezierPath *bottomPath;
@property (nonatomic, strong) UIBezierPath *upPath;
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
@property (nonatomic, strong) CAShapeLayer *upLayer;

@property (nonatomic, assign) CGFloat progressStrokeEnd;
@end

@implementation BNProgressLayer

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSublayer:self.bottomLayer];
        [self addSublayer:self.upLayer];
    }
    return self;
}

#pragma mark - Animation
- (void)beginAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anima.toValue = @(1);
    anima.duration = self.ti;
    [self.upLayer addAnimation:anima forKey:@"upLayer-Animation"];
}

- (void)stopAnimation{
    self.progressStrokeEnd = self.upLayer.strokeEnd;
    self.upLayer.strokeEnd = self.progressStrokeEnd;
    [self.upLayer removeAllAnimations];
}
- (void)resumeAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anima.toValue = @(1);
    anima.duration = self.ti;
    [self.upLayer addAnimation:anima forKey:@"upLayer-Animation"];
}

- (void)endAnimation{
    
}

#pragma mark - Getter and Setter

- (UIBezierPath *)bottomPath{
    if (_bottomPath == nil) {
        _bottomPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CircleLength * 2, CircleLength * 2)];
    }
    return _bottomPath;
}

- (CAShapeLayer *)bottomLayer{
    if (_bottomLayer == nil) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.frame = RippleFrame;
        _bottomLayer.fillColor = CLEARCOLOR.CGColor;
        _bottomLayer.lineWidth = 4;
        _bottomLayer.strokeColor = RGBA(255, 255, 255, 0.3).CGColor;
        _bottomLayer.path = self.bottomPath.CGPath;
        
    }
    return _bottomLayer;
}

- (UIBezierPath *)upPath{
    if (_upPath == nil) {
        _upPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CircleLength * 2, CircleLength * 2)];
    }
    return _upPath;
}

- (CAShapeLayer *)upLayer{
    if (_upLayer == nil) {
        _upLayer = [CAShapeLayer layer];
        _upLayer.frame = RippleFrame;
        _upLayer.fillColor = CLEARCOLOR.CGColor;
        _upLayer.lineWidth = 3;
        _upLayer.strokeColor = RGBA(255, 255, 255, 1).CGColor;
        _upLayer.strokeStart = 0;
        _upLayer.strokeEnd = 0;
        _upLayer.lineCap = kCALineCapRound;
        _upLayer.transform = CATransform3DMakeRotation(90 * M_PI/180,0,0,-1);
        
        _upLayer.path = self.upPath.CGPath;
    }
    return _upLayer;
}
@end
