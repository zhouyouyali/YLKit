//
//  UIView+YLAutoLayout.h
//  YLLayoutDemo
//
//  Created by zhouyouyali on 16/6/6.
//  Copyright © 2016年 Yaali. All rights reserved.
//

#import <UIKit/UIKit.h>



// 10,
// {30,30},
// 0,
// {40,40},
// 10,
// {10,10},
// 10

@class YLAutoLayoutAnalysis;


typedef NS_ENUM(NSInteger, YLAutoLayoutJointType) {
    
    //@"H:|-%f-[view1]-%f-[view2]-%f-|"
    YLAutoLayoutJointSingle,
   
    //like frame
    //@"H:|-%f-[view1]"
    //@"H:|-%f-[view2]"
    YLAutoLayoutJointUnion,
};


//extern NSString *const YLAutoLayoutFillSpace;
typedef NS_ENUM(NSInteger, YLAutoLayoutType) {
    //-----
    //012
    //
    //-----
    YLAutoLayoutTop = 1,
    
    //----
    //0
    //1
    //2
    //
    //----
    YLAutoLayoutLeft,
    
    //-----
    //
    //012
    //-----
    YLAutoLayoutBottom,
    
    //----
    //  0|
    //  1|
    //  2|
    //   |
    //----
    YLAutoLayoutRight,
    
    //------
    //
    //012
    //
    //------
    YLAutoLayoutHorizontal,
    
    //-----
    //  0
    //  1
    //  2
    //
    //-----
    YLAutoLayoutVertical,
    
};

//固定的frame自动适配
typedef NS_ENUM(NSInteger, YLAutoLayoutStretchType) {
    //不拉伸
    YLAutoLayoutStretchClean = 0,
    //根据方向自动拉伸一个边 例如top拉伸width
    YLAutoLayoutStretchDefault,
    //根据方向拉伸另外一边 例如top拉伸height
    YLAutoLayoutStretchNot,
    //拉伸全部
    YLAutoLayoutStretchAll,
};


@interface UIView (UIView_YLAutoLayout)

+(UIView *)createBySize:(CGSize)size;
+(UIView *)createBySize:(CGSize)size color:(UIColor *)color;

/**
 YLAutoLayoutVertical & YLAutoLayoutJointSingle
 */
-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items;
-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items
                                        type:(YLAutoLayoutType)type;
/**
 items : UIView ,
         NSNumber ,如果是-1则设置为拉伸space 
 如果同样有View被设置为拉伸 那么会优先拉伸space
 */
-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items
                                        type:(YLAutoLayoutType)type
                                   jointType:(YLAutoLayoutJointType)jointType;



/**
 作为填充view 实际不会绘制 会顶开self的最大范围
 或者在superView设置范围以后移动整个布局的轴线位置
 */
+(UIView *)buildPlaceHolderView:(CGSize)size;
-(UIView *)toPlaceHolderView;
-(BOOL)isPlaceHolderView;



/**
 设置view可拉伸 如果手动设置了self的范围 那么会直接拉伸设置了stetch的view
 */
//最后一个数组中的view启用
-(void)toStretch:(YLAutoLayoutStretchType)type;
-(YLAutoLayoutStretchType)stretchType;
-(BOOL)isStretchView;
@end
