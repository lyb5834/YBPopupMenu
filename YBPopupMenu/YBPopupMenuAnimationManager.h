//
//  YBPopupMenuAnimationManager.h
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2020/1/19.
//  Copyright © 2020 LYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YBPopupMenuAnimationStyle) {
    YBPopupMenuAnimationStyleScale = 0,       //scale动画 Default
    YBPopupMenuAnimationStyleFade,            //alpha 0~1
    YBPopupMenuAnimationStyleNone,            //没有动画
    YBPopupMenuAnimationStyleCustom           //自定义
};

@protocol YBPopupMenuAnimationManager <NSObject>

/**
 动画类型，默认YBPopupMenuAnimationStyleScale
 */
@property (nonatomic, assign) YBPopupMenuAnimationStyle style;

/**
 显示动画，自定义可用
 */
@property (nonatomic, strong) CAAnimation * showAnimation;

/**
 隐藏动画，自定义可用
 */
@property (nonatomic, strong) CAAnimation * dismissAnimation;

/**
 弹出和隐藏动画的时间，Default is 0.25
 */
@property CFTimeInterval duration;

@property (nonatomic, weak) UIView * animationView;

+ (id <YBPopupMenuAnimationManager>)manager;

- (void)displayShowAnimationCompletion:(void (^) (void))completion;

- (void)displayDismissAnimationCompletion:(void (^) (void))completion;

@end

@interface YBPopupMenuAnimationManager : NSObject<YBPopupMenuAnimationManager>

@end

NS_ASSUME_NONNULL_END
