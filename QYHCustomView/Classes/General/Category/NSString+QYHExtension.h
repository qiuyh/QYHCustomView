//
//  NSString+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QYHExtension)
/**
 小写MD5加密
 */
- (NSString *)MD5toLowercase;
/**
大写MD5加密
*/
- (NSString *)MD5ToAcapital;
/**
 *  获取字符串的尺寸
 *
 *  @param textContent 内容
 *  @param textFont    字体尺寸
 *  @param maxSize     最大尺寸
 *
 *  @return 计算后的尺寸size
 */
+ (CGSize)getContentSize:(NSString *)textContent
              fontOfSize:(CGFloat)textFont
             maxSizeMake:(CGSize)maxSize;
/**
 判断字符串的小数位数，大于2位的取2位，
 */
- (NSString *)getPrecisionString:(NSString *)assemblyContentString;

/**
 *  doc沙盒路径
 */
+ (NSString *)documentPath;


/**
 *  cache沙盒路径
 */
+ (NSString *)cachePath;

/**
 *  获取App版本号
 */
+ (NSString *)getAppVer;

/**
 *  去除字符串回车
 */
- (NSString *)trim;

/**
 *  去除字符串所有空格
 */
- (NSString*)removeAllSpace;
/**
*  去除字符串空格、<、>
*/
- (NSString *)stringByRemovingHTML;
/**
 * 获取ip地址
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
/**
 * base64加码
 */
+ (NSString *)base64StringFromText:(NSString *)text;
/**
* base64解码
*/
+ (NSString *)textFromBase64String:(NSString *)base64;
/**
 *unicode 转 字符串
 */
- (NSString *)replaceUnicode:(NSString *)unicodeStr;

/**
*  旧版本
*/
- (BOOL) isOlderVersionThan:(NSString*)otherVersion;
/**
*  新版本
*/
- (BOOL) isNewerVersionThan:(NSString*)otherVersion;
/**
*  限制表情输入
*/
- (BOOL)stringContainsEmoji;
/**
 *身份证号
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
/**
 * 检测邮箱有效性
 **/
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 * 检测手机号码有效性
 **/
+ (BOOL)isValidateMobile:(NSString *)mobileNum;
/**
* 检测密码有效性
*/
+ (BOOL)isValidPassword:(NSString *)password;

/**
 *IP地址验证
 */
- (BOOL)isValidateIP;
/**
 *为空字符串
 */
- (BOOL)isEmptyStr;

///字符串数组连续相同
+ (BOOL)serialNumber:(NSString *)password;
///字符串数组递增
+ (BOOL)increasing:(NSString *)password;
///字符串数组递减
+ (BOOL)diminishing:(NSString *)password;

/******************************************************************/

// 16进制转10进制
+ (NSNumber *)numberHexString:(NSString *)aHexString;

//10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

//16进制转为2进制
+ (NSString *)getBinaryByHex:(NSString *)hex;

//2进制转16进制
+ (NSString *)getHexByBinary:(NSString *)binary;

//16进制转data
+ (NSData *)convertHexStrToData:(NSString *)str;

//data转16进制
+ (NSString *)hexStringWithData:(NSData *)data;

//金钱每三位加一个逗号
+ (NSString *)countNumAndChangeformat:(NSString *)num;

//获取某年某月的天数
+ (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month dateTypeIndex:(NSInteger)dateTypeIndex;

//前一/后一日期
+ (NSString *)getLastOneWithDateString:(NSString*)dateStr isLastClicked:(BOOL)isLastClicked clickedDateTypeIndex:(NSInteger)clickedDateTypeIndex;

@end

NS_ASSUME_NONNULL_END
