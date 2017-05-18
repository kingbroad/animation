//
//  GroupAnimationViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/18.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation GroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.redView = [[UIView alloc] init];
    self.redView.center = self.view.center;
    self.redView.bounds = CGRectMake(0, 0, 100, 100);
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    [self GroupAnimationForCase];
}
//缩放 + path
- (void) GroupAnimationForCase
{
    
    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    translationAnimation.duration = 5.0f;
    translationAnimation.fromValue = @0;
    translationAnimation.toValue = @1;
    
    
    CAKeyframeAnimation *animPath = [CAKeyframeAnimation animation];
    animPath.keyPath = @"position";
    animPath.duration = 5;
    // 取消反弹
    // 告诉在动画结束的时候不要移除
    animPath.removedOnCompletion = NO;
    // 始终保持最新的效果
    animPath.fillMode = kCAFillModeForwards;
    // Oval 椭圆  路径轨迹
    animPath.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 200, 100, 100)].CGPath;
    animPath.repeatCount = MAXFLOAT;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[translationAnimation,animPath];
    groupAnimation.duration = 10;
    [self.redView.layer addAnimation:groupAnimation forKey:@"Group"];
    
}




@end
