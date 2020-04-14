//
//  NSDictionary+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "NSDictionary+QYHExtension.h"

@implementation NSDictionary (QYHExtension)

+ (NSDictionary *)getParmWithURL:(NSString *)URLString{
    NSMutableDictionary * pramDic= [[NSMutableDictionary alloc] init];
    if ([URLString containsString:@"?"]) {
        NSArray * urlAndPram = [URLString componentsSeparatedByString:@"?"];
        NSArray * keyAndObjects = [urlAndPram[1] componentsSeparatedByString:@"&"];
        
        for (NSString *keyAndObject in keyAndObjects) {
            NSArray* tmpArray = [keyAndObject componentsSeparatedByString:@"="];
            [pramDic setObject:tmpArray[1] forKey:tmpArray[0]];
        }
    }
    return pramDic;
}

+ (NSDictionary*)initWithJsonString:(NSString*)json{
    NSData* infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (infoData) {
        NSDictionary* info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
        return info;

    }else{
        return [NSDictionary dictionary];
    }
}

- (NSString*)jsonString{
    NSData* infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

@end
