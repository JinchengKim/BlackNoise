//
//  BNAudioPlayer.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/28.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface BNAudioPlayer : AVAudioPlayer
+ (instancetype) initMusePlayer;

+ (instancetype) initCafePlayer;

+ (instancetype) initEmptyPlayer;

+ (instancetype) initOceanPlayer;

+ (instancetype) initForestPlayer;

+ (instancetype) initRainPlayer;

+ (instancetype) initPlayerWithName:(NSString *)name;

+ (instancetype) initPlayerWithPage:(int8_t)page;
@end
