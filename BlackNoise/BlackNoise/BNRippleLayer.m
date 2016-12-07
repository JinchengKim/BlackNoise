


//
//  BNRippleLayer.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNRippleLayer.h"
#import "BNTimer.h"

#define cicleFrame_1 CGRectMake(25, 25, 200, 200)
#define cicleFrame_2 CGRectMake(15, 15, 220, 220)
#define cicleFrame_3 CGRectMake(5, 5, 240, 240)

typedef NS_ENUM(NSInteger,RipperState){
    RippleStatePlaying = 0,
    RippleStateEnd
};

@interface BNRippleLayer()<CAMediaTiming,CAAnimationDelegate>
@property (nonatomic, assign) RipperState state;

@property (nonatomic, strong) NSTimer *addRippleTimer;
@property (nonatomic, assign) NSTimeInterval stopTime;
@property (nonatomic, assign) NSTimeInterval aBeginTime;
@end

@implementation BNRippleLayer
- (instancetype)init{
    self = [super init];
    if (self) {
        self.state = RippleStateEnd;
    }
    return self;
}

    

- (void)beginAnimation{
    self.state = RippleStatePlaying;
    
    self.aBeginTime = CACurrentMediaTime();
    
    [self.addRippleTimer invalidate];
    WeakSelf
    self.addRippleTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer){
        [weakSelf addRipple];
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:self.addRippleTimer forMode:NSRunLoopCommonModes];
    [self.addRippleTimer fire];
}

- (void)stopAnimation{
    self.state = RippleStateEnd;
    [self endAnimation];

}

- (void)resumeAnimation{
    self.state = RippleStatePlaying;
    [self beginAnimation];
}

- (void)endAnimation{
    self.state = RippleStateEnd;
    [self.addRippleTimer invalidate];
    self.addRippleTimer = nil;
}


- (void)addRipple{
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CircleLength * 2, CircleLength * 2)];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake((ProgressLength- CircleLength), (ProgressLength- CircleLength), CircleLength * 2, CircleLength * 2);
;
    circleLayer.fillColor = CLEARCOLOR.CGColor;
    circleLayer.lineWidth = 1;
    circleLayer.strokeColor = RGBA(255, 255, 255, 0.3).CGColor;
    
    circleLayer.path = circlePath.CGPath;
    circleLayer.hidden = NO;

    CABasicAnimation *frameAnima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    frameAnima1.fromValue = @(1);
    frameAnima1.toValue = @(1.25);
    frameAnima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *opacityAnima1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima1.fromValue = @(0.5);
    opacityAnima1.toValue = @(0);
    opacityAnima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.duration = 3;
    group1.beginTime = CACurrentMediaTime();
    group1.animations = @[frameAnima1,opacityAnima1];
    group1.delegate = self;
    group1.removedOnCompletion = YES;
    
    [self addSublayer:circleLayer];
    [circleLayer addAnimation:group1 forKey:[NSString stringWithFormat:@"animation add At the time: %f",CACurrentMediaTime()]];
//    NSLog(@"add layer at %f",CACurrentMediaTime());
    [self removeRippleLayer:circleLayer];
}


- (void)removeRippleLayer:(CAShapeLayer*)layer{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer removeFromSuperlayer];
//        NSLog(@"ripple layer removeFromSuperlayer");
    });
}


@end
