//
//  UIView+YLAutoLayout.m
//  YLLayoutDemo
//
//  Created by zhouyouyali on 16/6/6.
//  Copyright © 2016年 Yaali. All rights reserved.
//

#import "UIView+YLAutoLayout.h"
#import "objc/runtime.h"

#import "YLAutoLayoutAnalysis.h"



NSString *const YLAutoLayoutPlaceHolderView = @"ZYYLAutoLayoutPlaceHolderView";
NSString *const YLAutoLayoutStretchView     = @"ZYYLAutoLayoutStretchView";


@implementation UIView (UIView_YLAutoLayout)

#pragma mark - Public
+(UIView *)createBySize:(CGSize)size{
    return [[UIView alloc] initWithFrame:(CGRect){CGPointZero,size}];
}

+(UIView *)createBySize:(CGSize)size color:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    [view setBackgroundColor:color];
    return view;
}

-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items{
    return [self yl_autoLayoutByItem:items type:YLAutoLayoutVertical];
}
-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items
                                         type:(YLAutoLayoutType)type{
    return [self yl_autoLayoutByItem:items type:type jointType:YLAutoLayoutJointSingle];
}

-(YLAutoLayoutAnalysis *)yl_autoLayoutByItem:(NSArray *)items
                                        type:(YLAutoLayoutType)type
                                   jointType:(YLAutoLayoutJointType)jointType{
 
    YLAutoLayoutAnalysis *analysis = [YLAutoLayoutAnalysis Analysis:items type:type jointType:jointType superViewsize:self.frame.size];
    
    if (jointType == YLAutoLayoutJointUnion) {
        [[analysis realShowItems] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self addSubview:obj];
            [obj setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            
            NSString *itemName = [NSString stringWithFormat:@"%@%ld",NSStringFromClass([YLAutoLayoutAnalysis class]),idx];
            
            NSArray *H_LayoutConstraint =
            [NSLayoutConstraint constraintsWithVisualFormat:[[analysis HConstraintArray] objectAtIndex:idx]
                                                    options:0
                                                    metrics:nil
                                                      views:@{itemName:obj}];
            NSArray *V_LayoutConstraint =
            [NSLayoutConstraint constraintsWithVisualFormat:[[analysis VConstraintArray] objectAtIndex:idx]
                                                    options:0
                                                    metrics:nil
                                                      views:@{itemName:obj}];
            
            [self addConstraints:H_LayoutConstraint];
            [self addConstraints:V_LayoutConstraint];
        }];
    }
    else{
        
        NSMutableDictionary *nameArray = [NSMutableDictionary dictionaryWithCapacity:0];
        [analysis.realShowItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self addSubview:obj];
            [obj setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            NSString *showItemName = [NSString stringWithFormat:@"%@%ld",
                                      NSStringFromClass([analysis class]),
                                      (unsigned long)idx];
            [nameArray setObject:obj forKey:showItemName];
            
        }];
        
        
        NSArray *H_LayoutConstraint =
        [NSLayoutConstraint constraintsWithVisualFormat:analysis.HConstraint
                                                options:0
                                                metrics:nil
                                                  views:nameArray];
        NSArray *V_LayoutConstraint =
        [NSLayoutConstraint constraintsWithVisualFormat:analysis.VConstraint
                                                options:0
                                                metrics:nil
                                                  views:nameArray];
        
        [self addConstraints:H_LayoutConstraint];
        [self addConstraints:V_LayoutConstraint];

        
    }
    
    //自适应宽高
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        [self setFrame:(CGRect){self.frame.origin,[analysis size]}];
    }else{
        CGSize size = self.frame.size;
        
        if (self.frame.size.width == 0) {
            size.width = [analysis size].width;
        }
        if (self.frame.size.height == 0){
            size.height = analysis.size.height;
        }
        [self setFrame:(CGRect){self.frame.origin,size}];
    }
    
    return analysis;
}



+(instancetype)buildPlaceHolderView:(CGSize)size{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    [view setBackgroundColor:[UIColor clearColor]];
    [view toPlaceHolderView];
    return view;
}

-(instancetype)toPlaceHolderView{
    objc_setAssociatedObject(self, &YLAutoLayoutPlaceHolderView, @"true", OBJC_ASSOCIATION_COPY_NONATOMIC);
    return self;
}

-(BOOL)isPlaceHolderView{
    return [objc_getAssociatedObject(self, &YLAutoLayoutPlaceHolderView) isEqualToString:@"true"] ? YES : NO;
}







-(void)toStretch:(YLAutoLayoutStretchType)type{
    objc_setAssociatedObject(self, &YLAutoLayoutStretchView, [NSNumber numberWithInteger:type], OBJC_ASSOCIATION_ASSIGN);
}
-(YLAutoLayoutStretchType)stretchType{
    id value = objc_getAssociatedObject(self, &YLAutoLayoutStretchView);
    if (value) {
        return (YLAutoLayoutStretchType)[value integerValue];
    }
    return YLAutoLayoutStretchClean;
}
-(BOOL)isStretchView{
    return [self stretchType] != YLAutoLayoutStretchClean ? YES : NO;
}

@end
