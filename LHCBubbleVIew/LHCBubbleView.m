//
//  LHCBubbleView.m
//  11月22日
//
//  Created by 我是五高你敢信 on 2016/11/22.
//  Copyright © 2016年 我是五高你敢信. All rights reserved.
//

#import "LHCBubbleView.h"

@interface LHCBubbleView () <CAAnimationDelegate>

@property (nonatomic, assign) CGFloat maxHeigth;

@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, assign) BubblePathType type;

//每一次动画执行的最大高度和最大宽度
@property (nonatomic, assign)CGFloat nowMaxHeight;

@property (nonatomic, assign)CGFloat nowMaxWidth;

@property (nonatomic, assign)CGPoint originPoint;

@property (nonatomic, assign)CGRect originFrame;

@end

@implementation LHCBubbleView

- (instancetype)initWithMaxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth maxFrame:(CGRect)maxFrame {
    if (self = [super initWithImage:[UIImage imageNamed:@"bubble"]]) {
        self.maxWidth = maxWidth;
        self.maxHeigth = maxHeight;
        self.originFrame = maxFrame;
        
        self.frame = [self getRandomFrameWithFrame:maxFrame];

        self.originPoint = self.frame.origin;
        
        self.alpha = [self makeRandomNumberFromMin:0.5 toMax:1];
        
        [self getRandomBubblePathType];
        
        [self getRandomPathWidthAndHeight];
        
        [self setUpBezierPath];
        
    }return self;
}

//MARK: 绘制贝塞尔路径
- (void)setUpBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.originPoint];
    
    if (self.type == BubblePathTypeLeft) {
        CGPoint leftControlPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth/2, self.originPoint.y - self.nowMaxHeight/4);
        CGPoint rightControlPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth/2, self.originPoint.y - self.nowMaxHeight/4*3);
        CGPoint destinationPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        
        [path addCurveToPoint:destinationPoint controlPoint1:leftControlPoint controlPoint2:rightControlPoint];
    }else {
        CGPoint rightControlPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth/2, self.originPoint.y - self.nowMaxHeight/4);
        CGPoint leftControlPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth/2, self.originPoint.y - self.nowMaxHeight/4*3);
        CGPoint destinationPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        [path addCurveToPoint:destinationPoint controlPoint1:rightControlPoint controlPoint2:leftControlPoint];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.0f;
    animation.path = path.CGPath;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"movingAnimation"];
}

//MARK:CAKeyFramAnimation协议方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [UIView transitionWithView:self duration:0.1f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
            
        } completion:^(BOOL finished) {
            if (finished == YES) {
                [self.layer removeAllAnimations];
                [self removeFromSuperview];
            }
        }];
    }];
    [CATransaction commit];
}

//MARK: 随机返回PathWidth和PathHeigth
- (void)getRandomPathWidthAndHeight {
    self.nowMaxWidth = [self makeRandomNumberFromMin:self.maxWidth/2 toMax:self.maxWidth];
    self.nowMaxHeight = [self makeRandomNumberFromMin:self.maxHeigth/2 toMax:self.maxHeigth];
}

//MARK: 随机返回pathType
- (void)getRandomBubblePathType {
    if (arc4random() % 2 == 1) {
        self.type = BubblePathTypeLeft;
    }else {
        self.type = BubblePathTypeRight;
    }
}

//MARK: 返回一个随机Frame
- (CGRect)getRandomFrameWithFrame:(CGRect)frame {
    CGFloat width = [self makeRandomNumberFromMin:15 toMax:self.originFrame.size.height ];
    return CGRectMake(frame.origin.x, frame.origin.y, width, width);
}

//MARK: 返回一个随机CGFloat值
- (CGFloat)makeRandomNumberFromMin:(CGFloat)min toMax: (CGFloat)max
{
    NSInteger precision = 100;
    
    CGFloat subtraction = ABS(max - min);
    
    subtraction *= precision;
    
    CGFloat randomNumber = arc4random() % ((int)subtraction+1);
    
    randomNumber /= precision;
    
    randomNumber += min;
    
    //返回结果
    return randomNumber;
}
@end
