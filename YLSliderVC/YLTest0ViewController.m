//
//  YLTest0ViewController.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 16/1/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YLTest0ViewController.h"

@implementation YLTest0ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(100);
    }];
    [btn addTarget:self action:@selector(clilkBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clilkBtn{
    YLViewController *vc = [[YLViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    vc.title = @"Test";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
