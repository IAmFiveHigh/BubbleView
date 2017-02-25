//
//  ViewController.m
//  11月22日
//
//  Created by 我是五高你敢信 on 2016/11/22.
//  Copyright © 2016年 我是五高你敢信. All rights reserved.
//

#import "ViewController.h"
#import "LHCBubbleView.h"
@interface ViewController ()

@property (nonatomic, assign) NSInteger bubbleNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    [layer setFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    layer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:0.5].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    [self.view.layer addSublayer:layer];
    
    self.bubbleNumber = 0;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.bubbleNumber <= 30) {
        LHCBubbleView *view = [[LHCBubbleView alloc] initWithMaxHeight:self.view.bounds.size.height/1.5 maxWidth:self.view.bounds.size.width/2.5 maxFrame:CGRectMake([self makeRandomNumberFromMin:0 toMax:self.view.bounds.size.width], self.view.center.y, 50, 50)];
        [self.view addSubview:view];
    }
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
