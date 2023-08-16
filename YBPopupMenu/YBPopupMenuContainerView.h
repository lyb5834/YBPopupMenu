//
//  YBPopupMenuContainerView.h
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2023/8/16.
//  Copyright © 2023 LYB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPopupMenuPath.h"

@interface YBPopupMenuContainerView : UIView

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) UIRectCorner rectCorner;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIColor * borderColor;

@property (nonatomic, assign) CGFloat arrowWidth;

@property (nonatomic, assign) CGFloat arrowHeight;

@property (nonatomic, assign) CGFloat arrowPosition;

@property (nonatomic, assign) YBPopupMenuArrowDirection arrowDirection;

@property (nonatomic, assign) YBPopupMenuArrowStyle arrowStyle;

@property (nonatomic, strong) UIColor * backColor;

@end

