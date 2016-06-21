//
//  ViewController.m
//  04-UIPageViewControllerDemo2
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *willDisPlayVCS;      //所有的内容控制器
@end

@implementation ViewController
//所有的内容控制器
-(NSArray *)willDisPlayVCS{
    if (_willDisPlayVCS == nil) {
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
        FourthViewController *fourthVC = [[FourthViewController alloc] init];
        _willDisPlayVCS = @[firstVC,secondVC,thirdVC,fourthVC];
    }
    return _willDisPlayVCS;
}
//pageViewController
-(UIPageViewController *)pageViewController{
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(10.0)}];
        
        //设置数据源和代理
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        //设置内容控制器
        [_pageViewController setViewControllers:@[self.willDisPlayVCS[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return _pageViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加pageViewController
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -UIPageViewControllerDataSource
//设置上一页内容控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //获取当前viewController的索引
    NSInteger index = [self.willDisPlayVCS indexOfObject:viewController];
    
//    if (index == 0) {
//        return nil;
//    }else{
//        return self.willDisPlayVCS[index - 1];
//    }
    
    return index ? self.willDisPlayVCS[index - 1] : nil;
}

//设置下一页内容控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //获取当前viewController的索引
    NSInteger index = [self.willDisPlayVCS indexOfObject:viewController];
    
//    if (index == self.willDisPlayVCS.count - 1) {
//        return nil;
//    }else{
//        return self.willDisPlayVCS[index + 1];
//    }
    
    return index == self.willDisPlayVCS.count - 1 ? nil : self.willDisPlayVCS[index + 1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
