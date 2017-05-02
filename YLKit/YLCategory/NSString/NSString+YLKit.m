//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import "NSString+YLKit.h"

@implementation NSString(NSString_YLKit)

- (NSInteger)yl_length
{
    NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:encode];
    return [da length];
}

- (NSString *)yl_encode
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,CFSTR("+"),kCFStringEncodingUTF8));
}

- (NSString *)yl_toATS{
    
    if ([self containsString:@"http:"]) {
    
        return [self stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
    }
    return self;
}



- (NSString *)yl_sizeFormat{
    
    CGFloat size = [self floatValue];
    
    NSString *sizeUnits = @"B";
    CGFloat sizeValue = 0;
    
    NSString *sizeStr = [NSString stringWithFormat:@"%.0f",size];
    
    if (sizeStr.length >= 10) {
        sizeUnits = @"GB";
        sizeValue = size/1024/1024/1024;
    }else if (sizeStr.length >= 7) {
        sizeUnits = @"MB";
        sizeValue = size/1024/1024;
    }else if(sizeStr.length >= 4) {
        sizeUnits = @"KB";
        sizeValue = size/1024;
    }else{
        sizeValue = size;
    }
    
    return [NSString stringWithFormat:@"%.2f%@",sizeValue,sizeUnits];
}


@end
