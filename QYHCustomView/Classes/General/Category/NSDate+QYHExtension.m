//
//  NSDate+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "NSDate+QYHExtension.h"
#import <UIKit/UIKit.h>

#define DATE_COMPONENTS (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define D_MINUTE 60
#define D_HOUR   3600
#define D_DAY    86400
#define D_WEEK   604800
#define D_YEAR   31556926

@interface NSDate ()
/*
 *  清空时分秒，保留年月日
 */
@property (nonatomic,strong,readonly) NSDate *ymdDate;
@end

@implementation NSDate (QYHExtension)

/*
 *  时间戳
 */
-(NSString *)timestamp{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    return [timeString copy];
}
/*
 *  时间成分
 */
-(NSDateComponents *)components{
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //定义成分
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}
/*
 *  是否是今年
 */
-(BOOL)isThisYear{
    //取出给定时间的components
    NSDateComponents *dateComponents=self.components;
    
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].components;
    
    //直接对比年成分是否一致即可
    BOOL res = dateComponents.year==nowComponents.year;
    
    return res;
}

- (BOOL)isThisMonth{
    //取出给定时间的components
    NSDateComponents *dateComponents=self.components;
    
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].components;
    
    //直接对比月成分是否一致即可
    BOOL res = dateComponents.month==nowComponents.month;
    
    return res;
}

/*
 *  是否是今天
 */
-(BOOL)isToday{
    //差值为0天
    return [self calWithValue:0];
}

/*
 *  是否是本周
 */
-(BOOL)isToweek{
    return ![NSDate daysOffsetBetweenStartDate:self endDate:[NSDate date] with:NSCalendarUnitWeekday].weekday;
}

/*
 *  是否是昨天
 */
-(BOOL)isYesToday{
    //差值为1天
    return [self calWithValue:1];
}


-(BOOL)calWithValue:(NSInteger)value{
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.components;
    
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    
    return res;
}

/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)ymdDate{
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    
    return date;
}


+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    return [dateComps date];
}

/**
 *  获取年月日(NSString)
 */
+ (NSString *)stringYearMonthDay{
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
//    NSInteger hour = [dateComponent hour];
//    NSInteger minute = [dateComponent minute];
//    NSInteger second = [dateComponent second];
    NSString * currentDate = [NSString stringWithFormat:@"%ld%.2ld%.2ld",year,month,day];
    
    return currentDate;
    
}
/**
 *  获取时分秒(NSString)
 */
+ (NSString *)stringTime{
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
//    NSInteger year = [dateComponent year];
//    NSInteger month = [dateComponent month];
//    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSString * currentDate = [NSString stringWithFormat:@"%.2ld%.2ld%.2ld",hour,minute,second];
    
    return currentDate;
}


//获取当前年月日时分秒
+ (NSString *)stringYearMonthDayHourMinute{
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSString * currentDate = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",year,month,day,hour,minute,second];
    
    return currentDate;
}

//获取当前年月日时分秒毫秒
+ (NSString *)stringYearMonthDayHourMinuteNanosecond{
    //获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

+ (NSDateComponents*)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate with:(NSCalendarUnit)unitFlags{
    NSCalendar* chineseClendar = [NSCalendar currentCalendar];
    //    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    return cps;
}


+ (NSDate *)dateWithHour:(int)hour
                  minute:(int)minute{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

#pragma mark - 时间单元组件
- (NSInteger)year{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];
    return [dateComponents year];
}

- (NSInteger)month
{
    NSDateComponents *dateComponents =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];;
    return [dateComponents month];
}

- (NSInteger)day{
    NSDateComponents *dateComponents =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];;
    return [dateComponents day];
}

- (NSInteger)hour{
    NSDateComponents *dateComponents =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];;
    return [dateComponents hour];
}

- (NSInteger)minute{
    NSDateComponents *dateComponents =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];;
    return [dateComponents minute];
}

- (NSInteger)second{
    NSDateComponents *dateComponents =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];;
    return [dateComponents second];
}

- (NSString *)weekday{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)fromDate:self];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *week = @"";
    switch (weekday) {
        case 1:
            week = @"星期日";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
            
        default:
            break;
    }
    
    return week;
}
/**
 *  (上午)(am)小时分钟的时间字符串
 */
- (NSString *)timeHourMinute{
    
    return [self timeHourMinuteWithPrefix:NO suffix:NO];
}

- (NSString *)timeHourMinuteWithPrefix{
    return [self timeHourMinuteWithPrefix:YES suffix:NO];
}

- (NSString *)timeHourMinuteWithSuffix{
    return [self timeHourMinuteWithPrefix:NO suffix:YES];
}

- (NSString *)timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    if (enablePrefix)
    {
        ;
        timeStr = [NSString stringWithFormat:@"%@ %@",([self hour] > 12 ? @"下午" : @"上午"),([self hour] > 12 ? [NSString stringWithFormat:@"%02d:%@",[[[timeStr componentsSeparatedByString:@":"] firstObject] intValue] -12,[[timeStr componentsSeparatedByString:@":"] lastObject]] : timeStr)];
    }
    if (enableSuffix)
    {
        timeStr = [NSString stringWithFormat:@"%@ %@",([self hour] > 12 ? @"pm" : @"am"),([self hour] > 12 ? [NSString stringWithFormat:@"%02d:%@",[[[timeStr componentsSeparatedByString:@":"] firstObject] intValue] -12,[[timeStr componentsSeparatedByString:@":"] lastObject]] : timeStr)];
    }
    return timeStr;
}


/**
 *   时间戳字符串
 */
- (NSString *)stringTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSString *)stringMonthDay{
    return [NSDate dateMonthDayWithDate:self];
}

- (NSString *)stringYearMonthDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSString *)stringYearMonthDayHourMinuteSecond{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:self];
    return str;
    
}

- (NSString *)stringYearMonthDayCompareToday{
    NSString *str;
    NSInteger chaDay = [self daysBetweenCurrentDateAndDate];
    if (chaDay == 0) {
        str = @"今天";
    }else if (chaDay == 1){
        str = @"明天";
    }else if (chaDay == -1){
        str = @"昨天";
    }else{
        str = [self stringYearMonthDay];
    }
    
    return str;
}

+ (NSString *)stringLoacalDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [format  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *dateStr = [format stringFromDate:localeDate];
    
    return dateStr;
}

+ (NSString *)dateMonthDayWithDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM.dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}


#pragma mark - Date formate

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString
{
    return @"yyyy-MM-dd HH:mm";
}

+ (NSString *)timestampFormatStringSubSeconds{
    return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSString *)timestampFormatStringMilliseconds{
    return @"yyyyMMddHHmmssSSS";
}

#pragma mark - Date adjust
- (NSDate *) dateByAddingDays: (NSInteger) dDays{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays{
    return [self dateByAddingDays: (dDays * -1)];
}

#pragma mark - Relative Dates
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}


+ (NSDate *) dateStandardFormatTimeZeroWithDate: (NSDate *) aDate{
    NSString *str = [[aDate stringYearMonthDay]stringByAppendingString:@" 00:00:00"];
    NSDate *date = [NSDate dateFromString:str];
    return date;
}

- (NSInteger) daysBetweenCurrentDateAndDate{
    //只取年月日比较
    NSDate *dateSelf = [NSDate dateStandardFormatTimeZeroWithDate:self];
    NSTimeInterval timeInterval = [dateSelf timeIntervalSince1970];
    NSDate *dateNow = [NSDate dateStandardFormatTimeZeroWithDate:[NSDate date]];
    NSTimeInterval timeIntervalNow = [dateNow timeIntervalSince1970];
    
    NSTimeInterval cha = timeInterval - timeIntervalNow;
    CGFloat chaDay = cha / 86400.0;
    NSInteger day = chaDay * 1;
    return day;
}

#pragma mark - Date and string convert
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}


+ (NSString *)string {
    return [NSDate stringWithFormat:[NSDate dbFormatString]];
}

+ (NSString *)stringCutSeconds{
    return [NSDate stringWithFormat:[NSDate timestampFormatStringSubSeconds]];
}

+ (NSString *)stringCutMilliseconds{
    return [NSDate stringWithFormat:[NSDate timestampFormatStringMilliseconds]];
}

+ (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:[NSDate date]];
    return timestamp_str;
}

+ (NSString *)dbFormatString {
    return [NSDate timestampFormatStringSubSeconds];
}

#pragma mark - ==================== 补充 ==========================
//获取当前时间的longlong字符串
+ (NSString *)getLongLongStrWithNow{
    long long myDatelld = [[NSDate date] timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%lld",myDatelld*1000];
    return timeSp;
}

//秒字符串 转成 时间
+ (NSDate *)getDateWithLongLongStr:(NSString *)longLongStr{
    NSDate *myDate = [[NSDate alloc]initWithTimeIntervalSince1970:[longLongStr longLongValue]/1000.0];
    
    return myDate;
}

//时间 转成 秒字符串
- (NSString *)getLongLongStrWith{
    long long myDatelld = [self timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%lld",myDatelld*1000];
    return timeSp;
}

//秒字符串 转 时间字符串
- (NSString *)getDateStrWithLongLongStrr:(NSString *)longLongStr{
    NSDate *myDate = [[NSDate alloc]initWithTimeIntervalSince1970:[longLongStr longLongValue]/1000.0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:myDate];
    
    return locationString;
}

//时间字符串 转 秒字符串
- (NSString *)getLongLongStrWithDateStr:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *senddate=[dateFormatter dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[senddate timeIntervalSince1970]*1000];
    return timeSp;
}

//时区转换
- (NSDate *)getNowDateFromatAnDate{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    
    return destinationDateNow;
}


+ (NSString *)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    //假设倒计时为24小时
    int daojishi = 3 * 24 * 60 ;
    
    //按照日期格式创建日期格式句柄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    //将日期字符串转换成Date类型
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    //将日期转换成时间戳
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    
    
    NSString *str ;
    
    
    int daojishicha = daojishi - (value/60) ;
    
    int fen = (int)daojishicha %60;
    
    int shi = (int)daojishicha /60 %24 ;
    
    int tian = (int)daojishicha /60 /24 ;
    
    
    if (daojishicha > 0)
    {
        str = [NSString stringWithFormat:@"剩%d天%d小时%d分订单失效",tian,shi,fen];
    }
    else
    {
        str = [NSString stringWithFormat:@"已失效"];
    }
    
    //返回string类型的总时长
    return str;
}


//通过剩余秒数返回剩余天时分
+ (NSString *)byMillisecondToDayHour:(NSString *)millisecondTime{
    int shengyu = [millisecondTime intValue]/1000/60;
    

    int fen = ([millisecondTime intValue]/60000 ) % 60;
    
    int shi = ([millisecondTime intValue]/3600000 ) % 24 ;
    
    int tian = ([millisecondTime intValue]/3600000) / 24 ;
    
    NSString *str ;
    
    if (shengyu > 0)
    {
        str = [NSString stringWithFormat:@"%d天%d小时%d分",tian,shi,fen];
    }
    else
    {
        str = [NSString stringWithFormat:@""];
    }

    return str ;
    
    
}

//获取当前时间
+ (NSDate *)currentTimeNSDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
   
    return date;
}

//获取当前时间
+ (NSString *)currentTimeYMD{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];

    return DateTime ;

}



//获取当前的时间时分秒
+ (NSString*)getCurrentTimeHMS{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString = %@",currentTimeString);
    return currentTimeString;
    
}

//获取某天时间的后一天 时间格式为：1999-01-11
+ (NSString *)oneDayLater:(NSString *)time{
        NSString *dateString = time;
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateFormat:@"yyyy-MM-dd"];
    
        NSDate *date = [formatter dateFromString:dateString];
    
        NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    
        NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    
       NSLog(@"yesterday %@    tomorrow %@", [formatter stringFromDate:yesterday], [formatter stringFromDate:tomorrow]);
    
    NSString *str =  [formatter stringFromDate:tomorrow] ;
    
    return str ;

}

//7天前年月日
+ (NSString *)oneWeekTimeYMD{
    NSInteger dis = 6; //前后的天数
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
//    //之后的天数
//    theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
    //之前的天数
    theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*dis ];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString * currentDateStr = [dateFormatter stringFromDate:theDate];

    return currentDateStr ;
}

//30天前年月日
+ (NSString *)thirtyWeekTimeYMD{
    NSInteger dis = 29; //前后的天数
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    //    //之后的天数
    //    theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
    //之前的天数
    theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*dis ];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString * currentDateStr = [dateFormatter stringFromDate:theDate];
    
    return currentDateStr ;
}


+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending)
    {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending)
    {
        //NSLog(@"Date1 is in the past");
        return -1;
    }

    return 0;
}


//获取当前时间的月的第一天
+ (NSString *)getFirstOfThisMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
//    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString * currentDateStr = [dateFormatter stringFromDate:firstDay];

    return currentDateStr;
}


//将xx:xx:xx 转化成秒
+ (int)changeTimeToMiao:(NSString *)time{
    NSArray *arr = [time componentsSeparatedByString:@":"];
    NSString *astr = arr[0];
    NSString *bstr = arr[1];
    
    int a = 0;
    
    a = [astr intValue] * 60 + [bstr intValue];
    
    return a ;
}

@end
