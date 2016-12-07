//
//  BNDefine.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/12.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#ifndef BNDefine_h
#define BNDefine_h

// self
#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

// about UI
#define ISIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ISIOS7							[[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define ISIOS8							[[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define ISIOS9							[[UIDevice currentDevice].systemVersion floatValue] >= 9.0
#define ISIOS10							[[UIDevice currentDevice].systemVersion floatValue] >= 10.0

#define ScreenBounds                    [UIScreen mainScreen].bounds
#define SCREEN_WIDTH					CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT					CGRectGetHeight([[UIScreen mainScreen] bounds])


#define ISIphone6plus                   ((SCREEN_WIDTH > 400) && !ISIPad)
#define ISIphone6                       ((SCREEN_WIDTH > 320) && !ISIPad)
#define ISIphone5                       ((SCREEN_HEIGHT > 480) && !ISIPad)
#define ISIphone4s                      ((SCREEN_WIDTH == 320) && (SCREEN_HEIGHT == 480))

#define SizeOfIphone6P65(X,Y,Z)         (ISIphone6plus ? X : ISIphone6 ? Y : Z)
#define SizeOfIphone6P654(W,X,Y,Z)      (ISIphone6plus ? W : ISIphone6 ? X : ISIphone5 ? Y : Z)
#define RatioOfIphone56plus             (ISIphone6plus ? 414 / 320.0f : ISIphone6 ? 375 / 320.0f : 1)
#define ScreenWidthRatioBase320         (SCREEN_WIDTH / 320.0f)
#define ScreenWidthRatioBase375         (SCREEN_WIDTH / 375.0f)
#define ScreenHeightRatioBase667        (SCREEN_HEIGHT / 667.0f)

#define CellButtonFrame28                 CGRectMake(0,0,28,28)
#define CellButtonFrame26                 CGRectMake(0,0,26,26)

//#define DefaultFontOfSize(s)            [[FontHelper sharedInstace] defaultFontOfSize:s]
#define DefaultFontOfSize(SIZE)         [UIFont systemFontOfSize:SIZE]
#define FONT(SIZE)                      [UIFont systemFontOfSize:SIZE]
#define BFONT(SIZE)                     [UIFont boldSystemFontOfSize:SIZE]
#define HiraginoFONT(SIZE)              DefaultFontOfSize(SIZE)
#define BHiraginoFONT(SIZE)             [UIFont fontWithName:@"HiraKakuProN-W6" size:SIZE]
#define HelveticaFONT(SIZE)             [UIFont fontWithName:@"HelveticaNeue" size:SIZE]
#define BHelveticaFONT(SIZE)            [UIFont fontWithName:@"HelveticaNeue-Bold" size:SIZE]
#define LightFONT(SIZE)                 FONT(SIZE)
#define MediumFONT(SIZE)                BFONT(SIZE)
#define RegularFONT(SIZE)               FONT(SIZE)
#define BebasNeueFONT(SIZE)             [UIFont fontWithName:@"BebasNeue" size:SIZE]
#define DINCondRegular(SIZE)            [UIFont fontWithName:@"DINCond-Regular" size:SIZE]
#define BRecordNumberFONT(SIZE)         [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:SIZE]

#define COLOR(x)                        [UIColor x]
#define CLEARCOLOR                      [UIColor clearColor]
#define RGB(R,G,B)						[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBA(R,G,B,A)					[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define IMG2COLOR(IMAGE)                [UIColor colorWithPatternImage:[UIImage imageNamed:IMAGE]]
#define IMG(X)							[UIImage imageNamed:X]
#define RandomColor                     RGB(arc4random()%255,arc4random()%255,arc4random()%255)

#define PUSHVIEW(VIEW)					[[self navigationController] pushViewController:VIEW animated:YES]
#define PUSHVIEWBY(SELF, VIEW)            [[SELF navigationController] pushViewController:VIEW animated:YES]
#define PUSHVIEWFROM(FROMVIEW,VIEW)   [(UINavigationController*)FROMVIEW pushViewController:VIEW animated:YES]
#define POPVIEW							[[self navigationController] popViewControllerAnimated:YES]

#define RESETVIEW(VIEW)					[[self navigationController] setViewControllers:[NSArray arrayWithObject:VIEW] animated:YES];

#define NAVPUSHVIEW(SELF,VIEW)          [[SELF navigationController] pushViewController:VIEW animated:YES]
#define NAVPOPVIEW(SELF)				[[SELF navigationController] popViewControllerAnimated:YES]

#define UPVIEW(VIEW)					[self presentViewController:VIEW animated:YES completion:nil];
#define ALPHAUPVIEW(vc)               {self.definesPresentationContext = YES;\
                                            vc.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];\
                                            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;\
                                            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];\
                                            UPVIEW(vc);}

#define NAVUPVIEW(SELF,VIEW)			[SELF presentViewController:VIEW animated:YES completion:nil];

// Locaziable
#define LSTR(STRING, LOC)                    CustomLocalizedString((STRING), @"", LOC)
#define CustomLocalizedString(key, comment, LOC) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:LOC ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]


#define CircleMarginTop 90 * ScreenWidthRatioBase375
#define CircleLength 110 * ScreenWidthRatioBase375
#define ProgressLength 130 * ScreenWidthRatioBase375
#define RippleFrame CGRectMake(self.frame.origin.x + ProgressLength - CircleLength, self.frame.origin.y + ProgressLength - CircleLength, CircleLength * 2, CircleLength * 2)
#define RippleFrameAdd(mm) CGRectMake(self.frame.origin.x + ProgressLength - CircleLength - mm/2, self.frame.origin.y + ProgressLength - CircleLength - mm/2, CircleLength * 2 + mm, CircleLength * 2 + mm)
#define CircleDefaultzFont(SIZE) [UIFont fontWithName:@"MFKeSong_Noncommercial-Regular" size:SIZE * ScreenWidthRatioBase375];







#define kHaveSound @"kHaveSound"
#endif /* BNDefine_h */
