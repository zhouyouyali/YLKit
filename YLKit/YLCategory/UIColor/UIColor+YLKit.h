//
//  UIColor+CustomColor.h
//  Yaali
//
//  Created by Yaali on 15/6/25.
//  Copyright (c) 2015年 Yaali. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor(UIColor_CustomColor)

+ (UIColor *)yl_colorWithRed:(NSUInteger)red
                       green:(NSUInteger)green
                        blue:(NSUInteger)blue;


+ (UIColor *)yl_customBlueColor;
+ (UIColor *)yl_customDarkBlueColor;
+ (UIColor *)yl_customGreenColor;
+ (UIColor *)yl_customGrayColor;
+ (UIColor *)yl_customOrangeColor;
+ (UIColor *)yl_customLightGrayColor;
+ (UIColor *)yl_customDarkGrayColor;
+ (UIColor *)yl_customFontColor;
+ (UIColor *)yl_customLightFontColor;
+ (UIColor *)yl_customLineColor;
+ (UIColor *)yl_customBtnColor;
+ (UIColor *)yl_customBtnDisableColor;
+ (UIColor *)yl_customBtnHighlightColor;







+ (void)yl_setCustomBlueColor:(UIColor *)color;
+ (void)yl_setCustomDarkBlueColor:(UIColor *)color;
+ (void)yl_setCustomGreenColor:(UIColor *)color;
+ (void)yl_setCustomGrayColor:(UIColor *)color;
+ (void)yl_setCustomOrangeColor:(UIColor *)color;
+ (void)yl_setCustomLightGrayColor:(UIColor *)color;
+ (void)yl_setCustomDarkGrayColor:(UIColor *)color;
+ (void)yl_setCustomFontColor:(UIColor *)color;
+ (void)yl_setCustomLightFontColor:(UIColor *)color;
+ (void)yl_setCustomLineColor:(UIColor *)color;
+ (void)yl_setCustomBtnColor:(UIColor *)color;
+ (void)yl_setCustomBtnDisableColor:(UIColor *)color;
+ (void)yl_setCustomBtnHighlightColor:(UIColor *)color;


@end
