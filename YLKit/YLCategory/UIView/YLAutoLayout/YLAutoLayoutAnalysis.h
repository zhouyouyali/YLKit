//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+YLAutoLayout.h"



@interface YLAutoLayoutAnalysis : NSObject

//源数据产生的size
@property (nonatomic,assign) CGSize size;

//格式化数据
@property (nonatomic,strong) NSMutableArray *formatItems;
//纯view数据
@property (nonatomic,strong) NSMutableArray<UIView *> *realShowItems;

//拼接字符串的类型
@property (nonatomic,assign) YLAutoLayoutType type;
@property (nonatomic,assign) YLAutoLayoutJointType jointType;


/**
 直接生成所有的约束format
 适用简单不带动画的布局 
 e.g. 直接修改其中一个的size 然后layoutSuperView修改整体范围
 */
@property (nonatomic,copy) NSMutableString *HConstraint;
@property (nonatomic,copy) NSMutableString *VConstraint;


#pragma mark - Single数据
/**
 每一个字符串表示 单个在realShowItems中的元素所的约束字符串
 分为水平和垂直
 
 
 constraintsWithVisualFormat 最后一个参数所需要的views中的dictionary:
 key: YLAutoLayoutAnalysis<#idx#>
 value: realShowItems[<#idx#>]
 */
@property (nonatomic,strong) NSMutableArray<NSString *> *HConstraintArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *VConstraintArray;


+(instancetype)Analysis:(NSArray *)items
                   type:(YLAutoLayoutType)type
              jointType:(YLAutoLayoutJointType)jointType
          superViewsize:(CGSize)superViewsize;


@end
