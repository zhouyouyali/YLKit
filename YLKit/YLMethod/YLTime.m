//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//



#import "YLTime.h"

@implementation YLTime

+ (NSDate *)yl_time_stringToDate:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    
    if ([dateStr containsString:@"T"]) {
        
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }else{
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSDate *result = [self yl_time_getJetlag:date];
    return result;
}

+ (NSString *)yl_time_DateToString:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    return [formatter stringFromDate:date];
}



+ (NSDate *)yl_time_locationDate:(NSDate *)anyDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


+ (NSDate *)yl_time_getJetlag:(NSDate *)date
{
    
    if (date == nil) {
        
        date = [NSDate date];
    }

    return [date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:date]];
}

+ (NSString *)yl_time_sinceData:(NSDate *)oldDate
{
    
    NSDate *now = [self yl_time_getJetlag:nil];
    NSTimeInterval c = [now timeIntervalSinceDate:oldDate];
    
    NSString *timeString=@"";
    
    if (c < 60) {
        
        timeString = @"刚刚";
    }
    else if (c < 3600)//minute
    {
        
        timeString=[NSString stringWithFormat:@"%ld分钟前", (unsigned long)(c/60)];
    }
    else if (c >= 3600 && c < 86400) //hour
    {
        
        timeString=[NSString stringWithFormat:@"%ld小时前", (unsigned long)(c/(60 * 60))];
    }
    else if (c >= 86400 && c < 864000) //day
    {
        
        timeString=[NSString stringWithFormat:@"%ld天前", (unsigned long)(c/(60 * 60 * 24))];
    }else{
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        timeString = [NSString stringWithFormat:@"%@",[format stringFromDate:oldDate]];
    }
    
    return timeString;
}


+ (NSString *)yl_time_timeStamp:(NSTimeInterval)timeInterval{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)yl_time_showWithTodayOrTomorrow:(NSString *)showDate{
    
    NSDate *today = [self yl_time_locationDate:[NSDate date]];
    NSString *today_Str = [[NSString stringWithFormat:@"%@",today] substringToIndex:10];
    
    
    NSDate *tomorrow = [self yl_time_locationDate:[[NSDate date] dateByAddingTimeInterval:24 * 60 * 60]];
    NSString *tomorrow_Str = [[NSString stringWithFormat:@"%@",tomorrow] substringToIndex:10];
    NSString *show_Str = [[NSString stringWithFormat:@"%@",showDate] substringToIndex:10];
    
    if ([show_Str isEqualToString:today_Str]) {
        
        return @"今天";
    }
    if ([show_Str isEqualToString:tomorrow_Str]) {
        
        return @"明天";
    }
    
    return show_Str;
}


@end
