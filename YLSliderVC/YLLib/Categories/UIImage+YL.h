//
//  UIImage+Art.h
//  DesignBox
//
//  Created by NaiveVDisk on 8/10/15.
//  Copyright (c) 2015 GK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (YL)

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)ratioImageWithScaleSize:(CGSize)aScaleSize;

//- (UIImage *)addWatermarkImage:(UIImage*)aImage AndText:(NSString*)aText;

/** 图片旋转后得到新图片*/
- (UIImage *)imageRotatedByDegrees:(CGFloat)aDegrees;

/**
 *  图片旋转得到图片数组
 *
 *  @param aDegrees 旋转总角度
 *  @param aNumber  图片张数
 */
- (NSArray *)imagesRotatedByTotalDegrees:(CGFloat)aDegrees numberOfImages:(NSUInteger)aNumber;

/** 将一张横图平均裁剪返回裁剪后的图片数组*/
- (NSArray *)imagesByCroppingWidthWithCount:(NSInteger)count;

@end
