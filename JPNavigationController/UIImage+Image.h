//
//  UIImage+Image.h
//  
//
//  Created by yz on 15/7/6.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)miniImageWithColor:(UIColor *)color;

// 返回一张可以拉伸的图片
+ (instancetype)resizableImage:(NSString *)name;

/** 返回圆形图片 */
+(instancetype)circleImageWithName:(NSString *)imageName;
-(instancetype)circleImage;

/** 返回一张没有经过渲染的图片 */
+(UIImage *)originalImageWithimageNamed:(NSString *)name;
@end
