//
//  NSMutableAttributedString+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "NSMutableAttributedString+QYHExtension.h"

@implementation NSMutableAttributedString (QYHExtension)

+ (NSMutableAttributedString*)attributedString:(NSString *)allString
                                   bigFontName:(NSString *)bigFontName
                                   bigFontSize:(CGFloat)bigFontSize
                                      bigColor:(UIColor *)bigColor
                                   smallString:(nullable NSString *)smallString
                                 smallFontName:(nullable NSString *)smallFontName
                                 smallFontSize:(CGFloat)smallFontSize
                                    smallColor:(nullable UIColor *)smallColor{
    
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont fontWithName:bigFontName size:bigFontSize],
        NSForegroundColorAttributeName:bigColor};
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allString attributes:attributes];
    
    if (smallString && [allString containsString:smallString]){
        
        NSMutableDictionary *attributesDiM = [NSMutableDictionary dictionary];
        if (smallFontName && smallFontSize) {
            [attributesDiM setObject:[UIFont fontWithName:smallFontName size:smallFontSize] forKey:NSFontAttributeName];
        }
        
        if (smallColor) {
            [attributesDiM setObject:smallColor forKey:NSForegroundColorAttributeName];
        }
        
        NSRange range = [allString rangeOfString:smallString];
        [attrString addAttributes:attributesDiM range:range];
    }
    
    return attrString;
}

@end
