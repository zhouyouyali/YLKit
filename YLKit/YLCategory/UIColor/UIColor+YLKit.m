//
//  UIColor+CustomColor.m
//  Yaali
//
//  Created by Yaali on 15/6/25.
//  Copyright (c) 2015年 Yaali. All rights reserved.
//

#import "UIColor+YLKit.h"
#import "YLCGType.h"


@interface YLColorKit : NSObject

#define property(iColor) @property (nonatomic, strong) UIColor *yl##iColor;

property(BlueColor)
property(DarkBlueColor)
property(GreenColor)
property(GrayColor)
property(OrangeColor)

property(LightGrayColor)
property(DarkGrayColor)

property(FontColor)
property(LightFontColor)
property(LineColor)
property(BtnColor)
property(BtnDisableColor)
property(BtnHighlightColor)

@end


@implementation YLColorKit

+ (YLColorKit *)shareInstance; {
    static dispatch_once_t once;
    static YLColorKit *instance;
    
    
    dispatch_once(&once, ^{
        instance = [[YLColorKit alloc] init];
    });
    
    return instance;
}

@end


@implementation UIColor(UIColor_CustomColor)


+ (UIColor *)yl_colorWithRed:(NSUInteger)red
                       green:(NSUInteger)green
                        blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}




#pragma mark - get

#define yl_customColor(iColor,originColor) \
+ (UIColor *)yl_custom##iColor{\
\
    UIColor *result = [[YLColorKit shareInstance] yl##iColor];\
\
    if (result) {\
\
        return result;\
    }\
\
    return originColor;\
}

yl_customColor(BlueColor,     UIColorFromRGB(0x7cbafc))
yl_customColor(DarkBlueColor, UIColorFromRGB(0x4680d1))
yl_customColor(GreenColor,    UIColorFromRGB(0x68b445))
yl_customColor(GrayColor,     UIColorFromRGB(0xf5f5f5))
yl_customColor(OrangeColor,   UIColorFromRGB(0xffb34b))

yl_customColor(LightGrayColor,   UIColorFromRGB(0xf3f5f7))
yl_customColor(DarkGrayColor,    UIColorFromRGB(0x7f7f7f))

yl_customColor(FontColor,       UIColorFromRGB(0x333333))
yl_customColor(LightFontColor,  UIColorFromRGB(0x717886))

yl_customColor(LineColor,  UIColorFromRGB(0xcccccc))

yl_customColor(BtnColor,            UIColorFromRGB(0x7cbafc))
yl_customColor(BtnDisableColor,     UIColorFromRGB(0xcccccc))
yl_customColor(BtnHighlightColor,   UIColorFromRGB(0xf3f5f7))


#pragma mark - set

#define yl_setCustomColor(iColor) \
+ (void)yl_setCustom##iColor:(UIColor *)color{\
    [[YLColorKit shareInstance] setYl##iColor:color];\
}

yl_setCustomColor(BlueColor)
yl_setCustomColor(DarkBlueColor)
yl_setCustomColor(GreenColor)
yl_setCustomColor(GrayColor)
yl_setCustomColor(OrangeColor)

yl_setCustomColor(LightGrayColor)
yl_setCustomColor(DarkGrayColor)

yl_setCustomColor(FontColor)
yl_setCustomColor(LightFontColor)

yl_setCustomColor(LineColor)

yl_setCustomColor(BtnColor)
yl_setCustomColor(BtnDisableColor)
yl_setCustomColor(BtnHighlightColor)


@end
