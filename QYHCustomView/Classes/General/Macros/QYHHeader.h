//
//  QYHHeader.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/11.
//  Copyright © 2020 SAJ. All rights reserved.
//

#ifndef QYHHeader_h
#define QYHHeader_h

//getCurrentTime
#define getCurrentTime ({\
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];\
[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];\
NSDate *datenow = [NSDate date];\
NSString *currentTimeString = [formatter stringFromDate:datenow];\
currentTimeString;\
})

//NSLog
#ifndef __OPTIMIZE__
# define NSLog(...) printf("%s ---- %s\n", [getCurrentTime UTF8String], [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
# define NSLog(...) {}
#endif

//weakify && strongify
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//systemVersion
#define systemVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define iOS10 (systemVersion >= 10.0)
#define iOS13 (systemVersion >= 13.0)

//判断是iPhone/iPad
#define iPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define QYHKeyWindow ({\
UIWindow* window = nil;\
if (@available(iOS 13.0, *)){\
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){\
        if (windowScene.activationState == UISceneActivationStateForegroundActive){\
            window = windowScene.windows.firstObject;\
            break;\
        }\
    }\
    if (!window){\
        window = [UIApplication sharedApplication].keyWindow;\
    }\
}else{\
    window = [UIApplication sharedApplication].keyWindow;\
}\
window;\
})

//Navigation && Tabbar && StateBar
#define SafeAreaBottomHeight ({\
    CGFloat tmp = 0;\
    if (@available(iOS 11.0, *)) {\
        UIWindow *window = [UIApplication.sharedApplication.windows firstObject];\
        tmp = window.safeAreaInsets.bottom;\
    }\
    tmp;\
})

#define iPhoneX ({\
    BOOL tmp = SafeAreaBottomHeight;\
    tmp;\
})

// 非刘海屏，若存在状态条隐藏显示的切换，会有window.safeAreaInsets.top返回为0的异常情况
#define StatusBarHeight ({\
    CGFloat tmp = 20;\
    if (@available(iOS 11.0, *)) {\
        if (iPhoneX) {\
            UIWindow *window = [UIApplication.sharedApplication.windows firstObject];\
            tmp = window.safeAreaInsets.top;\
        }\
    }\
    tmp;\
})

#define SafeAreaTopHeight (StatusBarHeight + 44)
#define SafeAreaStateTopHeight (StatusBarHeight-20)
#define NavigationHeight SafeAreaTopHeight
#define TabbarHeight  (SafeAreaBottomHeight+49)

//mainScreen width && height
#define SCREEN_WIDTH (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

//ScreenSize
#define get4SScreenSize CGSizeMake(320, 480)
#define get5SScreenSize CGSizeMake(320, 568)
#define get6SScreenSize CGSizeMake(375, 667)
#define get6PlusScreenSize CGSizeMake(414, 736)
#define getXSScreenSize CGSizeMake(375, 812)
#define getXSMaxScreenSize CGSizeMake(414, 896)
#define getXRScreenSize CGSizeMake(414, 896)
#define get11ScreenSize CGSizeMake(414, 896)
#define get11ProScreenSize CGSizeMake(375, 812)
#define get11ProMaxScreenSize CGSizeMake(414, 896)

#define Proportion(width2, width1) ((width2/width1>1.8)?1.8:(width2/width1))

#define AdaptionHeightWith5(h) ((int)roundf(h*Proportion(SCREEN_HEIGHT, get5SScreenSize.height))))
#define AdaptionWidthWith5(w) ((int)roundf(w*Proportion(SCREEN_WIDTH, get5SScreenSize.width)))
#define AdaptionFont5(fontSize) AdaptionWidthWith5(fontSize)

#define AdaptionHeightWith6(h) ((int)roundf(h*Proportion(SCREEN_HEIGHT, get6SScreenSize.height)))
#define AdaptionWidthWith6(w) ((int)roundf(w*Proportion(SCREEN_WIDTH, get6SScreenSize.width)))
#define AdaptionFont6(fontSize) AdaptionWidthWith6(fontSize)

#define AdaptionHeightWith6p(h) ((int)roundf(h*Proportion(SCREEN_HEIGHT, get6PlusScreenSize.height)))
#define AdaptionWidthWith6p(w) ((int)roundf(w*Proportion(SCREEN_WIDTH, get6PlusScreenSize.width)))
#define AdaptionFont6p(fontSize) AdaptionWidthWith6p(fontSize)

//BundleIdentifier
#define BundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

/* 判定字符串是否为空 */
#define isEmptyString(__POINTER) (__POINTER == nil || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"] || [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"])?YES:NO

//sleep
#define sleep(s)  [NSThread sleepForTimeInterval:s];

//color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//font
#define BoldSystemFont(size)    [UIFont boldSystemFontOfSize:size]
#define systemFont(size)        [UIFont systemFontOfSize:size]
#define fontWithName(name,size) [UIFont fontWithName:name size:size]
#endif /* QYHHeader_h */
