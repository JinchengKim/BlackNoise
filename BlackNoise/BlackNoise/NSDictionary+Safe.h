//
//  NSDictionary+Safe.h
//  Ekeo2
//
//  Created by Roger on 13-8-19.
//  Copyright (c) 2013年 Ekeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)
- (BOOL)hasObjectForKey:(NSString*)key;
- (id)safeObjectForKey:(NSString*)key;

- (NSString*)safeStringForKey:(NSString*)key;
- (NSNumber*)safeNumberForKey:(NSString*)key;

- (int)safeIntForKey:(NSString*)key;
- (long long)safeLongLongForKey:(NSString*)key;
- (float)safeFloatForKey:(NSString*)key;
- (double)safeDoubleForKey:(NSString*)key;
- (NSArray *)safeArrayForKey:(NSString *)key;

@end
