//
//  CALayer+QYHXibBorderColor.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "CALayer+QYHXibBorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (QYHXibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

@end
