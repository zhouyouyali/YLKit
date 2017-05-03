//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//



#import "YLAutoLayoutAnalysis.h"

@interface YLAutoLayoutAnalysis ()

@property (nonatomic,assign) CGFloat itemMaxWidth;
@property (nonatomic,assign) CGFloat itemMaxHeight;

//用于判断是否需要充值size ,如果拼接的最小size大于此size 那么扩充
@property (nonatomic,assign) CGSize superViewSize;
/**
 0不拉伸 1View 2拉伸Space
 */
@property (nonatomic,assign) NSUInteger stretchType;

//源数据
@property (nonatomic,strong) NSMutableArray *originItems;



@property (nonatomic,assign) BOOL updateFrame;
@end

@implementation YLAutoLayoutAnalysis

+(instancetype)Analysis:(NSArray *)items
                   type:(YLAutoLayoutType)type
              jointType:(YLAutoLayoutJointType)jointType
          superViewsize:(CGSize)superViewsize{
    return [[YLAutoLayoutAnalysis alloc] initWithItems:items type:type jointType:jointType superViewsize:superViewsize];
}


- (instancetype)initWithItems:(NSArray *)items
                         type:(YLAutoLayoutType)type
                    jointType:(YLAutoLayoutJointType)jointType
                superViewsize:(CGSize)superViewsize
{
    self = [super init];
    if (self) {
        
        _originItems =   [NSMutableArray arrayWithArray:items];
        _realShowItems = [NSMutableArray arrayWithCapacity:0];
        _formatItems =   [NSMutableArray arrayWithCapacity:0];
        
        _HConstraintArray = [NSMutableArray arrayWithCapacity:0];
        _VConstraintArray = [NSMutableArray arrayWithCapacity:0];
        
        _type = type;
        _jointType = jointType;
        _updateFrame = YES;
        _superViewSize = superViewsize;
        
        [self analysis];
        [self format];
        if (jointType == YLAutoLayoutJointUnion)
            [self JointConstraintUnion];
        else
            [self JointConstraintSingle];
        
        
        
    }
    return self;
}


#pragma mark - private
/**
 解析
 读取最大高度 宽度
 */
-(void)analysis{
    
    _itemMaxWidth  = 0;
    _itemMaxHeight = 0;
    
    [_realShowItems removeAllObjects];
    
    //会从数组中删除 不会显示在界面上 只为撑开整体大小
    NSMutableArray *placeHolderViewArray = [NSMutableArray arrayWithCapacity:0];
    
    [_originItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self verificationOriginItem:obj];
        
        if ([obj isKindOfClass:[UIView class]]) {
            //读取所有的viewItem
            [_realShowItems addObject:obj];
            
            //读取最大范围
            CGSize itemSize = [obj frame].size;
            
            _itemMaxWidth  = (_itemMaxWidth  > itemSize.width)  ? _itemMaxWidth  : itemSize.width;
            _itemMaxHeight = (_itemMaxHeight > itemSize.height) ? _itemMaxHeight : itemSize.height;
            
            //删除占位view
            if ([(UIView *)obj isPlaceHolderView]) {
                [placeHolderViewArray addObject:obj];
            }
        }
    }];
    
    //删除最大宽高
    [placeHolderViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_originItems removeObject:obj];
        [_realShowItems removeObject:obj];
    }];
    
}


//changeFrame : yes
//@[@float,UIView,@float]
-(void)format{
    
    [_formatItems removeAllObjects];
    [_formatItems addObject:@0];
    
    //临时添加 用于避免最后一个为view或者为fill
    [_originItems addObject:@0];
    
    
    //计算出标准格式 保证view左右都会是NSNumber
    [_originItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id lastObjInRealItems = [_formatItems lastObject];
        
        //View
        if ([obj isKindOfClass:[UIView class]]) {
            
            //前一个为View 插入间距0
            if ([lastObjInRealItems isKindOfClass:[UIView class]]) {
                [_formatItems addObject:@0];
                [_formatItems addObject:obj];
            }
            //前一个为Number直接插入
            else {
                [_formatItems addObject:obj];
            }
        }
        
        //NSNumber
        else {
            //前一个为view
            if ([lastObjInRealItems isKindOfClass:[UIView class]]) {
                [_formatItems addObject:obj];
            }
            //前一个为number 计算偏移和替换
            else{
                CGFloat newValue = [lastObjInRealItems floatValue] + [obj floatValue];
                [_formatItems replaceObjectAtIndex:([_formatItems count] - 1)
                                        withObject:[NSNumber numberWithFloat:newValue]];
            }
        }
    }];
    
    //删除开始添加的结束标示
    [_originItems removeLastObject];
    
    
    //遍历formatItem 以获得整体size和需要拉伸的View
    //记录最后一个stretchview的Idx;
    __block NSMutableArray *stretchViewItem  = [NSMutableArray arrayWithCapacity:0];
    __block NSMutableArray *stretchSpaceItem = [NSMutableArray arrayWithCapacity:0];
    __block CGFloat stretchViewForCalu = 0;
    __block CGFloat willChangeSide = 0;
    //计算累计的边长
    __block CGFloat totalSide = 0;
    
    [_formatItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat sideLength = 0;
        
        if ([obj isKindOfClass:[UIView class]]) {
            CGSize objSize = [obj frame].size;
            sideLength = (_type%2 != 0) ? objSize.width : objSize.height;
            
            if ([obj stretchType] != YLAutoLayoutStretchClean) {
                _stretchType = 1;
                
                [stretchViewItem addObject:[NSNumber numberWithUnsignedInteger:idx]];
                
                if ([obj stretchType] != YLAutoLayoutStretchNot) {
                    willChangeSide += sideLength;
                    stretchViewForCalu += 1;
                }
                
            }
            
        }else{
            sideLength = [obj floatValue];
            if ([obj floatValue] < 0) {
                _stretchType = 1;
                sideLength = 0;
                [stretchSpaceItem addObject:[NSNumber numberWithUnsignedInteger:idx]];
                [_formatItems replaceObjectAtIndex:idx withObject:@0];
            }
        }
        totalSide += sideLength;
    }];

    //计算真实size
    if (_type%2 != 0) {
        _size = CGSizeMake(totalSide, _itemMaxHeight);
    }else{
        _size = CGSizeMake(_itemMaxWidth, totalSide);
    }
    
    //如果superViewSize 为0,0那么直接跳出不拉伸
    if (CGSizeEqualToSize(_superViewSize, CGSizeZero)) {
        _stretchType = 0;
        return;
    }
    
    if (_superViewSize.width == 0) {
        _superViewSize.width = _size.width;
    }
    if (_superViewSize.height == 0) {
        _superViewSize.height = _size.height;
    }
    
//   查找不到顺轴拉伸的view并且space则直接拉伸最后space
    if (stretchSpaceItem.count == 0) {
        __block BOOL needStretchSpace = YES;
        
        [stretchViewItem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = _formatItems[[obj integerValue]];
            if (view.stretchType != YLAutoLayoutStretchNot) {
                needStretchSpace = NO;
                *stop = YES;
            }
        }];
        if (needStretchSpace == YES) {
            [stretchSpaceItem addObject:[NSNumber numberWithUnsignedInteger:_formatItems.count-1]];
            willChangeSide += [_formatItems.lastObject floatValue];
            _stretchType = 1;
        }
    }
    
    //计算需要填充item的sidelength
    CGFloat superSide = _type%2 != 0 ? _superViewSize.width : _superViewSize.height;
    CGFloat averageValue = (superSide - totalSide + willChangeSide)/(stretchViewForCalu + stretchSpaceItem.count);
//    NSLog(@"%@",_formatItems);
    //改变space
    [stretchSpaceItem enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_formatItems replaceObjectAtIndex:[obj unsignedIntegerValue]
                                withObject:[NSNumber numberWithFloat:averageValue]];
    }];
//    NSLog(@"%@",_formatItems);
    
    //拉伸View
    [stretchViewItem enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSUInteger itemIdx = [obj unsignedIntegerValue];
        UIView *stretchView = _formatItems[itemIdx];
        
        CGFloat willWidth  = 0.f;
        CGFloat willHeight = 0.f;
        
        
        YLAutoLayoutStretchType stretchType = [stretchView stretchType];
        
        //根据轴反向直接设置对应边长为均值
        if (stretchType == YLAutoLayoutStretchDefault) {
            if (_type%2 != 0){
                willWidth = averageValue;
                willHeight = stretchView.frame.size.height;
            }
            else{
                willHeight = averageValue;
                willWidth = stretchView.frame.size.width;
            }
        }
        
        if (stretchType == YLAutoLayoutStretchNot) {
            if (_type%2 != 0) {
                willHeight = _superViewSize.height;
                willWidth = stretchView.frame.size.width;
            }else{
                willWidth = _superViewSize.width;
                willHeight = stretchView.frame.size.height;
            }
        }
        
        if (stretchType == YLAutoLayoutStretchAll) {
            if (_type%2 != 0) {
                willWidth = averageValue;
                willHeight = _superViewSize.height;
            }else{
                willHeight = averageValue;
                willWidth = _superViewSize.width;
            }
        }
        
        [stretchView setFrame:CGRectMake(0, 0, willWidth, willHeight)];
    }];
//    NSLog(@"%@",_formatItems);
}


-(void)JointConstraintSingle{
    _HConstraint = [NSMutableString stringWithFormat:@"H:|"];
    _VConstraint = [NSMutableString stringWithFormat:@"V:|"];;
    
    
    
    CGFloat Hoffset = 0;
    CGFloat Voffset = 0;
    
    CGFloat HTotal = [[_formatItems firstObject] floatValue];
    CGFloat VTotal = [[_formatItems firstObject] floatValue];
    
    
    for (NSInteger idx = 0; idx < [_realShowItems count]; ++idx) {
        
        UIView *showItem = _realShowItems[idx];
        NSString *showItemName = [NSString stringWithFormat:@"%@%ld",
                                  NSStringFromClass([self class]),
                                  (unsigned long)idx];
        
        CGFloat showItemWidth = showItem.frame.size.width;
        CGFloat showItemHeight = showItem.frame.size.height;
        
        CGFloat prefix = [_formatItems[[_formatItems indexOfObject:showItem] - 1] floatValue];
        CGFloat suffix = [_formatItems[[_formatItems indexOfObject:showItem] + 1] floatValue];
        
        BOOL isLastItem = (idx == [_realShowItems count]-1) ? YES : NO;
        BOOL isFirstItem = (idx == 0) ? YES : NO;
        
        //core
        NSString *append_HItem = [NSString stringWithFormat:@"-[%@(==%f)]",showItemName,showItemWidth];
        NSString *append_VItem = [NSString stringWithFormat:@"-[%@(==%f)]",showItemName,showItemHeight];
        
        
        //统一拼接水平或者垂直 公用约束
        //!!! H or V
        //初始化
        NSMutableString *constraint_Direction_first = (_type%2 != 0) ? _HConstraint : _VConstraint;
        NSString *appendItem_Direction_first        = (_type%2 != 0) ? append_HItem : append_VItem;
        
        //拼接
        [constraint_Direction_first appendFormat:@"-(%f)%@",prefix,appendItem_Direction_first];
        if (isLastItem) {
                [constraint_Direction_first appendFormat:@"-(%f)-|",suffix];
        }
        
        
        
        //!!! V or H
        //初始化
        NSMutableString *constraint_Direction = (_type%2 == 0) ? _HConstraint  : _VConstraint;
        NSString *appendItem_Direction        = (_type%2 == 0) ? append_HItem  : append_VItem;
        CGFloat *offset_Direction             = (_type%2 == 0) ? &Hoffset      : &Voffset;
        CGFloat itemMax_Direction             = (_type%2 == 0) ? _itemMaxWidth : _itemMaxHeight;
        CGFloat itemSide_Direction            = (_type%2 == 0) ? showItemWidth : showItemHeight;
        
        //如果需要拉伸 那么会根据superView的宽高计算 否则使用最大宽高
        if (_stretchType != 0) {
            CGFloat width = _superViewSize.width == 0 ? _itemMaxWidth : _superViewSize.width;
            CGFloat height = _superViewSize.height == 0 ? _itemMaxHeight : _superViewSize.height;
            itemMax_Direction = (_type%2 == 0) ? width : height;
        }
        
        //拼接
        switch (_type) {
            case YLAutoLayoutTop:
            case YLAutoLayoutLeft:
            {
                [constraint_Direction appendFormat:@"-(-%f)%@",*offset_Direction,appendItem_Direction];
                if (isLastItem) {
                    [constraint_Direction appendFormat:@"-(%f)-|",itemMax_Direction - itemSide_Direction];
                }
                *offset_Direction = itemSide_Direction;
            }
                break;
            
            case YLAutoLayoutRight:
            case YLAutoLayoutBottom:{
            
                if (isFirstItem){
                    CGFloat offset = itemMax_Direction - itemSide_Direction;
                    [constraint_Direction appendFormat:@"-(%f)%@",offset,appendItem_Direction];
                }
                else{
                    [constraint_Direction appendFormat:@"-(-%f)%@",itemSide_Direction,appendItem_Direction];
                }
                
                if (isLastItem) {
                    [constraint_Direction appendString:@"-0-|"];
                }
            }
                break;
            case YLAutoLayoutVertical:
            case YLAutoLayoutHorizontal:{
                
                CGFloat remainSpace = (itemMax_Direction - itemSide_Direction)/2;
                CGFloat startOffset = -*offset_Direction + remainSpace;
                
                if (isFirstItem){
                    [constraint_Direction appendFormat:@"-(%f)%@",remainSpace,appendItem_Direction];
                }
                else{
                    [constraint_Direction appendFormat:@"-(%f)%@",startOffset,appendItem_Direction];
                }
                
                if (isLastItem) {
                    [constraint_Direction appendFormat:@"-(%f)-|",remainSpace];
                }
                
                *offset_Direction = remainSpace + itemSide_Direction;
                
                
            }
                break;
            default:
                break;
        }
        
        
        if ((_type%2 != 0)) {
            Hoffset = (prefix + showItem.frame.size.width);
        }else{
            Voffset = (prefix + showItem.frame.size.height);
        }
        
        HTotal += Hoffset;
        VTotal += Voffset;
    }
    
}


-(void)JointConstraintUnion{
    
    [_HConstraintArray removeAllObjects];
    [_VConstraintArray removeAllObjects];
    
    CGFloat Hoffset = [[_formatItems firstObject] floatValue];
    CGFloat Voffset = [[_formatItems firstObject] floatValue];
    
    for (NSInteger idx = 0; idx < [_realShowItems count]; ++idx) {
        
        UIView *showItem = _realShowItems[idx];
        NSString *showItemName = [NSString stringWithFormat:@"%@%ld",
                                  NSStringFromClass([self class]),
                                  (unsigned long)idx];
        
        CGFloat showItemWidth = showItem.frame.size.width;
        CGFloat showItemHeight = showItem.frame.size.height;
        
        CGFloat suffix = [_formatItems[[_formatItems indexOfObject:showItem] + 1] floatValue];
        
        
        NSString *HStr;
        NSString *VStr;
        
        
        switch (_type) {
            case YLAutoLayoutTop:
            {
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",Hoffset,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",0.f,showItemName,showItemHeight];
                break;
            }
            case YLAutoLayoutBottom:
            {
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",Hoffset,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",_itemMaxHeight - showItemHeight,showItemName,showItemHeight];
                break;
            }
            case YLAutoLayoutLeft:
            {
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",0.f,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",Voffset,showItemName,showItemHeight];
                break;
            }
            case YLAutoLayoutRight:{
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",_itemMaxWidth - showItemWidth,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",Voffset,showItemName,showItemHeight];
                break;
            }
            case YLAutoLayoutHorizontal:{
                CGFloat VCenterOffset = (_itemMaxHeight - showItem.frame.size.height)/2;
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",Hoffset,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",VCenterOffset,showItemName,showItemHeight];
                break;
            }
            case YLAutoLayoutVertical:{
                CGFloat HCenterOffset = (_itemMaxWidth - showItem.frame.size.width)/2;
                HStr = [NSString stringWithFormat:@"H:|-(%f)-[%@(==%f)]",HCenterOffset,showItemName,showItemWidth];
                VStr = [NSString stringWithFormat:@"V:|-(%f)-[%@(==%f)]",Voffset,showItemName,showItemHeight];
                break;
            }
            default:
                break;
        }
        
        
        Hoffset += showItemWidth;
        Hoffset += suffix;
        
        Voffset += showItemHeight;
        Voffset += suffix;

        
        [_HConstraintArray addObject:HStr];
        [_VConstraintArray addObject:VStr];
    }
    
    if (_type%2 != 0) {
        _size = CGSizeMake(Hoffset, _itemMaxHeight);
    }else{
        _size = CGSizeMake(_itemMaxWidth, Voffset);
    }
    
}


#pragma mark - verification
-(BOOL)verificationOriginItem:(id)item{
    
    if ([item isKindOfClass:[UIView class]] ||
        [item isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    else{
        NSAssert(0, @"");
        return NO;
    }
    
}

@end
