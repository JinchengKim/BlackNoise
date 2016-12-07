//
//  MinPickerView.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^hideTheView) (BOOL hidden);

@interface MinPickerView : UIPickerView
@property (nonatomic, copy) hideTheView hideBlock;

- (void)addTimer;
- (void)stopTimer;
@end
