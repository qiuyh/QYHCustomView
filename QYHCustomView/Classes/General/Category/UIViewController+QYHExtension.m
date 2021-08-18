//
//  UIViewController+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "UIViewController+QYHExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (QYHExtension)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        Class class=[self class];
        
        //iOS 13 present 半屏修改
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(qyh_presentViewController:animated:completion:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)qyh_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        
        [self qyh_presentViewController:viewControllerToPresent animated:flag completion:completion];
    });
}

@end
