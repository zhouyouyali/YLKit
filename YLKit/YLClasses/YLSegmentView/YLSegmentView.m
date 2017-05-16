//
//  YLSegmentView.m
//  jsb
//
//  Created by zhouyouyali on 2017/1/19.
//  Copyright © 2017年 Yaali. All rights reserved.
//

#import "YLSegmentView.h"

#import "YLKit.h"
#import "UIView+YLKit.h"




@interface YLSegmentView ()
@property (nonatomic,strong) NSMutableArray<NSString *> *titles;
@property (nonatomic,strong) NSMutableArray<yl_block_Void> *actions;
@property (nonatomic,strong) NSMutableArray<yl_block_Void> *completeds;

@property (nonatomic,strong) NSMutableArray<NSValue *>  *titleSize;
@property (nonatomic,strong) NSMutableArray<UILabel *>   *titleViews;
@property (nonatomic,strong) NSMutableArray<NSNumber *> *titleCenterX;

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIView *slideView;

@property (nonatomic,assign) BOOL isTapAni;




@end

@implementation YLSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _isTapAni = false;
        
        _idx = 0;
        _edgeInset  = UIEdgeInsetsMake(5, 10, 0, 10);
        _titleSpace = 14.f;
        _fontSize = 15.f;
        _titleColor = [UIColor blackColor];
        _titleSelectedColor = UIColorFromRGB(0x4680d1);
        _slideColor = UIColorFromRGB(0x4680d1);
        _contentType = YLSegmentViewContentTypeDefault;
        
        
        [self setShowsVerticalScrollIndicator:false];
        [self setShowsHorizontalScrollIndicator:false];
        
        _titles     = [[NSMutableArray alloc] initWithCapacity:0];
        _actions    = [[NSMutableArray alloc] initWithCapacity:0];
        _completeds = [[NSMutableArray alloc] initWithCapacity:0];
        
        _titleViews = [[NSMutableArray alloc] initWithCapacity:0];
        _titleSize  = [[NSMutableArray alloc] initWithCapacity:0];
        _titleCenterX = [[NSMutableArray alloc] initWithCapacity:0];
        
        
        
    }
    return self;
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset{
    
    _edgeInset.left   += edgeInset.left;
    _edgeInset.top    += edgeInset.top;
    _edgeInset.right  += edgeInset.right;
    _edgeInset.bottom += edgeInset.bottom;
}

- (void)UI_SlideView{
    
    if (!_slideView) {
        
        _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1.5)];
        [[_slideView layer] setCornerRadius:1.f];
        
        [self Action_SlideView:0 animation:false completed:nil];
        
    }
    
    [_slideView setBackgroundColor:_slideColor];
    
    [_mainView addSubview:_slideView];
    
}

#pragma mark - Animation
- (void)scrollTo:(NSUInteger)idx
       animation:(BOOL)animation
       completed:(yl_block_Void)completed{
    
    if (idx >= _titles.count) {
        return;
    }
    
    [[_titleViews objectAtIndex:idx] yl_tapGesture]();
    
}

- (void)Action_SlideView:(NSInteger)idx
               animation:(BOOL)animation
               completed:(yl_block_Void)completed{
    
    _isTapAni = true;
    
    _idx = idx;
    
    CGFloat centerX = [_titleCenterX[idx] floatValue];
    CGFloat width = [_titleSize[idx] CGSizeValue].width;
    
    
    
    
    yl_block_Void reset = ^{
        [_slideView setFrame:CGRectMake(0, 0, width , _slideView.frame.size.height)];
        [_slideView setCenter:CGPointMake(centerX, self.frame.size.height - _slideView.frame.size.height/2 - 0.7)];
    };
    
    if (animation) {
        [UIView animateWithDuration:.3f
                              delay:0.f
             usingSpringWithDamping:1.f
              initialSpringVelocity:1.f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             
             reset();
             
         } completion:^(BOOL finished) {
             _isTapAni = false;
             
             if (completed) {
                 completed();
             }
         }];
    }else{
        reset();
        _isTapAni = false;
        
        if (completed) {
            completed();
        }
    }
    
    
    [self Action_BoundsChecking:true];
}

- (void)Action_BoundsChecking:(BOOL)ani{
    
    CGFloat centerX = [_titleCenterX[_idx] floatValue];
    CGFloat width = [_titleSize[_idx] CGSizeValue].width;
    
    //是否滑动到外面
    CGFloat leftOffset = (centerX - width/2);
    CGFloat rightOffset = (centerX + width/2) - self.frame.size.width;
    
    CGFloat outLeftValue = self.contentOffset.x - leftOffset;
    CGFloat outRightValue = (centerX + width/2) - self.contentOffset.x - self.frame.size.width;
    
    if (outLeftValue > 0) {
        
        CGFloat offsetMove = (_idx != 0 ? _titleSpace : 0) + _edgeInset.left;
        [self setContentOffset:CGPointMake(leftOffset - offsetMove, 0) animated:ani];
    }
    
    if (outRightValue > 0) {
        
        CGFloat offsetMove = (_idx != _titles.count - 1 ? _titleSpace : 0) + _edgeInset.right;
        [self setContentOffset:CGPointMake(rightOffset + offsetMove, 0) animated:ani];
    }
}

#pragma mark - Public
- (void)addTitle:(NSString *)title action:(yl_block_Void)action{
    
    [self addTitle:title action:action completed:nil];
}
- (void)addTitle:(NSString *)title
          action:(yl_block_Void)action
       completed:(yl_block_Void)completed{
    
    if (action == nil) {
        action = ^{};
    }
    if (completed == nil) {
        completed = ^{};
    }
    
    [_titles addObject:title];
    [_actions addObject:action];
    [_completeds addObject:completed];
    
}



- (void)addTitles:(NSArray *)titles
          actions:(NSArray *)actions{
    
    NSAssert(titles.count == actions.count, @"need equal");
    
    [_titles addObjectsFromArray:titles];
    [_actions addObjectsFromArray:actions];
}

- (void)replaceTitle:(NSString *)title
               index:(NSUInteger)index
              action:(yl_block_Void)action
           completed:(yl_block_Void)completed{
    
    [_titles replaceObjectAtIndex:index withObject:title];
    
    if (action != nil) {
        [_actions replaceObjectAtIndex:index withObject:action];
    }
    if (completed != nil) {
        [_completeds replaceObjectAtIndex:index withObject:completed];
    }
}


- (NSRange)removeTitlesBehindIndex:(NSInteger)idx{
    
    NSInteger length = _titles.count;  
    NSRange range = NSMakeRange(idx + 1, length - idx - 1);
    
    
    
    [_titles removeObjectsInRange:range];
    [_actions removeObjectsInRange:range];
    [_completeds removeObjectsInRange:range];
    
    return range;
}


- (void)removeLastTitle{
    
    [_titles removeLastObject];
    [_actions removeLastObject];
    [_completeds removeLastObject];
}



- (void)fireAction{
    _actions[_idx]();
}

- (void)fireCompleted{
    _completeds[_idx]();
}

#pragma mark - Layout
- (void)refresh{
    
    [_titleViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_titleViews removeAllObjects];

    [_titleCenterX removeAllObjects];
    [_titleSize removeAllObjects];
    
    [[_mainView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_mainView removeFromSuperview];
    
    
    NSNumber *left = [NSNumber numberWithFloat:_edgeInset.left];
    NSNumber *right = [NSNumber numberWithFloat:_edgeInset.right];
    
    NSMutableArray *layoutArray = [NSMutableArray arrayWithCapacity:0];
    
    CGFloat centerX = _edgeInset.left;
    
    for (NSInteger idx = 0; idx < [_titles count]; idx ++) {
        
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:_fontSize]];
        [label setText:_titles[idx]];
        [label setTextColor:_titleColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        if (idx == 0) {
            [label setTextColor:_titleSelectedColor];
        }
        
        [label yl_setTapGesture:^{
            
            if (_completeds[idx] == nil) {
                return ;
            }
            
            [_titleViews makeObjectsPerformSelector:@selector(setTextColor:) withObject:_titleColor];
            [label setTextColor:_titleSelectedColor];
            
            _actions[idx]();
            [self Action_SlideView:idx
                         animation:true
                         completed:_completeds[idx]];
        }];
        
        CGSize size = [label sizeThatFits:CGSizeMake(YLScreenWidth, YLScreenHeight)];
        [label setFrame:CGRectMake(0, 0, size.width, self.frame.size.height)];
        
        
        
        centerX += size.width/2;
        [_titleCenterX addObject:[NSNumber numberWithFloat:centerX]];
        [_titleSize addObject:[NSValue valueWithCGSize:size]];
        [_titleViews addObject:label];
        
        [layoutArray addObject:label];
        [layoutArray addObject:[NSNumber numberWithFloat:_titleSpace]];
        
        centerX += (_titleSpace + size.width/2);
        
    }
    
    [layoutArray removeLastObject];
    
    
    [layoutArray insertObject:left atIndex:0];
    [layoutArray addObject:right];
    
    
    
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    [_mainView setBackgroundColor:[UIColor clearColor]];
    [_mainView yl_autoLayoutByItem:layoutArray type:YLAutoLayoutHorizontal];
    
    [self setContentSize:CGSizeMake(_mainView.frame.size.width, 0)];
    
    
    
    
    NSArray *layoutMainItem = @[@-1,_mainView,@-1];
    if (_contentType == YLSegmentViewContentTypeLeft) {
        layoutMainItem = @[_mainView,@-1];
    }
    
    [self yl_autoLayoutByItem:layoutMainItem type:YLAutoLayoutHorizontal];
    
    
    [self UI_SlideView];
}

#pragma mark - scroll
- (void)setScrollView:(UIScrollView *)scrollView{
    if (_isTapAni) {
        return;
    }
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    
    NSInteger offsetPage = scrollView.contentOffset.x / pageWidth;
    CGFloat offset = (scrollView.contentOffset.x - offsetPage * pageWidth) / pageWidth;
    
    
    CGFloat scrollTo = _edgeInset.left;
    scrollTo += (([_titleSize[offsetPage] CGSizeValue].width + _titleSpace) * offset);
    
    
    for (NSInteger i = 0; i < offsetPage; i ++) {
        scrollTo += [_titleSize[i] CGSizeValue].width;
        scrollTo += _titleSpace;
    }
    
    
    NSInteger toPage = (offset == 0) ? offsetPage : offsetPage + 1;
    NSInteger curPage = (offsetPage - 1) < 0 ? 0 : toPage - 1;
    
    //out right
    if (toPage > _titles.count - 1) {
        toPage = _titles.count - 1;
        curPage = toPage;
    }
    

    CGFloat scale = (offset == 0) ? 1 : offset;
    
    CGFloat widthOffset = [_titleSize[toPage] CGSizeValue].width -  [_titleSize[curPage] CGSizeValue].width;

    CGFloat width = widthOffset  *  scale + [_titleSize[curPage] CGSizeValue].width;
    
    
    [_slideView setFrame:
     CGRectMake(scrollTo,
                _slideView.frame.origin.y,
                width,
                _slideView.frame.size.height)];
    
    
    if (offset == 0) {
        
        [self Action_BoundsChecking:false];
        
        [_titleViews[_idx] setTextColor:_titleColor];
        _idx = toPage;
        [_titleViews[_idx] setTextColor:_titleSelectedColor];
        
        yl_block_Void block = _completeds[_idx];
        if (block) {
            block();
        }
    }
}

@end
