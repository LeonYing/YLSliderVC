//
//  YLSliderVcInfo.h
//  YLSliderVC
//
//  Created by NaiveVDisk on 16/1/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YLSliderSwitchRootVcType){
    YLSliderSwitchRootVcTypeReplace = 0,
    YLSliderSwitchRootVcTypepush
};


@interface YLSliderVcInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) Class viewControllerClass;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, readonly) BOOL navigationVcIsActivated;
@property (nonatomic, assign) YLSliderSwitchRootVcType switchRootVcType;


@end
