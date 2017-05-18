//
//  CoreAnimationViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/17.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()

@property (nonatomic, strong) UIView *animationView;

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.animationView = [[UIView alloc] init];
    self.animationView.center = self.view.center;
    self.animationView.bounds = CGRectMake(0, 0, 100, 100);
    self.animationView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.animationView];
    
    NSArray *arr=[NSArray arrayWithObjects:@"平移",@"弹性",@"帧动画", nil];
    
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
            [self translationAnimation];
        }
            break;
        case 1:
        {
            [self springAnimation];
        }
            break;
        case 2:
        {
            [self keyFrameAnimation];
        }
            break;
        default:
            break;
    }
}
//平移动画
- (void) translationAnimation{
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self.animationView.frame = CGRectMake(self.view.bounds.size.width-100, self.view.bounds.size.height-100, 100, 100);
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
    
}
//弹性动画
- (void) springAnimation{
    /**
     *  弹性动画
     *
     *   @param Duration 持续时间
         @param delay 延迟多长时间开始
         @param usingSpringWithDamping 阻尼系数(0～1),阻尼系数越大，弹性越小反之越大
         @param initialSpringVelocity 形变的速度
     */
    [UIView animateWithDuration:5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionRepeat animations:^{
        self.animationView.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

//帧动画
- (void) keyFrameAnimation{
    CGPoint originCenter = self.animationView.center;
    [UIView animateKeyframesWithDuration:10 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            CGPoint center = self.animationView.center;
            center.x += 80.0f;
            center.y -=10.0f;
            self.animationView.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            self.animationView.transform = CGAffineTransformMakeRotation(-M_PI_4/2);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            CGPoint center = self.animationView.center;
            center.x += 100.0f;
            center.y -= 50.0f;
            self.animationView.center = center;
            self.animationView.alpha = 0.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            self.animationView.transform = CGAffineTransformIdentity;
            self.animationView.center = CGPointMake(0, originCenter.y);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.animationView.alpha = 1.0;
            self.animationView.center = originCenter;
        }];

    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}


@end
