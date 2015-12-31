//
//  ViewController.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "YLSliderViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) YLSliderViewController *SliderVC;
@property (nonatomic, strong) UIView *containView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _SliderVC = [[YLSliderViewController alloc] init];
    [self.view addSubview:_SliderVC.view];
    [self setUpSliderView];
    
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Btn setBackgroundColor:[UIColor redColor]];
    
    _containView = [[UIView alloc] init];;
    _containView.backgroundColor = [UIColor blueColor];
    _containView.layer.contents = (id)[UIImage imageNamed:@"topBg"].CGImage;
    
    [_SliderVC setUpContainView:_containView];
    [_SliderVC.containView addSubview:Btn];
    
    
    
    [Btn addTarget:self action:@selector(clickMenuBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpSliderView{
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [_SliderVC.sliderView addSubview:btn1];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(changeVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blueColor];
    [_SliderVC.sliderView addSubview:btn2];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(changeVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton new];
    [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor grayColor];
    [_SliderVC.sliderView addSubview:btn3];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(changeVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_SliderVC.sliderView.mas_centerX);
        make.centerY.equalTo(btn2.mas_centerY).offset(-40);
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_SliderVC.sliderView.mas_centerX);
        make.centerY.equalTo(_SliderVC.sliderView.mas_centerY);
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_SliderVC.sliderView.mas_centerX);
        make.centerY.equalTo(btn2.mas_centerY).offset(40);
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];
}

- (void)changeVCWithBtn:(UIButton *)Btn{
    _containView = [[UIView alloc] init];;
    NSLog(@"Btn%ld",Btn.tag);
    if (Btn.tag==1) {
        _containView.backgroundColor = [UIColor redColor];
    }else if(Btn.tag==2){
        _containView.backgroundColor = [UIColor blueColor];
    }else if(Btn.tag==3){
        _containView.backgroundColor = [UIColor grayColor];
    }
    [_SliderVC setUpContainView:_containView];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",event);
//    _containView = [[UIView alloc] init];;
//    _containView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//    
//    [_SliderVC setUpContainView:_containView];
//}

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
