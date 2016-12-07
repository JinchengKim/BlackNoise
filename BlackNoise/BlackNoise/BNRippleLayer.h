//
//  BNRippleLayer.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BNRippleLayer : CALayer
- (void)beginAnimation;
- (void)stopAnimation;
- (void)resumeAnimation;
- (void)endAnimation;
@end
