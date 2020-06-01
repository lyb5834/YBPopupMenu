//
//  YBPopupMenu.h
//  YBPopupMenu
//
//  Created by lyb on 2017/5/10.
//  Copyright © 2017年 lyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPopupMenuPath.h"
#import "YBPopupMenuDeviceOrientationManager.h"
#import "YBPopupMenuAnimationManager.h"

// 过期提醒
#define YBDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

typedef NS_ENUM(NSInteger , YBPopupMenuType) {
    YBPopupMenuTypeDefault = 0,
    YBPopupMenuTypeDark
};

/**
 箭头方向优先级

 当控件超出屏幕时会自动调整成反方向
 */
typedef NS_ENUM(NSInteger , YBPopupMenuPriorityDirection) {
    YBPopupMenuPriorityDirectionTop = 0,  //Default
    YBPopupMenuPriorityDirectionBottom,
    YBPopupMenuPriorityDirectionLeft,
    YBPopupMenuPriorityDirectionRight,
    YBPopupMenuPriorityDirectionNone      //不自动调整
};

@class YBPopupMenu;
@protocol YBPopupMenuDelegate <NSObject>

@optional

- (void)ybPopupMenuBeganDismiss:(YBPopupMenu *)ybPopupMenu;
- (void)ybPopupMenuDidDismiss:(YBPopupMenu *)ybPopupMenu;
- (void)ybPopupMenuBeganShow:(YBPopupMenu *)ybPopupMenu;
- (void)ybPopupMenuDidShow:(YBPopupMenu *)ybPopupMenu;

/**
 点击事件回调
 */
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index;

/**
 自定义cell
 
 可以自定义cell，设置后会忽略 fontSize textColor backColor type 属性
 cell 的高度是根据 itemHeight 的，直接设置无效
 建议cell 背景色设置为透明色，不然切的圆角显示不出来
 */
- (UITableViewCell *)ybPopupMenu:(YBPopupMenu *)ybPopupMenu cellForRowAtIndex:(NSInteger)index;

@end

@interface YBPopupMenu : UIView

/**
 标题数组 只读属性
 */
@property (nonatomic, strong, readonly) NSArray  * titles;

/**
 图片数组 只读属性
 */
@property (nonatomic, strong, readonly) NSArray  * images;

/**
 tableView  Default separatorStyle is UITableViewCellSeparatorStyleNone
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 圆角半径 Default is 5.0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 自定义圆角 Default is UIRectCornerAllCorners
 
 当自动调整方向时corner会自动转换至镜像方向
 */
@property (nonatomic, assign) UIRectCorner rectCorner;

/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;

/**
 选择菜单项后消失 Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnSelected;

/**
 点击菜单外消失  Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTouchOutside;

/**
 设置字体大小 自定义cell时忽略 Default is 15
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 设置字体 设置时忽略fontSize Default is nil
 */
@property (nonatomic, strong) UIFont * font;

/**
 设置字体颜色 自定义cell时忽略 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor * textColor;

/**
 设置偏移距离 (>= 0) Default is 0.0
 */
@property (nonatomic, assign) CGFloat offset;

/**
 边框宽度 Default is 0.0
 
 设置边框需 > 0
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 边框颜色 Default is LightGrayColor
 
 borderWidth <= 0 无效
 */
@property (nonatomic, strong) UIColor * borderColor;

/**
 箭头宽度 Default is 15
 */
@property (nonatomic, assign) CGFloat arrowWidth;

/**
 箭头高度 Default is 10
 */
@property (nonatomic, assign) CGFloat arrowHeight;

/**
 箭头位置 Default is center
 
 只有箭头优先级是YBPopupMenuPriorityDirectionLeft/YBPopupMenuPriorityDirectionRight/YBPopupMenuPriorityDirectionNone时需要设置
 */
@property (nonatomic, assign) CGFloat arrowPosition;

/**
 箭头方向 Default is YBPopupMenuArrowDirectionTop
 */
@property (nonatomic, assign) YBPopupMenuArrowDirection arrowDirection;

/**
 箭头优先方向 Default is YBPopupMenuPriorityDirectionTop
 
 当控件超出屏幕时会自动调整箭头位置
 */
@property (nonatomic, assign) YBPopupMenuPriorityDirection priorityDirection;

/**
 可见的最大行数 Default is 5;
 */
@property (nonatomic, assign) NSInteger maxVisibleCount;

/**
 menu背景色 自定义cell时忽略 Default is WhiteColor
 */
@property (nonatomic, strong) UIColor * backColor;

/**
 item的高度 Default is 44;
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 popupMenu距离最近的Screen的距离 Default is 10
 */
@property (nonatomic, assign) CGFloat minSpace;

/**
 设置显示模式 自定义cell时忽略 Default is YBPopupMenuTypeDefault
 */
@property (nonatomic, assign) YBPopupMenuType type;

/**
 屏幕旋转管理
 */
@property (nonatomic, strong) id <YBPopupMenuDeviceOrientationManager> orientationManager;

/**
 动画管理
 */
@property (nonatomic, strong) id <YBPopupMenuAnimationManager> animationManager;

/**
 代理
 */
@property (nonatomic, weak) id <YBPopupMenuDelegate> delegate;

/**
 在指定位置弹出
 
 @param point          弹出的位置
 @param titles         标题数组  数组里是NSString/NSAttributedString
 @param icons          图标数组  数组里是NSString/UIImage
 @param itemWidth      菜单宽度
 @param otherSetting   其他设置
 */
+ (YBPopupMenu *)showAtPoint:(CGPoint)point
                      titles:(NSArray *)titles
                       icons:(NSArray *)icons
                   menuWidth:(CGFloat)itemWidth
               otherSettings:(void (^) (YBPopupMenu * popupMenu))otherSetting;

/**
 依赖指定view弹出

 @param titles         标题数组  数组里是NSString/NSAttributedString
 @param icons          图标数组  数组里是NSString/UIImage
 @param itemWidth      菜单宽度
 @param otherSetting   其他设置
 */
+ (YBPopupMenu *)showRelyOnView:(UIView *)view
                         titles:(NSArray *)titles
                          icons:(NSArray *)icons
                      menuWidth:(CGFloat)itemWidth
                  otherSettings:(void (^) (YBPopupMenu * popupMenu))otherSetting;

/**
 消失
 */
- (void)dismiss;

@end
