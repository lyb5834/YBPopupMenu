//
//  YBPopupMenuPath.m
//  YBPopupMenu
//
//  Created by lyb on 2017/5/9.
//  Copyright © 2017年 lyb. All rights reserved.
//

#import "YBPopupMenuPath.h"
#import "YBRectConst.h"

@implementation YBPopupMenuPath

+ (CAShapeLayer *)yb_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(YBPopupMenuArrowDirection)arrowDirection
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self yb_bezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection].CGPath;
    return shapeLayer;
}


+ (UIBezierPath *)yb_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(YBPopupMenuArrowDirection)arrowDirection
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, YBRectWidth(rect) - borderWidth, YBRectHeight(rect) - borderWidth);
    CGFloat topRightRadius = 0,topLeftRadius = 0,bottomRightRadius = 0,bottomLeftRadius = 0;
    CGPoint topRightArcCenter,topLeftArcCenter,bottomRightArcCenter,bottomLeftArcCenter;
    
    if (rectCorner & UIRectCornerTopLeft) {
        topLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerTopRight) {
        topRightRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomLeft) {
        bottomLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomRight) {
        bottomRightRadius = cornerRadius;
    }
    
    if (arrowDirection == YBPopupMenuArrowDirectionTop) {
        topLeftArcCenter = CGPointMake(topLeftRadius + YBRectX(rect), arrowHeight + topLeftRadius + YBRectX(rect));
        topRightArcCenter = CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect), arrowHeight + topRightRadius + YBRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) - bottomLeftRadius + YBRectX(rect));
        bottomRightArcCenter = CGPointMake(YBRectWidth(rect) - bottomRightRadius + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius + YBRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > YBRectWidth(rect) - topRightRadius - arrowWidth / 2) {
            arrowPosition = YBRectWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, YBRectTop(rect) + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - topRightRadius, arrowHeight + YBRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius - YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) + YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectX(rect), arrowHeight + topLeftRadius + YBRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionBottom) {
        topLeftArcCenter = CGPointMake(topLeftRadius + YBRectX(rect),topLeftRadius + YBRectX(rect));
        topRightArcCenter = CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect), topRightRadius + YBRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) - bottomLeftRadius + YBRectX(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(YBRectWidth(rect) - bottomRightRadius + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius + YBRectX(rect) - arrowHeight);
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > YBRectWidth(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = YBRectWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, YBRectHeight(rect) - arrowHeight + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, YBRectHeight(rect) + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, YBRectHeight(rect) - arrowHeight + YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) - arrowHeight + YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectX(rect), topLeftRadius + YBRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect), YBRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius - YBRectX(rect) - arrowHeight)];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionLeft) {
        topLeftArcCenter = CGPointMake(topLeftRadius + YBRectX(rect) + arrowHeight,topLeftRadius + YBRectX(rect));
        topRightArcCenter = CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect), topRightRadius + YBRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + YBRectX(rect) + arrowHeight, YBRectHeight(rect) - bottomLeftRadius + YBRectX(rect));
        bottomRightArcCenter = CGPointMake(YBRectWidth(rect) - bottomRightRadius + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius + YBRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > YBRectHeight(rect) - bottomLeftRadius - arrowWidth / 2) {
            arrowPosition = YBRectHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowHeight + YBRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(YBRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + YBRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + YBRectX(rect), topLeftRadius + YBRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - topRightRadius, YBRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius - YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) + YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionRight) {
        topLeftArcCenter = CGPointMake(topLeftRadius + YBRectX(rect),topLeftRadius + YBRectX(rect));
        topRightArcCenter = CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect) - arrowHeight, topRightRadius + YBRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) - bottomLeftRadius + YBRectX(rect));
        bottomRightArcCenter = CGPointMake(YBRectWidth(rect) - bottomRightRadius + YBRectX(rect) - arrowHeight, YBRectHeight(rect) - bottomRightRadius + YBRectX(rect));
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        }else if (arrowPosition > YBRectHeight(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = YBRectHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(YBRectWidth(rect) - arrowHeight + YBRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) + YBRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - arrowHeight + YBRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - arrowHeight + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius - YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) + YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectX(rect), arrowHeight + topLeftRadius + YBRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect) - arrowHeight, YBRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionNone) {
        topLeftArcCenter = CGPointMake(topLeftRadius + YBRectX(rect),  topLeftRadius + YBRectX(rect));
        topRightArcCenter = CGPointMake(YBRectWidth(rect) - topRightRadius + YBRectX(rect),  topRightRadius + YBRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) - bottomLeftRadius + YBRectX(rect));
        bottomRightArcCenter = CGPointMake(YBRectWidth(rect) - bottomRightRadius + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius + YBRectX(rect));
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + YBRectX(rect), YBRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) - topRightRadius, YBRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectWidth(rect) + YBRectX(rect), YBRectHeight(rect) - bottomRightRadius - YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + YBRectX(rect), YBRectHeight(rect) + YBRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(YBRectX(rect), arrowHeight + topLeftRadius + YBRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    }
    
    [bezierPath closePath];
    return bezierPath;
}

@end
