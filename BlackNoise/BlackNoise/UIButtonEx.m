//
//  UIButtonEx.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/14.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "UIButtonEx.h"

@interface UIButtonEx()

@property(nonatomic, weak) UIView *coverView;
@property(nonatomic, assign, getter=isShowCoverView) BOOL showCoverView;

@end

@implementation UIButtonEx

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _backgroundColors = [[NSMutableDictionary alloc] init];
    _borderColors = [[NSMutableDictionary alloc] init];
    
    [self setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self setBorderColor:[UIColor clearColor] forState:UIControlStateNormal];
    self.backgroundColor = [self backgroundColorForState:self.state];
    self.layer.borderColor = [self borderColorForState:self.state].CGColor;
    
    self.touchVerticalExtension = 7;
    self.touchHorizontalExtension = 3;
    
    UIView *coverView = [[UIView alloc] init];
    coverView.hidden = YES;
    [self addSubview:coverView];
    self.coverView = coverView;
    self.showCoverView = NO;
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            [_backgroundColors setValue:backgroundColor forKey:@"UIControlStateNormal"];
            break;
        }
        case UIControlStateHighlighted:
        {
            [_backgroundColors setValue:backgroundColor forKey:@"UIControlStateHighlighted"];
            break;
        }
        case UIControlStateSelected:
        {
            [_backgroundColors setValue:backgroundColor forKey:@"UIControlStateSelected"];
            break;
        }
        case UIControlStateDisabled:
        {
            [_backgroundColors setValue:backgroundColor forKey:@"UIControlStateDisabled"];
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (state == self.state)
    {
        self.backgroundColor = backgroundColor;
    }
}

- (UIColor*)backgroundColorForState:(UIControlState)state
{
    UIColor* result = nil;
    switch (state)
    {
        case UIControlStateNormal:
        {
            result = [_backgroundColors valueForKey:@"UIControlStateNormal"];
            break;
        }
        case UIControlStateHighlighted:
        {
            result = [_backgroundColors valueForKey:@"UIControlStateHighlighted"];
            break;
        }
        case UIControlStateSelected:
        {
            result = [_backgroundColors valueForKey:@"UIControlStateSelected"];
            break;
        }
        case UIControlStateDisabled:
        {
            result = [_backgroundColors valueForKey:@"UIControlStateDisabled"];
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (!result)
    {
        result = [_backgroundColors valueForKey:@"UIControlStateNormal"];
    }
    
    return result;
}

- (void)setBorderColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            [_borderColors setValue:backgroundColor forKey:@"UIControlStateNormal"];
            break;
        }
        case UIControlStateHighlighted:
        {
            [_borderColors setValue:backgroundColor forKey:@"UIControlStateHighlighted"];
            break;
        }
        case UIControlStateSelected:
        {
            [_borderColors setValue:backgroundColor forKey:@"UIControlStateSelected"];
            break;
        }
        case UIControlStateDisabled:
        {
            [_borderColors setValue:backgroundColor forKey:@"UIControlStateDisabled"];
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (state == self.state)
    {
        self.layer.borderColor = backgroundColor.CGColor;
    }
}

- (UIColor*)borderColorForState:(UIControlState)state
{
    UIColor* result = nil;
    switch (state)
    {
        case UIControlStateNormal:
        {
            result = [_borderColors valueForKey:@"UIControlStateNormal"];
            break;
        }
        case UIControlStateHighlighted:
        {
            result = [_borderColors valueForKey:@"UIControlStateHighlighted"];
            break;
        }
        case UIControlStateSelected:
        {
            result = [_borderColors valueForKey:@"UIControlStateSelected"];
            break;
        }
        case UIControlStateDisabled:
        {
            result = [_borderColors valueForKey:@"UIControlStateDisabled"];
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (!result)
    {
        result = [_borderColors valueForKey:@"UIControlStateNormal"];
    }
    
    return result;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.backgroundColor = [self backgroundColorForState:self.state];
    self.layer.borderColor = [self borderColorForState:self.state].CGColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.layer.borderColor = [self borderColorForState:self.state].CGColor;
    
    if (self.isShowCoverView) {
        self.coverView.hidden = self.state != UIControlStateHighlighted;
    } else {
        self.backgroundColor = [self backgroundColorForState:self.state];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.backgroundColor = [self backgroundColorForState:self.state];
    self.layer.borderColor = [self borderColorForState:self.state].CGColor;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden)
    {
        return nil;
    }
    
    CGRect extendedFrame = CGRectInset(self.bounds, -self.touchHorizontalExtension, -self.touchVerticalExtension);
    return CGRectContainsPoint(extendedFrame , point) ? self : nil;
}

- (void)setHighlightedCoverColorBlack {
    [self setHighlightedCoverColor:RGBA(0, 0, 0, 0.3)];
}

- (void)setHighlightedCoverColor:(UIColor *)coverColor {
    self.coverView.backgroundColor = coverColor;
    self.showCoverView = YES;
}

- (void)layoutSubviews {
    if (self.coverView) {
        [self bringSubviewToFront:self.coverView];
        self.coverView.frame = self.bounds;
    }
    
    [super layoutSubviews];
}

#pragma mark - load animation
- (void)buttonBeginAnimation{
    
    
}

- (void)buttonEndAnimation{
    
}
@end
