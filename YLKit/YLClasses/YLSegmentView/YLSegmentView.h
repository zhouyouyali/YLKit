//
//  YLSegmentView.h
//  jsb
//
//  Created by zhouyouyali on 2017/1/19.
//  Copyright © 2017年 Yaali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLKit.h"

typedef NS_ENUM(NSInteger, YLSegmentViewContentType) {
    YLSegmentViewContentTypeDefault = (1 << 0),
    YLSegmentViewContentTypeLeft = (1 << 1),
};


@interface YLSegmentView : UIScrollView

//当前titles replaceTitle中使用
@property (nonatomic,readonly) NSMutableArray<NSString *> *titles;

@property (nonatomic,assign) UIEdgeInsets edgeInset;
@property (nonatomic,assign) CGFloat titleSpace;

@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *titleSelectedColor;

@property (nonatomic,strong) UIColor *slideColor;

@property (nonatomic,readonly) NSUInteger idx;

@property (nonatomic, assign) YLSegmentViewContentType contentType;

@property (nonatomic, readonly, weak) UIScrollView *linkView;




- (instancetype)initWithFrame:(CGRect)frame;
- (void)refresh;

/**调用action*/
- (void)fireAction;
/**调用completed*/
- (void)fireCompleted;


#pragma mark - need [refresh] 
- (void)addTitle:(NSString *)title
          action:(yl_block_Void)action;
- (void)addTitle:(NSString *)title
          action:(yl_block_Void)action
       completed:(yl_block_Void)completed;




- (void)addTitles:(NSArray *)titles actions:(NSArray *)actions;


- (void)replaceTitle:(NSString *)title
               index:(NSUInteger)index
              action:(yl_block_Void)action
           completed:(yl_block_Void)completed;


//删除idx之后的Title   0,1,2  idx为0则删除1,2
- (NSRange)removeTitlesBehindIndex:(NSInteger)idx;
- (void)removeLastTitle;




#pragma mark - Association
/**
[<#Segment#> addTitle:<#Title#> action:^{
    [<#ScrollView#> setContentOffset:CGPointMake(ScreenWidth * i, 0) animated:YES];
} completed:^{
    
}];

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [<#Segment#> setScrollView:scrollView];
}
*/
- (void)setScrollView:(UIScrollView *)scrollView;
- (void)scrollTo:(NSUInteger)idx animation:(BOOL)animation completed:(yl_block_Void)completed;
@end
