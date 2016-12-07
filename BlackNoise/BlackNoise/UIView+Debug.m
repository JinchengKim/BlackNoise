//
//  UIView+Debug.m
//  joyRunner
//
//  Created by Blade on 16/8/17.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "UIView+Debug.h"

@implementation UIView (Debug)

#pragma mark - UI Debuging

/**
 *  Code below is for UI debuging, when we have "-[UIWindow viewForFirstBaselineLayout]: unrecognized selector sent to instance 0xXXXXXXX" in console when debuging view hierarchy.
 *  NOTICE: Do not use if we DO NOT need debuging of view hierarchy, even in debug mode.
 *  See: http://stackoverflow.com/questions/36313850/debug-view-hierarchy-in-xcode-7-3-fails/36926620
 */

#ifdef DEBUG // In case someone turn the 'UIVIEW_DEBUG' marco to be 'true', then the release version would contain the debug code
    #ifndef UIVIEW_DEBUG
        #define UIVIEW_DEBUG false
    #endif
#endif

#if defined(UIVIEW_DEBUG) && UIVIEW_DEBUG == true
+ (void)load
{
    Method original = class_getInstanceMethod(self, @selector(viewForBaselineLayout));
    class_addMethod(self, @selector(viewForFirstBaselineLayout), method_getImplementation(original), method_getTypeEncoding(original));
    class_addMethod(self, @selector(viewForLastBaselineLayout), method_getImplementation(original), method_getTypeEncoding(original));
}
#endif

/**
 *  Code above is for UI debuging, when we have "-[UIWindow viewForFirstBaselineLayout]: unrecognized selector sent to instance 0xXXXXXXX" in console when debuging view hierarchy.
 *  NOTICE: Do not use if we DO NOT need debuging of view hierarchy, even in debug mode.
 *  See: http://stackoverflow.com/questions/36313850/debug-view-hierarchy-in-xcode-7-3-fails/36926620
 */

@end
