//
//  YBPopupMenuPath.m
//  YBPopupMenu
//
//  Created by lyb on 2017/5/9.
//  Copyright © 2017年 lyb. All rights reserved.
//

#import "YBPopupMenuPath.h"

@implementation YBPopupMenuPath

+ (CAShapeLayer *)yb_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(YBPopupMenuArrowDirection)arrowDirection
                            arrowStyle:(YBPopupMenuArrowStyle)arrowStyle
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self yb_bezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection arrowStyle:arrowStyle].CGPath;
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
                             arrowStyle:(YBPopupMenuArrowStyle)arrowStyle
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, CGRectGetWidth(rect) - borderWidth, CGRectGetHeight(rect) - borderWidth);
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
        topLeftArcCenter = CGPointMake(topLeftRadius + CGRectGetMinX(rect), arrowHeight + topLeftRadius + CGRectGetMinX(rect));
        topRightArcCenter = CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect), arrowHeight + topRightRadius + CGRectGetMinX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomLeftRadius + CGRectGetMinX(rect));
        bottomRightArcCenter = CGPointMake(CGRectGetWidth(rect) - bottomRightRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius + CGRectGetMinX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > CGRectGetWidth(rect) - topRightRadius - arrowWidth / 2) {
            arrowPosition = CGRectGetWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + CGRectGetMinX(rect))];
        if (arrowStyle == YBPopupMenuArrowStyleStraight) {
            [bezierPath addLineToPoint:CGPointMake(arrowPosition, CGRectGetMinY(rect) + CGRectGetMinX(rect))];
            [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + CGRectGetMinX(rect))];
        } else {
            [bezierPath addCurveToPoint:CGPointMake(arrowPosition, CGRectGetMinY(rect) + CGRectGetMinX(rect))
                          controlPoint1:CGPointMake(arrowPosition - arrowWidth / 2 + arrowWidth / 4, arrowHeight + CGRectGetMinX(rect))
                          controlPoint2:CGPointMake(arrowPosition - arrowWidth / 8, CGRectGetMinY(rect) + CGRectGetMinX(rect))];
            [bezierPath addCurveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + CGRectGetMinX(rect))
                          controlPoint1:CGPointMake(arrowPosition + arrowWidth / 8, CGRectGetMinY(rect) + CGRectGetMinX(rect))
                          controlPoint2:CGPointMake(arrowPosition + arrowWidth / 2 - arrowWidth / 4, arrowHeight + CGRectGetMinX(rect))];
        }
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - topRightRadius, arrowHeight + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius - CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), arrowHeight + topLeftRadius + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionBottom) {
        topLeftArcCenter = CGPointMake(topLeftRadius + CGRectGetMinX(rect),topLeftRadius + CGRectGetMinX(rect));
        topRightArcCenter = CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect), topRightRadius + CGRectGetMinX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomLeftRadius + CGRectGetMinX(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(CGRectGetWidth(rect) - bottomRightRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius + CGRectGetMinX(rect) - arrowHeight);
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > CGRectGetWidth(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = CGRectGetWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))];
        if (arrowStyle == YBPopupMenuArrowStyleStraight) {
            [bezierPath addLineToPoint:CGPointMake(arrowPosition, CGRectGetHeight(rect) + CGRectGetMinX(rect))];
            [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))];
        } else {
            [bezierPath addCurveToPoint:CGPointMake(arrowPosition, CGRectGetHeight(rect) + CGRectGetMinX(rect))
                          controlPoint1:CGPointMake(arrowPosition + arrowWidth / 2 - arrowWidth / 4, CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))
                          controlPoint2:CGPointMake(arrowPosition + arrowWidth / 8, CGRectGetHeight(rect) + CGRectGetMinX(rect))];
            [bezierPath addCurveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))
                          controlPoint1:CGPointMake(arrowPosition - arrowWidth / 8, CGRectGetHeight(rect) + CGRectGetMinX(rect))
                          controlPoint2:CGPointMake(arrowPosition - arrowWidth / 2 + arrowWidth / 4, CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))];
        }
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - arrowHeight + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), topLeftRadius + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect), CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius - CGRectGetMinX(rect) - arrowHeight)];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionLeft) {
        topLeftArcCenter = CGPointMake(topLeftRadius + CGRectGetMinX(rect) + arrowHeight,topLeftRadius + CGRectGetMinX(rect));
        topRightArcCenter = CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect), topRightRadius + CGRectGetMinX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + CGRectGetMinX(rect) + arrowHeight, CGRectGetHeight(rect) - bottomLeftRadius + CGRectGetMinX(rect));
        bottomRightArcCenter = CGPointMake(CGRectGetWidth(rect) - bottomRightRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius + CGRectGetMinX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > CGRectGetHeight(rect) - bottomLeftRadius - arrowWidth / 2) {
            arrowPosition = CGRectGetHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowHeight + CGRectGetMinX(rect), arrowPosition + arrowWidth / 2)];
        if (arrowStyle == YBPopupMenuArrowStyleStraight) {
            [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), arrowPosition)];
            [bezierPath addLineToPoint:CGPointMake(arrowHeight + CGRectGetMinX(rect), arrowPosition - arrowWidth / 2)];
        } else {
            [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(rect), arrowPosition)
                          controlPoint1:CGPointMake(arrowHeight + CGRectGetMinX(rect), arrowPosition + arrowWidth / 2 - arrowWidth / 4)
                          controlPoint2:CGPointMake(CGRectGetMinX(rect), arrowPosition + arrowWidth / 8)];
            [bezierPath addCurveToPoint:CGPointMake(arrowHeight + CGRectGetMinX(rect), arrowPosition - arrowWidth / 2)
                          controlPoint1:CGPointMake(CGRectGetMinX(rect), arrowPosition - arrowWidth / 8)
                          controlPoint2:CGPointMake(arrowHeight + CGRectGetMinX(rect), arrowPosition - arrowWidth / 2 + arrowWidth / 4)];
        }
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + CGRectGetMinX(rect), topLeftRadius + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - topRightRadius, CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius - CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionRight) {
        topLeftArcCenter = CGPointMake(topLeftRadius + CGRectGetMinX(rect),topLeftRadius + CGRectGetMinX(rect));
        topRightArcCenter = CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect) - arrowHeight, topRightRadius + CGRectGetMinX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomLeftRadius + CGRectGetMinX(rect));
        bottomRightArcCenter = CGPointMake(CGRectGetWidth(rect) - bottomRightRadius + CGRectGetMinX(rect) - arrowHeight, CGRectGetHeight(rect) - bottomRightRadius + CGRectGetMinX(rect));
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        }else if (arrowPosition > CGRectGetHeight(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = CGRectGetHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), arrowPosition - arrowWidth / 2)];
        if (arrowStyle == YBPopupMenuArrowStyleStraight) {
            [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), arrowPosition)];
            [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), arrowPosition + arrowWidth / 2)];
        } else {
            [bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), arrowPosition)
                          controlPoint1:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), arrowPosition - arrowWidth / 2 + arrowWidth / 4)
                          controlPoint2:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), arrowPosition - arrowWidth / 8)];
            [bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), arrowPosition + arrowWidth / 2)
                          controlPoint1:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), arrowPosition + arrowWidth / 8)
                          controlPoint2:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), arrowPosition + arrowWidth / 2 - arrowWidth / 4)];
        }
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - arrowHeight + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius - CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), arrowHeight + topLeftRadius + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect) - arrowHeight, CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        
    }else if (arrowDirection == YBPopupMenuArrowDirectionNone) {
        topLeftArcCenter = CGPointMake(topLeftRadius + CGRectGetMinX(rect),  topLeftRadius + CGRectGetMinX(rect));
        topRightArcCenter = CGPointMake(CGRectGetWidth(rect) - topRightRadius + CGRectGetMinX(rect),  topRightRadius + CGRectGetMinX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomLeftRadius + CGRectGetMinX(rect));
        bottomRightArcCenter = CGPointMake(CGRectGetWidth(rect) - bottomRightRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius + CGRectGetMinX(rect));
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + CGRectGetMinX(rect), CGRectGetMinX(rect))];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) - topRightRadius, CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect) + CGRectGetMinX(rect), CGRectGetHeight(rect) - bottomRightRadius - CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + CGRectGetMinX(rect), CGRectGetHeight(rect) + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), arrowHeight + topLeftRadius + CGRectGetMinX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    }
    
    [bezierPath closePath];
    return bezierPath;
}

@end
