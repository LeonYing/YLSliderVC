//
//  SliderViewController.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "YLSliderViewController.h"
#import "Masonry.h"

@interface YLSliderViewController ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) CGFloat lastOffset;

@end

@implementation YLSliderViewController

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _sliderView = [[UIView alloc] init];
    _sliderView.backgroundColor = [UIColor grayColor];
    _sliderView.layer.contents = (id)[UIImage imageNamed:@"sliderBg"].CGImage;
    [self.view addSubview:_sliderView];
    
    self.SliderIsHidden = YES;
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@(200));
        make.height.equalTo(self.view.mas_height);
        make.centerY.equalTo(self.view);
    }];
    return self;
}

- (void)setUpContainView:(UIView *)containView{
    _containView = containView;
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(HandlePan:)];
    [self.containView addGestureRecognizer:_pan];
    
    [self.view addSubview:_containView];
    if (!self.SliderIsHidden) {
        [self.view setNeedsUpdateConstraints];
        [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(200);
            make.width.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(self.view.mas_height);
        }];
        [self.view layoutIfNeeded];
        [self hideSliderView];
    }
    else{
        [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(self.view.mas_height);
        }];
    }
}

- (void)showSliderView{
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(200);
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    _lastOffset = 200;
    self.SliderIsHidden = NO;
}
- (void)hideSliderView{
    [self.view setNeedsUpdateConstraints];
    [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    _lastOffset = 0;
    self.SliderIsHidden = YES;
}


- (void)HandleWithOffset:(CGFloat)offset{
    //    static CGFloat lastOffset;
    CGFloat toOffset = _lastOffset + offset;
    if (toOffset<=200 && toOffset>=0) {
        _lastOffset = toOffset;
//        NSLog(@"%f",_lastOffset);
        [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(_lastOffset);
        }];
    }
}

- (void)HandleWithTouchEnd{
    if (_lastOffset>=100) {
        [self showSliderView];
    }else{
        [self hideSliderView];
    }
}

- (void)HandlePan:(UIPanGestureRecognizer *)recognizer{
    CGFloat offset = [recognizer translationInView:self.containView].x;
    [recognizer setTranslation:CGPointZero inView:self.containView];
//    NSLog(@"offset is %f",offset);
    [self HandleWithOffset:offset];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self HandleWithTouchEnd];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
