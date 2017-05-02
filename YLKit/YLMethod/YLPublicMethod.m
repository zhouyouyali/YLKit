//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "YLPublicMethod.h"



@implementation YLPublicMethod


+ (void)yl_delay:(CGFloat)delay
           block:(yl_block_Void)block
{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}



+ (void)yl_timingByInterval:(NSInteger)interval
                    timeOut:(NSInteger)timeOut
                  eachBlock:(yl_block_Int)eachBlock
                  completed:(yl_block_Void)completed{
    
    
    
    __block CGFloat blockTimeOut = timeOut;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), interval *NSEC_PER_SEC, 0); // set interval
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(blockTimeOut<=0){
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                completed();
            });
        }else{
            
            blockTimeOut--;
            dispatch_async(dispatch_get_main_queue(), ^{
                eachBlock(blockTimeOut);
            });
        }
    });
    dispatch_resume(_timer);

    
}


#pragma mark - NSLayoutConstraint

+ (NSLayoutConstraint *)constraint_updata:(UIView *)obj type:(NSLayoutAttribute)type{

    for (NSLayoutConstraint* constraint in obj.constraints) {
        
        if (constraint.firstAttribute == type) {
            
            return constraint;
        }
    }
    
    return nil;
}

+ (NSLayoutConstraint *)constraint_updata:(UIView *)searchView
                                firstItem:(UIView *)firstItem
                                     type:(NSLayoutAttribute)type{
    
    for (NSLayoutConstraint* constraint in searchView.constraints) {
        
        if (constraint.firstItem == firstItem && constraint.firstAttribute == type) {
            
            return constraint;
        }
        
    }
    return nil;
}


+ (NSLayoutConstraint *)constraint_search:(UIView *)searchView
                                firstItem:(UIView *)firstItem
                                firstType:(NSLayoutAttribute)firstType
                               secondItem:(UIView *)secondItem
                               secondType:(NSLayoutAttribute)secondType{
    
    NSArray* constrains = searchView.constraints;
    
    for (NSLayoutConstraint* constraint in constrains) {
        
        if (constraint.firstItem == firstItem &&
            constraint.secondItem == secondItem &&
            constraint.firstAttribute == firstType &&
            constraint.secondAttribute == secondType) {
            
            return constraint;
        }
    }
    
    for (NSLayoutConstraint* constraint in constrains) {
        
        if (constraint.firstItem == secondItem &&
            constraint.secondItem == firstItem &&
            constraint.firstAttribute == secondType &&
            constraint.secondAttribute == firstType) {
            
            return constraint;
        }
    }
    
    
    return nil;
}


@end
