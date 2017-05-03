//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "UILabel+YLKit.h"

@implementation UILabel(UILabel_YLKit)



-(NSMutableParagraphStyle *)yl_setText:(NSString *)text
                           LineSpacing:(CGFloat)spacing{
    
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [paragraphStyle setLineSpacing:spacing];
    
    [self setAttributedText:attrString];
    
    return paragraphStyle;
}





- (NSMutableParagraphStyle *)yl_firstLineIndent:(CGFloat)indentValue{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString :self.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc ] init];
    [paragraphStyle setFirstLineHeadIndent:indentValue];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range : NSMakeRange(0 , [attributedString length])];
    
    [self setAttributedText:attributedString];
    
    return paragraphStyle;
}





-(NSMutableAttributedString *)yl_setText:(NSString *)text
                                keyWords:(NSString *)keyWords{
    
    return [self yl_setText:text keyWords:keyWords color:[UIColor redColor]];
}




-(NSMutableAttributedString *)yl_setText:(NSString *)text
                                keyWords:(NSString *)keyWords
                                   color:(UIColor *)color{
    
    
    if (!keyWords || keyWords.length == 0) {
        
        [self setText:text];
        return [[NSMutableAttributedString alloc] initWithString:text];
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    NSString *remainText = [NSString stringWithString:text];
    
    NSInteger rangeOffset = 0;
    
    while (keyWords.length != 0 &&
           remainText.length > keyWords.length) {
        
        NSRange range = [remainText rangeOfString:keyWords];
        
        if (range.length == 0) {
            remainText = @"";
            continue;
        }
        [attr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(rangeOffset + range.location, range.length)];
        rangeOffset += (range.location + range.length);
        
        NSString *cacheText = [remainText substringFromIndex:range.location + range.length];
        remainText = cacheText;
    }
    [self setAttributedText:attr];
    
    return attr;
}




-(void)yl_setText:(NSString *)text
      keyWordsArr:(NSArray *)keyWordsArr
            color:(UIColor *)color{
    
    if (!keyWordsArr || keyWordsArr.count == 0) {
        
        [self setText:text];
        return;
    }
    
    if (keyWordsArr.count==1) {
    
        [self yl_setText:text keyWords:keyWordsArr.firstObject color:color];
        return;
    }
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSInteger rangeOffset = 0;
    
    for (NSString *key in keyWordsArr) {
        
        if (text.length<rangeOffset) { break; }
        
        
        NSString *rangeStr=[text substringWithRange:NSMakeRange(rangeOffset, text.length-rangeOffset)];
        NSRange range=[rangeStr rangeOfString:key];
        
        if (range.length!=0) {
        
            [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location+rangeOffset, range.length)];
            rangeOffset+=range.location+range.length;
        }
    }
    self.attributedText=str;
    
}
@end
