//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import "UIButton+YLKit.h"

#import "objc/runtime.h"


static NSString * UIButton_YLKit_Mark_Down = @"UIButton_YLKit_Mark_Down";
static NSString * UIButton_YLKit_Mark_DragInside = @"UIButton_YLKit_Mark_DragInside";
static NSString * UIButton_YLKit_Mark_DragOutside = @"UIButton_YLKit_Mark_DragOutside";
static NSString * UIButton_YLKit_Mark_DragEnter = @"UIButton_YLKit_Mark_DragEnter";
static NSString * UIButton_YLKit_Mark_DragExit = @"UIButton_YLKit_Mark_DragExit";
static NSString * UIButton_YLKit_Mark_UpInside = @"UIButton_YLKit_Mark_UpInside";
static NSString * UIButton_YLKit_Mark_UpOutside = @"UIButton_YLKit_Mark_UpOutside";


#define UIButton_YLKit_Case(event) \
case UIControlEventTouch##event:\
value = UIButton_YLKit_Mark_##event;\
mark = &UIButton_YLKit_Mark_##event;



@implementation UIButton (UIButton_YLKit)

-(void)yl_addAction:(void(^)(UIButton *))action event:(UIControlEvents)event{
    
    NSString *value;
    const void *mark;
    
    switch (event) {
        UIButton_YLKit_Case(Down)
            break;
        UIButton_YLKit_Case(DragInside)
            break;
        UIButton_YLKit_Case(DragOutside)
            break;
        UIButton_YLKit_Case(DragEnter)
            break;
        UIButton_YLKit_Case(DragExit)
            break;
        UIButton_YLKit_Case(UpInside)
            break;
        UIButton_YLKit_Case(UpOutside)
            break;
        
        default:
            break;
    }
    
    
    
    objc_setAssociatedObject(self, mark, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:NSSelectorFromString(value) forControlEvents:event];
    
}

#define UIButton_YLKit_Mark_(event) \
-(void)UIButton_YLKit_Mark_##event{\
((void(^)(UIButton *))(objc_getAssociatedObject(self, &UIButton_YLKit_Mark_##event)))(self);\
}

UIButton_YLKit_Mark_(Down)
UIButton_YLKit_Mark_(DragInside)
UIButton_YLKit_Mark_(DragOutside)
UIButton_YLKit_Mark_(DragEnter)
UIButton_YLKit_Mark_(DragExit)
UIButton_YLKit_Mark_(UpInside)
UIButton_YLKit_Mark_(UpOutside)










#pragma mark - YLArrangeType

-(void)yl_changeType:(YLButtonArrangeType)type space:(CGFloat)space{
    
    [self sizeToFit];
    
    switch (type) {
        case YLButtonArrangeType1:
            [self changeToType1Byspace:space];
            break;
        case YLButtonArrangeType2:
            [self changeToType2Byspace:space];
            break;
        default:
            break;
    }
    
    
    
}

- (void)changeToType1Byspace:(CGFloat)space{
    

    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    
    CGFloat width_no_edge = titleSize.width > imageSize.width ? titleSize.width : imageSize.width;
    CGFloat height_no_edge = titleSize.height + imageSize.height;
    
    
    CGFloat width = width_no_edge + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat height = height_no_edge + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom + space;
    
    
    
    [self setFrame:(CGRect){self.frame.origin,CGSizeMake(width, height)}];
    
    self.imageEdgeInsets =
    UIEdgeInsetsMake(-titleSize.height - space,
                     0.0,
                     0,
                     -titleSize.width);
    
    self.titleEdgeInsets =
    UIEdgeInsetsMake(0,
                     -imageSize.width,
                     -imageSize.height - space,
                     0);
}



- (void)changeToType2Byspace:(CGFloat)space{
    
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGRect rect = self.frame;
    rect.size.width = size.width + space;
    [self setFrame:rect];
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space);
    
}
@end
