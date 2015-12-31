//
//  SliderViewController.h
//  YLSliderVC
//
//  Created by NaiveVDisk on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLSliderViewController : UIViewController

@property (nonatomic, strong) UIView *containView ;
@property (nonatomic, strong) UIView *sliderView ;
@property (nonatomic, assign) BOOL SliderIsHidden ;

- (instancetype)init ;
- (void)setUpContainView:(UIView *)containView ;
- (void)showSliderView ;
- (void)hideSliderView ;

@end
