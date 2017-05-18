//
//  BasicAnimationViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/17.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.redView = [[UIView alloc] init];
    self.redView.center = self.view.center;
    self.redView.bounds = CGRectMake(0, 0, 100, 100);
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    
    
    NSArray *arr=[NSArray arrayWithObjects:@"平移",@"缩放",@"翻转", nil];
    
     NSArray *arr1=[NSArray arrayWithObjects:@"背景颜色",@"圆角",@"抖动", nil];
    
    for (int i=0; i<arr.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+i*90, self.view.bounds.size.height-80, 80, 25);
        btn.tag = i;
        btn.backgroundColor = [UIColor darkGrayColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    for (int i=3; i<6; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+(i-3)*90, self.view.bounds.size.height-30, 80, 25);
        btn.tag = i;
        btn.backgroundColor = [UIColor darkGrayColor];
        [btn setTitle:arr1[i-3] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}
- (void)btnClick:(UIButton *)btn{
    [self.redView.layer removeAllAnimations];
    switch (btn.tag) {
        case 0:
        {
            [self basicAnimationForTranslation];
        }
            break;
        case 1:
        {
            [self basicAnimationForZoom];
        }
            break;
        case 2:
        {
            [self basicAnimationForFlip];
        }
            break;
        case 3:
        {
            [self basicAnimationForColor];
        }
            break;
        case 4:
        {
            [self basicAnimationForRoundedCorners];
        }
            break;
        case 5:
        {
            [self basicAnimationForShake];
        }
            break;
        default:
            break;
    }
}
/*
 KeyPath的值
 transform.scale = 比例轉換
 transform.scale.x = 闊的比例轉換
 transform.scale.y = 高的比例轉換
 transform.rotation.z = 平面圖的旋轉
 opacity = 透明度
 margin = 布局
 backgroundColor = 背景颜色
 cornerRadius = 圆角
 borderWidth = 边框宽
 bounds = 大小
 contents = 内容
 contentsRect = 内容大小
 e = 圆角
 frame = 大小位置
 hidden = 显示隐藏
 mask ＝ 图层
 masksToBounds ＝ 是否切圆角
 position ＝ 位置
 shadowColor ＝ 阴影颜色
 shadowOffset ＝ 阴影偏移距离
 shadowOpacity ＝ 阴影透明度
 shadowRadius ＝ 阴影圆角
 */
//平移
- (void) basicAnimationForTranslation
{
    
    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    translationAnimation.duration = 5.0f;
    translationAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 64, 100, 100)];
    [self.redView.layer addAnimation:translationAnimation forKey:@"Translation"];
    
}

//缩放
- (void) basicAnimationForZoom
{
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.duration = 5.0f;
    zoomAnimation.fromValue = @0;
    zoomAnimation.toValue = @1;
    [self.redView.layer addAnimation:zoomAnimation forKey:@"Zoom"];
    
}

//翻转
- (void) basicAnimationForFlip
{
    
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    flipAnimation.duration = 5.0f;
    flipAnimation.fromValue = @(0);
    flipAnimation.toValue = @(M_PI*2);
    [self.redView.layer addAnimation:flipAnimation forKey:@"Flip"];
    
}
//背景颜色
- (void) basicAnimationForColor
{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnimation.duration = 5.0f;
    colorAnimation.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    colorAnimation.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    [self.redView.layer addAnimation:colorAnimation forKey:@"color"];
    
}

//圆角动画
- (void) basicAnimationForRoundedCorners
{
    
    CABasicAnimation *roundAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    roundAnimation.duration = 5.0f;
    roundAnimation.fromValue = @0;
    roundAnimation.toValue = @50;
    //当动画结束后,layer会一直保持着动画最后的状态
    roundAnimation.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:roundAnimation forKey:@"RoundedCorners"];
}

- (void) basicAnimationForShake
{
    CGPoint position = self.redView.layer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:MAXFLOAT];
    // 添加上动画
    [self.redView.layer addAnimation:animation forKey:nil];
}


@end
