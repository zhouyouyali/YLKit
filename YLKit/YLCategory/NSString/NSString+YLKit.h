//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(NSString_code)

//中英文混合长度
- (NSInteger)yl_length;

//处理+号编码问题
- (NSString *)yl_encode;

//http -> https
- (NSString *)yl_toATS;

//data 转换单位 GB MB KB B
- (NSString *)yl_sizeFormat;
@end
