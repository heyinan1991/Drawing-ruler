//
//  XCNIndicatorView.m
//  尺子
//
//  Created by xuchuangnan on 15/12/14.
//  Copyright © 2015年 xuchuangnan. All rights reserved.
//

#import "XCNIndicatorView.h"
@interface XCNIndicatorView ()
@property(nonatomic ,assign) CGFloat vaule;
@end

@implementation XCNIndicatorView
- (void)refreshWithVaule:(CGFloat)vaule
{
    self.vaule = vaule;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    
    CGFloat bottom = self.bounds.size.height;
    CGFloat centerX = self.bounds.size.width * 0.5;
    
    CGContextMoveToPoint(context, centerX, bottom);
    CGContextAddLineToPoint(context, centerX - 8, bottom - 10);
    CGContextAddLineToPoint(context, centerX + 8, bottom - 10);
    CGContextClosePath(context);
    
    CGContextFillPath(context);
    
    NSString *value = [NSString stringWithFormat:@"%.1fKg",self.vaule-0.1];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    [value drawAtPoint:CGPointMake(centerX-15, bottom - 35) withAttributes:dict];
    
}

@end
