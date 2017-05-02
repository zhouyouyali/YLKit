//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#ifndef YLCGType_h
#define YLCGType_h


/********************
 CGColor
 ********************/
#define UIColorFromR(rValue) ((float)((rValue & 0xFF0000) >> 16))/255.0
#define UIColorFromG(gValue) ((float)((gValue & 0xFF00) >> 16))/255.0
#define UIColorFromB(bValue) ((float)((bValue & 0xFF) >> 16))/255.0

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



/********************
 CGPoint
 ********************/
#define CGPointMakeOffsetX(point,ox) CGPointMake(point.x + ox, point.y)
#define CGPointMakeOffsetY(point,oy) CGPointMake(point.x, point.y + oy)

#define CGPointMakeOffset(point,ox,oy) CGPointMake(point.x + ox, point.y + oy)
#define CGPointMakeOffsetP(point,pointO) CGPointMake(point.x + pointO.x, point.y + pointO.y)

#define CGPointMakeHalf(point) CGPointMake(point.x/2, point.y/2)

#define CGPointMakeScale(point,scale) CGPointMake(point.x * scale , point.y * scale)
#define CGPointMakeScaleXY(point,scaleX,scaleY) CGPointMake(point.x * scaleX , point.y * scaleY)

#define CGCenterView(view) CGPointMake(view.frame.size.width/2, view.frame.size.height/2)




/********************
 CGSize
 ********************/
#define CGSizeMakeOffset(size,ox,oy) CGSizeMake(size.width + ox , size.height + oy)

#define CGSizeMakeHalf(size) CGSizeMake(size.width/2, size.height/2)

#define CGSizeMakeScale(size,scale) CGSizeMake(size.width * scale , size.height * scale)
#define CGSizeMakeScaleXY(size,scale_x,scale_y) CGSizeMake(size.width * scale_x , size.height * scale_y)




/********************
 CGRect
 ********************/
#define CGRectMakeOffset(rect,ox,oy,owidth,oheight)    CGRectMake(rect.origin.x + ox, rect.origin.y + oy, rect.size.width + owidth, rect.size.height + oheight)
#define CGRectMakeOffsetX(rect,ox)    (CGRect)CGRectMake(rect.origin.x + ox, rect.origin.y, rect.size.width, rect.size.height)
#define CGRectMakeOffsetY(rect,oy)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y + oy, rect.size.width, rect.size.height)
#define CGRectMakeOffsetW(rect,ow)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + ow, rect.size.height)
#define CGRectMakeOffsetH(rect,oh)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + oh)

#define CGRectMakeHalf(rect) (CGRect)CGRectMake(0, 0, rect.size.width/2, rect.size.height/2)
#endif
