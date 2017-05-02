//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YLBlockType.h"

@interface YLPublicMethod : NSObject


+ (void)yl_delay:(CGFloat)delay
           block:(yl_block_Void)block;

+ (void)yl_timingByInterval:(NSInteger)interval
                    timeOut:(NSInteger)timeOut
                  eachBlock:(yl_block_Int)eachBlock
                  completed:(yl_block_Void)completed;
@end
