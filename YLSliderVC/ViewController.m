//
//  ViewController.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "YLSliderViewController.h"

@interface ViewController ()

@property (nonatomic, strong) YLSliderViewController *SliderVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _SliderVC = [[YLSliderViewController alloc] init];
    
    [self.view addSubview:_SliderVC.view];
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Btn setBackgroundColor:[UIColor redColor]];
    [_SliderVC.containView addSubview:Btn];
    
    [Btn addTarget:self action:@selector(clickMenuBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)clickMenuBtn{
    if (_SliderVC.SliderIsHidden) {
        [_SliderVC showSliderView];
    }else{
        [_SliderVC hideSliderView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
