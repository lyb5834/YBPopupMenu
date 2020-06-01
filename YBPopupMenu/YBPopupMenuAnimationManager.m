//
//  YBPopupMenuAnimationManager.m
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2020/1/19.
//  Copyright © 2020 LYB. All rights reserved.
//

#import "YBPopupMenuAnimationManager.h"

static NSString * const YBShowAnimationKey = @"showAnimation";
static NSString * const YBDismissAnimationKey = @"dismissAnimation";
@interface YBPopupMenuAnimationManager ()
<
CAAnimationDelegate
>
@property (nonatomic, copy) void (^showAnimationHandle) (void);

@property (nonatomic, copy) void (^dismissAnimationHandle) (void);

@end

@implementation YBPopupMenuAnimationManager
@synthesize style = _style;
@synthesize showAnimation = _showAnimation;
@synthesize dismissAnimation = _dismissAnimation;
@synthesize duration = _duration;
@synthesize animationView = _animationView;

+ (id<YBPopupMenuAnimationManager>)manager
{
    YBPopupMenuAnimationManager * manager = [[YBPopupMenuAnimationManager alloc] init];
    manager.style = YBPopupMenuAnimationStyleScale;
    manager.duration = 0.25;
    return manager;
}

- (void)configAnimation
{
    CABasicAnimation * showAnimation;
    CABasicAnimation * dismissAnimation;
    switch (_style) {
        case YBPopupMenuAnimationStyleFade:
        {
            _showAnimation = _dismissAnimation = nil;
            //show
            showAnimation = [self getBasicAnimationWithKeyPath:@"opacity"];
            showAnimation.fillMode = kCAFillModeBackwards;
            showAnimation.fromValue = @(0);
            showAnimation.toValue = @(1);
            _showAnimation = showAnimation;
            //dismiss
            dismissAnimation = [self getBasicAnimationWithKeyPath:@"opacity"];
            dismissAnimation.fillMode = kCAFillModeForwards;
            dismissAnimation.fromValue = @(1);
            dismissAnimation.toValue = @(0);
            _dismissAnimation = dismissAnimation;
        }
            break;
        case YBPopupMenuAnimationStyleCustom:
            break;
        case YBPopupMenuAnimationStyleNone:
        {
            _showAnimation = _dismissAnimation = nil;
        }
            break;
        default:
        {
            _showAnimation = _dismissAnimation = nil;
            //show
            showAnimation = [self getBasicAnimationWithKeyPath:@"transform.scale"];
            showAnimation.fillMode = kCAFillModeBackwards;
            showAnimation.fromValue = @(0.1);
            showAnimation.toValue = @(1);
            _showAnimation = showAnimation;
            //dismiss
            dismissAnimation = [self getBasicAnimationWithKeyPath:@"transform.scale"];
            dismissAnimation.fillMode = kCAFillModeForwards;
            dismissAnimation.fromValue = @(1);
            dismissAnimation.toValue = @(0.1);
            _dismissAnimation = dismissAnimation;
        }
            break;
    }
}

- (void)setStyle:(YBPopupMenuAnimationStyle)style
{
    _style = style;
    [self configAnimation];
}

- (void)setDuration:(CFTimeInterval)duration
{
    _duration = duration;
    [self configAnimation];
}

- (void)setShowAnimation:(CAAnimation *)showAnimation
{
    _showAnimation = showAnimation;
    [self configAnimation];
}

- (void)setDismissAnimation:(CAAnimation *)dismissAnimation
{
    _dismissAnimation = dismissAnimation;
    [self configAnimation];
}

- (CABasicAnimation *)getBasicAnimationWithKeyPath:(NSString *)keyPath
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.removedOnCompletion = NO;
    animation.duration = _duration;
    return animation;
}

- (void)displayShowAnimationCompletion:(void (^)(void))completion
{
    _showAnimationHandle = completion;
    if (!_showAnimation) {
        if (_showAnimationHandle) {
            _showAnimationHandle();
        }
        return;
    }
    _showAnimation.delegate = self;
    [_animationView.layer addAnimation:_showAnimation forKey:YBShowAnimationKey];
}

- (void)displayDismissAnimationCompletion:(void (^)(void))completion
{
    _dismissAnimationHandle = completion;
    if (!_dismissAnimation) {
        if (_dismissAnimationHandle) {
            _dismissAnimationHandle();
        }
        return;
    }
    _dismissAnimation.delegate = self;
    [_animationView.layer addAnimation:_dismissAnimation forKey:YBDismissAnimationKey];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([_animationView.layer animationForKey:YBShowAnimationKey] == anim) {
        [_animationView.layer removeAnimationForKey:YBShowAnimationKey];
        _showAnimation.delegate = nil;
        _showAnimation = nil;
        if (_showAnimationHandle) {
            _showAnimationHandle();
        }
    }else if ([_animationView.layer animationForKey:YBDismissAnimationKey] == anim) {
        [_animationView.layer removeAnimationForKey:YBDismissAnimationKey];
        _dismissAnimation.delegate = nil;
        _dismissAnimation = nil;
        if (_dismissAnimationHandle) {
            _dismissAnimationHandle();
        }
    }
}

@end
