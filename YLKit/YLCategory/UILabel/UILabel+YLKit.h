//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel(UILabel_YLKit)

//设置行间距
-(NSMutableParagraphStyle *)yl_setText:(NSString *)text
                           LineSpacing:(CGFloat)spacing;

//设置前间距
- (NSMutableParagraphStyle *)yl_firstLineIndent:(CGFloat)indentValue;

//设置关键字及颜色
-(NSMutableAttributedString *)yl_setText:(NSString *)text
                                keyWords:(NSString *)keyWords;

-(NSMutableAttributedString *)yl_setText:(NSString *)text
                                keyWords:(NSString *)keyWords
                                   color:(UIColor *)color;

//一组关键字及颜色
-(void)yl_setText:(NSString *)text
      keyWordsArr:(NSArray *)keyWordsArr
            color:(UIColor *)color;

@end
