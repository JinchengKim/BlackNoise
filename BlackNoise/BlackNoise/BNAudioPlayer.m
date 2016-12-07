//
//  BNAudioPlayer.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/28.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "BNAudioPlayer.h"

@implementation BNAudioPlayer

+ (instancetype) initMusePlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Muse" musicType:@"m4a"];
}

+ (instancetype) initCafePlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Cafe" musicType:@"m4a"];
}

+ (instancetype) initEmptyPlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Empty" musicType:@"m4a"];
}

+ (instancetype) initOceanPlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Ocean" musicType:@"m4a"];
}

+ (instancetype) initForestPlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Forest" musicType:@"m4a"];
}

+ (instancetype) initRainPlayer{
    return [BNAudioPlayer initPlayerWithSong:@"Rain" musicType:@"m4a"];
}

+ (instancetype) initPlayerWithName:(NSString *)name{
    return [BNAudioPlayer initPlayerWithSong:name musicType:@"m4a"];
}

+ (instancetype)initPlayerWithPage:(int8_t)page{
    if (page == 0) {
        return [BNAudioPlayer initOceanPlayer];
    }else if(page == 1){
        return [BNAudioPlayer initRainPlayer];
    }else if(page == 2){
        return [BNAudioPlayer initForestPlayer];
    }else if(page == 3){
        return [BNAudioPlayer initMusePlayer];
    }else if(page == 4){
        return [BNAudioPlayer initCafePlayer];
    }
    
    return [BNAudioPlayer initEmptyPlayer];
}

+ (instancetype) initPlayerWithSong:(NSString*)name musicType:(NSString*)type{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    BNAudioPlayer *player;
    if ([[NSFileManager defaultManager] fileExistsAtPath:musicFilePath]) {
        NSData *song = [[NSData alloc] initWithContentsOfFile:musicFilePath];
        player = [[BNAudioPlayer alloc] initWithData:song error:nil];
        player.volume = 100/100;
        player.numberOfLoops = 100;
        [player prepareToPlay];
    }
    return player;
}

@end
