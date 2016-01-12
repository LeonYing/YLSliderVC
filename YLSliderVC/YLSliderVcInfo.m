//
//  YLSliderVcInfo.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 16/1/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YLSliderVcInfo.h"

@implementation YLSliderVcInfo


- (UINavigationController *)navigationController{
    if (_navigationController == nil) {
        YLViewController * vc = [[self.viewControllerClass alloc] init];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = self.title;
        _navigationVcIsActivated = YES;
    }
    return _navigationController;
}

@end
