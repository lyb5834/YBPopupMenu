# YBPopupMenu
 * 快速集成popupMenu

# 效果图
![(演示效果)](http://7xt3dd.com1.z0.glb.clouddn.com/YBPopupMenuGifShow.gif)

#cocoapods支持
  * 只需在`Podfile`中加入`pod 'YBPopupMenu'`后`pod install`即可

#最新更新
  * 可以选择显示模式，有2种（明色和暗色）

  * 修复了设置了`dismissOnTouchOutside`后不能dismiss的bug

#使用方法
  * `#import "YBPopupMenu.h"`
  * 类方法 `[YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 delegate:self];`

  * 对象方法 `YBPopupMenu *popupMenu = [[YBPopupMenu alloc] initWithTitles:TITLES icons:nil menuWidth:110 delegate:self];
    [popupMenu showAtPoint:p];`  因为代码架构问题，多次弹出会出现不可预知的问题，因此该方法已移除！！！

#版本支持
  * `xcode7.0+`

  * 如果您在使用本库的过程中发现任何bug或者有更好建议，欢迎联系本人email  lyb5834@126.com

