//
//  BezierPathViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/17.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "BezierPathViewController.h"

@interface BezierPathViewController ()

@property (nonatomic ,strong) CAShapeLayer *baseLayer;

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr=[NSArray arrayWithObjects:@"三角形",@"圆圈",@"椭圆", nil];
    
    NSArray *arr1=[NSArray arrayWithObjects:@"二次曲线",@"三次曲线",@"火车运动", nil];
    
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
    if (self.baseLayer) {
        [self.baseLayer removeAllAnimations];
        [self.baseLayer removeFromSuperlayer];
        self.baseLayer = nil;
    }
    [self clearViewOfLayer];
    switch (btn.tag) {
        case 0:
        {
            [self drawTriangleAnimation];
        }
            break;
        case 1:
        {
            [self drawClycleAnimation];
        }
            break;
        case 2:
        {
            [self drawEllipseAnimation];
        }
            break;
        case 3:
        {
            [self drawQuadraticCurveAnimation];
        }
            break;
        case 4:
        {
            [self drawCubicCurveAnimation];
        }
            break;
        case 5:
        {
            [self caseForBezier];
        }
            break;
        default:
            break;
    }
}

//画三角形动画
- (void) drawTriangleAnimation{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(100, 400)];
    [trianglePath addLineToPoint:CGPointMake(200, 400)];
    [trianglePath addLineToPoint:CGPointMake(150, 200)];
    [trianglePath closePath];
    shapeLayer.path = trianglePath.CGPath;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5.0f;
    [self.view.layer addSublayer:shapeLayer];
    [self animationWithDraw2:shapeLayer duration:5];
    
}
//画圆圈动画
- (void) drawClycleAnimation{
    
    CAShapeLayer *cycleLayer = [CAShapeLayer layer];
    UIBezierPath *cyclePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 300, 100, 100) cornerRadius:50];
    cycleLayer.path = cyclePath.CGPath;
    cycleLayer.strokeColor = [UIColor orangeColor].CGColor;
    cycleLayer.fillColor = [UIColor clearColor].CGColor;
    cycleLayer.lineWidth = 5.0f;
    [self.view.layer addSublayer:cycleLayer];
    [self animationWithDraw2:cycleLayer duration:5];
    
}
//画椭圆动画
- (void) drawEllipseAnimation{
    
    CAShapeLayer *ellipseLayer = [CAShapeLayer layer];
    UIBezierPath *bethPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 200, 100, 80)];
    ellipseLayer.path = bethPath.CGPath;
    ellipseLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    ellipseLayer.fillColor = [UIColor clearColor].CGColor;
    ellipseLayer.lineWidth =5.0f;
    [self.view.layer addSublayer:ellipseLayer];
    [self animationWithDraw2:ellipseLayer duration:5];
    
}
// 画二次曲线
- (void) drawQuadraticCurveAnimation{
    
    CAShapeLayer *curveLayer = [CAShapeLayer layer];
    UIBezierPath *curvePath = [UIBezierPath bezierPath];
    [curvePath moveToPoint:CGPointMake(100, 300)];
    [curvePath addQuadCurveToPoint:CGPointMake(180, 380) controlPoint:CGPointMake(160, 50)];
    curveLayer.path = curvePath.CGPath;
    curveLayer.fillColor = [UIColor clearColor].CGColor;
    curveLayer.strokeColor = [UIColor yellowColor].CGColor;
    curveLayer.lineWidth = 5.0f;;
    [self.view.layer addSublayer:curveLayer];
    [self animationWithDraw2:curveLayer duration:5];
    
}
// 画三次曲线
- (void) drawCubicCurveAnimation{
    
    CAShapeLayer *curveLayer = [CAShapeLayer layer];
    UIBezierPath *curvePath = [UIBezierPath bezierPath];
    [curvePath moveToPoint:CGPointMake(100, 300)];
    [curvePath addCurveToPoint:CGPointMake(200, 300) controlPoint1:CGPointMake(130, 200) controlPoint2:CGPointMake(160, 250)];
    curveLayer.path = curvePath.CGPath;
    curveLayer.fillColor = [UIColor clearColor].CGColor;
    curveLayer.strokeColor = [UIColor redColor].CGColor;
    curveLayer.lineWidth = 5.0f;;
    [self.view.layer addSublayer:curveLayer];
    [self animationWithDraw2:curveLayer duration:5];
    
}

- (void)animationWithDraw2:(CAShapeLayer *)layer duration:(CFTimeInterval)duration {
    
    //这里的keyPath有很多值，除了自带的一些值之外，还有一些其他的值可以用，像strokeEnd、strokeStart、path等！
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //fromValue：开始值，toValue：结束值，这两个值的取值范围为（0，1），不可超出
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = duration;//动画持续时间
    [layer addAnimation:animation forKey:nil];
    
}

//清除创建的layer
- (void) clearViewOfLayer{
    if (self.view.layer.sublayers.count==0) {
        return;
    }
    for (CALayer *layer in self.view.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}
//UIBezierPath 事例
- (void) caseForBezier{
    
    //1、创建beth轨迹
    UIBezierPath *trajectoryPath = [UIBezierPath bezierPath];
    [trajectoryPath moveToPoint:CGPointMake(0, 300)];
    [trajectoryPath addLineToPoint:CGPointMake(60, 300)];
    [trajectoryPath addArcWithCenter:CGPointMake(90, 300) radius:30 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    [trajectoryPath addArcWithCenter:CGPointMake(150, 300) radius:30 startAngle:M_PI endAngle:0 clockwise:NO];
    [trajectoryPath addQuadCurveToPoint:CGPointMake(self.view.bounds.size.width, 300) controlPoint:CGPointMake(300, 100)];
    //2、绘制运动路径轨迹
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = trajectoryPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    
    //3、创建火车
    CAShapeLayer *tralLayer = [CAShapeLayer layer];
    UIBezierPath *tralPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 10, 10) cornerRadius:5];
    tralLayer.path = tralPath.CGPath;
    tralLayer.fillColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:tralLayer];
    //4、火车动起来
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //pathAnimation.calculationMode = kCAAnimationPaced;// 我理解为节奏
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;// 是否在动画完成后从 Layer 层上移除  回到最开始状态
    pathAnimation.duration = 10.0f;// 动画时间
    //处理卡顿
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.repeatCount = MAXFLOAT;// 动画重复次数
    pathAnimation.path = trajectoryPath.CGPath;
    [tralLayer addAnimation:pathAnimation forKey:@"tral"];
    [self.view.layer addSublayer:shapeLayer];
    self.baseLayer = tralLayer;
}




@end
