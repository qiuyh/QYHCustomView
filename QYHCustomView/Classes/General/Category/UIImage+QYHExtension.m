//
//  UIImage+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "UIImage+QYHExtension.h"
//#import "UIView+WebCache.h"
//#import "UIImage+GIF.h"

@implementation UIImage (QYHExtension)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark image scale utility
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < SCREEN_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = SCREEN_WIDTH;
        btWidth = sourceImage.size.width * (SCREEN_WIDTH / sourceImage.size.height);
    } else {
        btWidth = SCREEN_WIDTH;
        btHeight = sourceImage.size.height * (SCREEN_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [UIImage imageCompressFitSizeScale:sourceImage targetSize:targetSize];
}

+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)compressImageToByte:(NSUInteger)maxLength {

    CGFloat compression = 1;
    NSLog(@"开始");
    NSData *data = UIImageJPEGRepresentation(self, compression);

    CGFloat compression1 = maxLength * 1.815 / data.length;

    UIImage *image2 = [self imageWithImage:self scaledToSize:CGSizeMake(self.size.width * compression1, self.size.height * compression1)];
//    NSData *data1 = UIImageJPEGRepresentation(image2, compression);
//    NSLog(@"length1:原图大小:%ld 目标大小:%ld 压缩后大小:%ld 压缩比:%f",data.length,maxLength,data1.length,compression1);
    return image2;
//    if (data.length < maxLength) return self;
//
//    CGFloat max = 1;
//    CGFloat min = 0;
//    for (int i = 0; i < 6; ++i) {
//        compression = (max + min) / 2;
//        data = UIImageJPEGRepresentation(self, compression);
//        if (data.length < maxLength * 0.9) {
//            min = compression;
//        } else if (data.length > maxLength) {
//            max = compression;
//        } else {
//            break;
//        }
//    }
//    UIImage *resultImage = [UIImage imageWithData:data];
//    NSLog(@"length2:%ld",data.length);
//    if (data.length < maxLength) return resultImage;
//
//    // Compress by size
//    NSUInteger lastDataLength = 0;
//    while (data.length > maxLength && data.length != lastDataLength) {
//        lastDataLength = data.length;
//        CGFloat ratio = (CGFloat)maxLength / data.length;
//        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
//        UIGraphicsBeginImageContext(size);
//        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        resultImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        data = UIImageJPEGRepresentation(resultImage, compression);
//    }
//    NSLog(@"length3:%ld",data.length);

}
- (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)fixOrientation {

    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (NSData *)compressWithMaxLength:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    //    NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //        NSLog(@"Compression = %.1f", compression);
        //        NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //    NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

+ (UIImage*)maskImage:(UIImage*)originImage toPath:(UIBezierPath*)path{
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    [path addClip];
    [originImage drawAtPoint:CGPointZero];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage{
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace,
                                                          kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    if (offscreenContext != NULL)
    {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return retVal;
}


+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
        imageWithAlpha = [[self class] CopyImageAndAddAlphaChannel:sourceImage];
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    if (sourceImage != imageWithAlpha) {
        CGImageRelease(imageWithAlpha);
    }
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return retImage;
    
}


//按照UIImageOrientation的定义，利用矩阵自定义实现对应的变换；
+ (UIImage *)transformImage:(UIImage *)aImage
                   rotation:(UIImageOrientation)orientation{
    
    CGImageRef imgRef = aImage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orientation)
    {
        case UIImageOrientationUp:
            
            transform = CGAffineTransformIdentity;
            
            break;
            
        case UIImageOrientationUpMirrored:
            
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(width, height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
        case UIImageOrientationDownMirrored:
            
            transform = CGAffineTransformMakeTranslation(0.0, height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
        case UIImageOrientationLeft:
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
        case UIImageOrientationLeftMirrored:
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI_2);
            
            break;
            
        case UIImageOrientationRightMirrored:
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, M_PI_2);
            
            break;
            
        default:
            
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}



//+ (void)fullResolutionImageFromALAsset:(NSURL *)assetUrl result:(void(^)(UIImage *image))result{
//    NSLog(@">>> assetUrl :%@",assetUrl);
//     __block UIImage *image;
//    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
//
//    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        [lib assetForURL:assetUrl resultBlock:^(ALAsset *asset)
//         {
//             //在这里使用asset来获取图片
//             ALAssetRepresentation *assetRep = [asset defaultRepresentation];
//             CGImageRef imgRef = [assetRep fullResolutionImage];
//             image = [UIImage imageWithCGImage:imgRef
//                                         scale:assetRep.scale
//                                   orientation:(UIImageOrientation)assetRep.orientation];
//
//             if (result) {
//                 result(image);
//             }
//         }
//            failureBlock:^(NSError *error)
//         {
//
//
//         }
//         ];
//
////        dispatch_async(dispatch_get_main_queue(), ^{
////
////
////        });
////    });
//
//}


//+ (void)fullResolutionImageFromALAsset:(NSURL *)assetUrl fullImage:(BOOL)isFullImage result:(void(^)(UIImage *image))result{
//    
//    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
//    
//    [lib assetForURL:assetUrl resultBlock:^(ALAsset *asset){
//         if (asset) {
//             
//             result([self assetImage:asset fullImage:isFullImage]);
//             
//         }else{
//             // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
//             [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
//                                usingBlock:^(ALAssetsGroup *group, BOOL *stop){
//                  [group enumerateAssetsWithOptions:NSEnumerationReverse
//                                         usingBlock:^(ALAsset *rs, NSUInteger index, BOOL *stop) {
//                                             
//                                             if([[rs valueForProperty:ALAssetPropertyAssetURL] isEqual:assetUrl]){
//                                                 result([self assetImage:asset fullImage:isFullImage]);
//                                                 *stop = YES;
//                                             }
//                                         }];
//              }failureBlock:^(NSError *error){
//                  result([self assetImage:nil fullImage:isFullImage]);
//              }];
//         }
//        
//    }failureBlock:^(NSError *error){
//         result([self assetImage:nil fullImage:isFullImage]);
//     }];
//}
//
//+ (UIImage *)assetImage:(ALAsset *)asset fullImage:(BOOL)isFullImage{
//    
//    if (!asset) {
//        return nil;
//    }
//    
//    UIImage *image;
//    NSString *string;
//    if (isFullImage) {
//        NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
//        UIImageOrientation orientation = UIImageOrientationUp;
//        if (orientationValue != nil) {
//            orientation = [orientationValue intValue];
//        }
//        
//        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//        //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
//        
//        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,[[asset defaultRepresentation] dimensions].width, [[asset defaultRepresentation] dimensions].height];
//        
//    } else {
//        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//        
//        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,image.size.width,image.size.height];
//    }
//    
//    NSLog(@"fullResolutionImageFromALAsset==%@",string);
//
//    return image;
//}


+ (UIImage *)fixOrientation:(UIImage *)aImage{
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) { case UIImageOrientationDown: case UIImageOrientationDownMirrored: transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height); transform = CGAffineTransformRotate(transform, M_PI); break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) { case UIImageOrientationUpMirrored: case UIImageOrientationDownMirrored: transform = CGAffineTransformTranslate(transform, aImage.size.width, 0); transform = CGAffineTransformScale(transform, -1, 1); break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage)); CGContextConcatCTM(ctx, transform); switch (aImage.imageOrientation) { case UIImageOrientationLeft: case UIImageOrientationLeftMirrored: case UIImageOrientationRight: case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx); UIImage *img = [UIImage imageWithCGImage:cgimg]; CGContextRelease(ctx); CGImageRelease(cgimg); return img;
}

///**
// *加载动态图片
// */
//- (void)sd_gifSetImageWithURL:(nullable NSURL *)url
//             placeholderImage:(nullable UIImage *)placeholder{
//    @weakify(self);
//    [self sd_internalSetImageWithURL:url placeholderImage:placeholder options:0 operationKey:nil setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
//        @strongify(self);
//        if (image && [image isGIF]) {
//            [self setImage:[UIImage sd_animatedGIFWithData:imageData]];
//        } else if(image){
//            [self setImage:image];
//        }
//    } progress:nil completed:nil];
//}


+ (UIImage *)imageWithView:(UIView *)view{
    UIImage *image = nil;
          
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        
        CGFloat width = savedFrame.size.width > scrollView.contentSize.width ? savedFrame.size.width : scrollView.contentSize.width;
        CGFloat height = savedFrame.size.height > scrollView.contentSize.height ? savedFrame.size.height : scrollView.contentSize.height;
        
        scrollView.frame = CGRectMake(0, 0, width, height);
        //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
        //如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
        UIGraphicsBeginImageContextWithOptions(scrollView.frame.size, NO, 0);
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        //还原
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
        
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
    //如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    //还原

    UIGraphicsEndImageContext();
    
    return image;
}

@end
