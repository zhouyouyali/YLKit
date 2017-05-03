//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YLButtonArrangeType) {
    //Image
    //Title
    YLButtonArrangeType1,
    
    //Title Image
    YLButtonArrangeType2,
    
    
    //Zhouyouyali   TODO
    //其他布局
};


@interface UIButton(UIButton_YYKit)

-(void)yl_addAction:(void(^)(UIButton *))action event:(UIControlEvents)event;

-(void)yl_changeType:(YLButtonArrangeType)type space:(CGFloat)space;
@end
