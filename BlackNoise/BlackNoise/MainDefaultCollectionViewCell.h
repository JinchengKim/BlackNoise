//
//  MainDefaultCollectionViewCell.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/16.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BNPlayerState){
    BNPlayerStateStandby = 0, // before playing
    BNPlayerStateEnd, // close the player
    BNPlayerStateStop, // pause playing
    
    
    BNPlayerStatePlaying , // is playing
//    BNPlayerStateStopToPlay, // pause playing
    BNPlayerStateSound, // has sound while playing
    BNPlayerStateNoSound // no sound while playing (play the slience sound file)
};

typedef void (^ChangeSoundState) ();
@interface MainDefaultCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval ti;
@property (nonatomic, assign) int32_t sec;

@property (nonatomic, assign) int8_t pageNum;
@property (nonatomic, assign) BNPlayerState playerState;
@property (nonatomic, copy) ChangeSoundState changeSoundState;
- (void)beginPlayingAnimation;
- (void)pausePlayingAnimation;
- (void)resumePlayingAnimation;
- (void)endPlayingAnimation;

- (void)showPickerView;
- (void)hideTitleLabelAndShowTimer;

- (void)setCountDownLabelLefSec:(int64_t)sec;
@end
