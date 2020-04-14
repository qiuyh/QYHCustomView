//
//  UIImage+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QYHExtension)
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

/**
 图像缩放最大尺寸

 @param sourceImage 源图片
 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

/**
 图像源图像的缩放和裁剪

 @param sourceImage 源图片
 @param size 图片的大小
 */
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;

- (UIImage *)compressImageToByte:(NSUInteger)maxLength;

- (UIImage *)fixOrientation;

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;

+ (UIImage*)maskImage:(UIImage *)image
             withMask:(UIImage *)maskImage;

//按照UIImageOrientation的定义，利用矩阵自定义实现对应的变换；
+ (UIImage *)transformImage:(UIImage *)aImage
                   rotation:(UIImageOrientation)orientation;


//+ (void)fullResolutionImageFromALAsset:(NSURL *)assetUrl result:(void(^)(UIImage *image))result;
//
//+ (void)fullResolutionImageFromALAsset:(NSURL *)assetUrl fullImage:(BOOL)isFullImage result:(void(^)(UIImage *image))result;

//旋转照片，防止web前段和安卓上看着是旋转90°的；
+ (UIImage *)fixOrientation:(UIImage *)aImage;
/**
 *加载动态图片
 */
//- (void)sd_gifSetImageWithURL:(nullable NSURL *)url
//             placeholderImage:(nullable UIImage *)placeholder;

//view截图转image
+ (UIImage *)imageWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
