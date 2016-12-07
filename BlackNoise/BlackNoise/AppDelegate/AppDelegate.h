//
//  AppDelegate.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/12.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

