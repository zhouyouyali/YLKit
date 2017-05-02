//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface YLTime : NSObject

//string -> date
+ (NSDate *)yl_time_stringToDate:(NSString *)dateStr;

//date  -> string
+ (NSString *)yl_time_DateToString:(NSDate *)date;

//转换为本地时间
+ (NSDate *)yl_time_locationDate:(NSDate *)anyDate;

//计算时差
+ (NSDate *)yl_time_getJetlag:(NSDate *)date;

//根据当前实现显示 刚刚 x分钟前 x小时前 x天前 年月日
+ (NSString *)yl_time_sinceData:(NSDate *)oldDate;

//时间戳
+ (NSString *)yl_time_timeStamp:(NSTimeInterval)timeInterval;

//传入时间和当前时间比较显示 今天或者明天或者年月日
+ (NSString *)yl_time_showWithTodayOrTomorrow:(NSString *)showDate;
@end
