//
//  KeyFrameAnimationViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/18.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

@interface KeyFrameAnimationViewController ()
@property (nonatomic, strong) UIView *redView;
@end

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.redView = [[UIView alloc] init];
    self.redView.center = self.view.center;
    self.redView.bounds = CGRectMake(0, 0, 30, 30);
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
     NSArray *arr=[NSArray arrayWithObjects:@"path",@"value", nil];
    for (int i=0; i<arr.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+i*90, self.view.bounds.size.height-80, 80, 25);
        btn.tag = i;
        btn.backgroundColor = [UIColor darkGrayColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
        {
            [self keyAnimationForPath];
        }
            break;
        case 1:
        {
            [self keyAnimationForValue];
        }
            break;
        default:
            break;
    }
}

//path
- (void) keyAnimationForPath
{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.duration = 5;
    // 取消反弹
    // 告诉在动画结束的时候不要移除
    anim.removedOnCompletion = NO;
    // 始终保持最新的效果
    anim.fillMode = kCAFillModeForwards;
    // Oval 椭圆  路径轨迹
    anim.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 200, 100, 100)].CGPath;
    anim.repeatCount = MAXFLOAT;
    // 将动画对象添加到 绿色视图的layer上去
    [_redView.layer addAnimation:anim forKey:nil];
    
}

//value
- (void) keyAnimationForValue
{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.duration = 0.3;
    anim.keyPath = @"transform";
    NSValue *value =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value1 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value2 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    anim.values = @[value,value1,value2];
    anim.repeatCount = MAXFLOAT;
    [_redView.layer addAnimation:anim forKey:nil];
    
}


@end
