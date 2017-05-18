//
//  ViewController.m
//  AnimationTest
//
//  Created by TakumiShen on 17/5/16.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "ViewController.h"
#import "CoreAnimationViewController.h"
#import "BezierPathViewController.h"
#import "BasicAnimationViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "GroupAnimationViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , strong) UITableView *JCContactTableView;
@property (nonatomic , strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arr = [NSMutableArray arrayWithObjects:@"CoreAnmation普通动画运用",@"BezierPath实例",@"BasicAnimation运用",@"KeyframeAnimation运用",@"GroupAnimation运用", nil];
    [self initTableView];
}

//初始化表
-(void)initTableView
{
    self.JCContactTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.JCContactTableView.backgroundColor = [UIColor whiteColor];
    self.JCContactTableView.tableFooterView = [[UIView alloc]init];
    self.JCContactTableView.delegate = self;
    self.JCContactTableView.dataSource = self;
    [self.view addSubview:self.JCContactTableView];
}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}
#pragma mark --UITableViewDelegate
//点击行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            CoreAnimationViewController *coreAnimationVC= [[CoreAnimationViewController alloc] init];
            [self.navigationController pushViewController:coreAnimationVC animated:YES];
        }
            break;
        case 1:
        {
            BezierPathViewController *bezierPathVc=[[BezierPathViewController alloc] init];
            [self.navigationController pushViewController:bezierPathVc animated:YES];
        }
            break;
        case 2:
        {
            BasicAnimationViewController  *basicAnimationVc = [[BasicAnimationViewController alloc] init];
            [self.navigationController pushViewController:basicAnimationVc animated:YES];
        }
            break;
        case 3:
        {
            KeyFrameAnimationViewController *keyFrameAnimationVc=[[KeyFrameAnimationViewController  alloc] init];
            [self.navigationController pushViewController:keyFrameAnimationVc animated:YES];
        }
            break;
        case 4:
        {
            GroupAnimationViewController *groupAnimationVc = [[GroupAnimationViewController alloc] init];
            [self.navigationController pushViewController:groupAnimationVc animated:YES];
        }
            break;
        default:
            break;
    }
}
//有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置y的初始值为0.1
    //缩放
    //CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
    //平移
//    CATransform3DMakeTranslation(CGFloat tx, CGFloat ty, CGFloat tz)
    //旋转
//    CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    //通过2D得到一个3D矩阵
//    CATransform3DMakeAffineTransform(<#CGAffineTransform m#>)
    cell.layer.transform = CATransform3DMakeTranslation(-self.view.bounds.size.width,0,0);
    //cell.layer.transform = CATransform3DMakeRotation(180*M_PI/180, 1, 0, 0);
    //cell.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
    [UIView animateWithDuration:indexPath.row+1 animations:^{
        cell.layer.transform = CATransform3DMakeTranslation(0,0,0);
        //cell.layer.transform = CATransform3DMakeRotation(0*M_PI/180, 0, 0, 0);
        //cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}


@end
