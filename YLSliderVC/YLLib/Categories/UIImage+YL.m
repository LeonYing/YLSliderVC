//
//  UIImage+Art.m
//  DesignBox
//
//  Created by NaiveVDisk on 8/10/15.
//  Copyright (c) 2015 GK. All rights reserved.
//

#import "UIImage+YL.h"

@implementation UIImage (YL)

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    // Create a new size image context
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Create a filled rect
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddRect(context, CGRectMake(0.0f, 0.0f, size.width, size.height));
    CGContextFillPath(context);
    
    // Recturn new image
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)ratioImageWithScaleSize:(CGSize)aScaleSize
{
    float ratio = self.size.width / self.size.height;
    if (aScaleSize.height >= aScaleSize.width/ratio)
    {
        UIGraphicsBeginImageContext(CGSizeMake(aScaleSize.width, aScaleSize.height));
        [self drawInRect:CGRectMake(0, (aScaleSize.height-aScaleSize.width/ratio)/2, aScaleSize.width, aScaleSize.width/ratio)];
    }
    else
    {
        UIGraphicsBeginImageContext(CGSizeMake(aScaleSize.width, aScaleSize.height));
        [self drawInRect:CGRectMake((aScaleSize.width-aScaleSize.height*ratio)/2, 0, aScaleSize.height*ratio, aScaleSize.height)];
    }
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//- (UIImage *)addWatermarkImage:(UIImage*)aImage AndText:(NSString*)aText{
//    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Seting_WaterMark"]) {
//        return self;
//    };
//    
//    if (aImage == nil) {
//        aImage = [UIImage imageNamed:@"image_Watermark"];
//    }
//    
//    if (aText == nil) {
//        aText = @"设计宝";
//    }
//    
//    aText = [NSString stringWithFormat:@"@%@",aText];
//    
//    CGFloat scal = self.size.width / 320;
//    CGFloat dx = 10 * scal;
//    CGFloat xjg = 3 * scal;
//    CGFloat yjg = 3 * scal;
//    
//    UIFont* font = [UIFont systemFontOfSize:dx];
//    NSDictionary *dic = @{NSFontAttributeName : font , NSForegroundColorAttributeName : [UIColor whiteColor]};
//    
//    CGSize textSize = [aText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    CGSize imageSize = CGSizeMake(dx * 1.5, dx * 1.5);
//    
//    CGRect textRect = CGRectMake(self.size.width - textSize.width - xjg * 2, self.size.height - textSize.height - yjg , textSize.width, textSize.height);
//    
//    CGRect imageRect = CGRectMake(textRect.origin.x - imageSize.width - xjg, self.size.height - imageSize.height - yjg, imageSize.width, imageSize.height);
//    
//    UIGraphicsBeginImageContextWithOptions(self.size , NO, 0.0); // 0.0 for scale means
//    //原图
//    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
//    //水印
//    [aImage drawInRect:imageRect];
//    [aText drawInRect:textRect withAttributes:dic];
//    
//    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newPic;
//}

- (UIImage *)imageRotatedByDegrees:(CGFloat)aDegrees
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, self.size.width * scale * 0.5, self.size.height * scale * 0.5);
    CGContextRotateCTM(bitmap, aDegrees);
    CGContextTranslateCTM(bitmap, - self.size.width * scale * 0.5, - self.size.height * scale * 0.5);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, self.size.width * scale, self.size.height * scale), self.CGImage);
    UIImage *bitmapImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImage *outputImage = [UIImage imageWithCGImage:bitmapImage.CGImage scale:scale orientation:UIImageOrientationUp];
    return outputImage;
}

- (NSArray *)imagesRotatedByTotalDegrees:(CGFloat)aDegrees numberOfImages:(NSUInteger)aNumber
{
    if (!aNumber) {
        aNumber = 1;
    }
    CGFloat degrees = aDegrees / aNumber;
    NSMutableArray *imageArrayM = [NSMutableArray arrayWithCapacity:aNumber];
    for (int i = 0; i < aNumber; ++i) {
        UIImage *image = [self imageRotatedByDegrees:(degrees *(i + 1))];
        [imageArrayM addObject:image];
    }
    return imageArrayM.copy;
}

- (NSArray *)imagesByCroppingWidthWithCount:(NSInteger)count
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableArray *imageArrayM = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i) {
        CGFloat aH = self.size.height * scale;
        CGFloat aW = self.size.width / count * scale;
        CGFloat aY = 0;
        CGFloat aX = aW * i;
        CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(aX, aY, aW, aH));
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        UIImage *outputImage = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
        [imageArrayM addObject:outputImage];
        CGImageRelease(imageRef);
    }
    
    return imageArrayM.copy;
}

@end
