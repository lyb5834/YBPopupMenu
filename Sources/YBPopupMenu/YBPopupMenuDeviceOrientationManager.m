//
//  YBPopupMenuDeviceOrientationManager.m
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2020/1/19.
//  Copyright © 2020 LYB. All rights reserved.
//

#import "YBPopupMenuDeviceOrientationManager.h"

@implementation YBPopupMenuDeviceOrientationManager
@synthesize autoRotateWhenDeviceOrientationChanged = _autoRotateWhenDeviceOrientationChanged;
@synthesize deviceOrientDidChangeHandle = _deviceOrientDidChangeHandle;

+ (id<YBPopupMenuDeviceOrientationManager>)manager
{
    YBPopupMenuDeviceOrientationManager * manager = [[YBPopupMenuDeviceOrientationManager alloc] init];
    manager.autoRotateWhenDeviceOrientationChanged = YES;
    return manager;
}

- (void)startMonitorDeviceOrientation
{
    if (!self.autoRotateWhenDeviceOrientationChanged) return;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationDidChangedNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)endMonitorDeviceOrientation
{
    if (!self.autoRotateWhenDeviceOrientationChanged) return;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark - notify
- (void)onDeviceOrientationDidChangedNotification:(NSNotification *)notify
{
    if (!self.autoRotateWhenDeviceOrientationChanged) return;
    UIInterfaceOrientation orientation = [notify.userInfo[UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    if (_deviceOrientDidChangeHandle) {
        _deviceOrientDidChangeHandle(orientation);
    }
}

@end
