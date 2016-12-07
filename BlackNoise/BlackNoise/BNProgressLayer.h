//
//  BNProgressLayer.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BNProgressLayer : CALayer
@property (nonatomic, assign) int64_t ti;

- (void)beginAnimation;
- (void)stopAnimation;
- (void)resumeAnimation;
- (void)endAnimation;
@end
