//
//  LHCBubbleView.h
//  11月22日
//
//  Created by 我是五高你敢信 on 2016/11/22.
//  Copyright © 2016年 我是五高你敢信. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BubblePathType) {
    BubblePathTypeLeft, //先向左
    BubblePathTypeRight //先向右
};

@interface LHCBubbleView : UIImageView

- (instancetype)initWithMaxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth maxFrame:(CGRect)maxFrame;

@end
