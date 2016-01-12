//
//  Header.h
//  YLSliderVC
//
//  Created by NaiveVDisk on 16/1/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#ifndef YLUIDefine_h
#define YLUIDefine_h


#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define UI_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

#endif
