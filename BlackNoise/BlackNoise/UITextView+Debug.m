//
//  UITextView+Debug.m
//  joyRunner
//
//  Created by Blade on 16/6/2.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "UITextView+Debug.h"

@implementation UITextView (Debug)

#pragma mark - UI Debuging

/**
 *  Code below is for UI debuging, when we have "Assertion failure in -[UITextView _firstBaselineOffsetFromTop], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3512.60.7/UITextView.m:1683" in console when debuging view hierarchy.
 *  NOTICE: Do not use if we DO NOT need debuging of view hierarchy, even in debug mode.
 *
 *  References:
 *  https://openradar.appspot.com/25311044
 *  http://stackoverflow.com/questions/37068231/assertion-failure-in-uitextview-firstbaselineoffsetfromtop
 */
#if DEBUG // In case someone turn the 'UITEXTVIEW_DEBUG' marco to be 'true', then the release version would contain the debug code
    #ifndef UITEXTVIEW_DEBUG
        #define UITEXTVIEW_DEBUG false      // set marco to 'true' to debug UITextView UI
    #endif
#endif

#if defined(UITEXTVIEW_DEBUG) && UITEXTVIEW_DEBUG == true
- (void)_firstBaselineOffsetFromTop {
    
}

- (void)_baselineOffsetFromBottom {
    
}
#endif
/**
 *  Code Above is for UI debuging, when we have "Assertion failure in -[UITextView _firstBaselineOffsetFromTop], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3512.60.7/UITextView.m:1683" in console when debuging view hierarchy.
 *  NOTICE: Do not use if we DO NOT need debuging of view hierarchy, even in debug mode.
 *
 *  References:
 *  https://openradar.appspot.com/25311044
 *  http://stackoverflow.com/questions/37068231/assertion-failure-in-uitextview-firstbaselineoffsetfromtop
 */

@end
