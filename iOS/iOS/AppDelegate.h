//
//  AppDelegate.h
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Bugly/Bugly.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

