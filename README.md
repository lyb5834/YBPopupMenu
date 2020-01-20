# YBPopupMenu
 * 快速集成popupMenu

# 效果图
![(演示效果)](https://lyb5834.github.io/Images/YBPopupMenuGif.gif)

# cocoapods支持
  * 只需在`Podfile`中加入`pod 'YBPopupMenu'`后`pod install`即可

# 最近更新
  * 删除老版初始化方法，避免频繁调用`[self updateUI]`方法
  * 增加横竖屏适配
  * 增加可选择的动画，暂时只有`YBPopupMenuAnimationStyleScale` 和 `YBPopupMenuAnimationStyleFade`两种，可自定义

# 上次更新
  * 代码全部重构，不过完全兼容原先的API接口
  * 增加了`YBPopupMenuPriorityDirection`属性，可以设置箭头的第一优先级方向，当将要超过屏幕时会自动反转方向
  * 增加了`rectCorner`属性，可以自定义圆角（当反转时会自动镜像的反转圆角）
  * 可以设置边框颜色，边框粗细等
  * 支持传入`NSAttributedString`
  * 开放部分私有属性，如`titles`，`images`,`tableView`,`minSpace`等等
  * 点击回调方法有更新（旧的还可以用）
  * 增加可自定义Cell的回调，遇到奇葩需求可以自定义设置（具体使用方法可参考demo）

# 注意
  1. 当箭头优先级是`YBPopupMenuPriorityDirectionLeft`/`YBPopupMenuPriorityDirectionRight`/`YBPopupMenuPriorityDirectionNone`时需手动设置`arrowPosition`来设置箭头在该行的位置
  2. 边框宽度不宜过粗，影响美观

# 使用方法
  * `#import "YBPopupMenu.h"`
  ```
  [YBPopupMenu showAtPoint:p titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        popupMenu...;
    }];
  ```


# 版本支持
  * `xcode7.0+`

  * 如果您在使用本库的过程中发现任何bug或者有更好建议，欢迎 [@issues](https://github.com/lyb5834/YBPopupMenu/issues) 我或联系本人email lyb5834@126.com
