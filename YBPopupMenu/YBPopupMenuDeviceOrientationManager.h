//
//  YBPopupMenuDeviceOrientationManager.h
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2020/1/19.
//  Copyright © 2020 LYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YBPopupMenuDeviceOrientationManager <NSObject>

/**
 根据屏幕旋转方向自动旋转 Default is YES
 */
@property (nonatomic, assign) BOOL autoRotateWhenDeviceOrientationChanged;

@property (nonatomic, copy) void (^deviceOrientDidChangeHandle) (UIInterfaceOrientation orientation);

+ (id <YBPopupMenuDeviceOrientationManager>)manager;

/**
 开始监听
 */
- (void)startMonitorDeviceOrientation;

/**
 结束监听
 */
- (void)endMonitorDeviceOrientation;

@end

@interface YBPopupMenuDeviceOrientationManager : NSObject <YBPopupMenuDeviceOrientationManager>

@end

NS_ASSUME_NONNULL_END
