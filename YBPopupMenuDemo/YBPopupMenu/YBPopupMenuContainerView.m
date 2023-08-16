//
//  YBPopupMenuContainerView.m
//  YBPopupMenuDemo
//
//  Created by liyuanbo on 2023/8/16.
//  Copyright © 2023 LYB. All rights reserved.
//

#import "YBPopupMenuContainerView.h"

@implementation YBPopupMenuContainerView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath = [YBPopupMenuPath yb_bezierPathWithRect:rect rectCorner:_rectCorner cornerRadius:_cornerRadius borderWidth:_borderWidth borderColor:_borderColor backgroundColor:_backColor arrowWidth:_arrowWidth arrowHeight:_arrowHeight arrowPosition:_arrowPosition arrowDirection:_arrowDirection arrowStyle:_arrowStyle];
    [bezierPath fill];
    [bezierPath stroke];
}

@end
