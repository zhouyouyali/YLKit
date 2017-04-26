//
//  YYGeometry.h
//  YYRecordAp
//
//  Created by Yaali on 10/16/14.
//  Copyright (c) 2014 Yaali. All rights reserved.
//

#ifndef YYRecordAp_YYGeometry_h
#define YYRecordAp_YYGeometry_h


/**
 color
 */
#define UIColorFromR(rValue) ((float)((rValue & 0xFF0000) >> 16))/255.0
#define UIColorFromG(gValue) ((float)((gValue & 0xFF00) >> 16))/255.0
#define UIColorFromB(bValue) ((float)((bValue & 0xFF) >> 16))/255.0
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//point
#define CGPointMakeFit(x,y,offsetx,offsety) ISIPhone4 ? CGPointMake(x, y) : CGPointMake(x + offsetx, y + offsety);
#define CGFloatMakeFit(x,offsetx) (ISIPhone4 ? x : (x + offsetx))
#define CGSizeMakeFit(x,y,offsetx,offsety) ISIPhone4 ? CGSizeMake(x, y) : CGSizeMake(x + offsetx, y + offsety);
#define CGPointMakeScale(point,scale) CGPointMake(point.x * scale , point.y * scale)
#define CGPointMakeScale(point,scale) CGPointMake(point.x * scale , point.y * scale)
#define CGPointMakeScaleXY(point,scaleX,scaleY) CGPointMake(point.x * scaleX , point.y * scaleY)
#define CGPointMakePoint(point,point1) CGPointMake(point.x * point1.x , point.y * point1.y)


//CGSize
#define CGSizeMakeHalf(size) CGSizeMake(size.width/2, size.height/2)
#define CGSizeMakeScale(size,scale) CGSizeMake(size.width * scale , size.height * scale)
#define CGSizeMakeScaleXY(size,scale_x,scale_y) CGSizeMake(size.width * scale_x , size.height * scale_y)
#define CGSizeMakeMultSize(size,size1) CGSizeMake(size.width * size1.width , size.height * size1.height)
#define CGSizeMakeOffsetXY(size,ox,oy) CGSizeMake(size.width + ox , size.height + oy)

//CGPoint
#define CGPointMakeOffsetX(point,ox) CGPointMake(point.x + ox, point.y)
#define CGPointMakeOffsetY(point,oy) CGPointMake(point.x, point.y + oy)
#define CGCenterView(view) CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
#define CGhalfPointMakeP(point) CGPointMake(point.x/2, point.y/2)
#define CGhalfPointMake(x,y) CGPointMake(x/2, y/2)
#define CGPointMakeOffset(point,ox,oy) CGPointMake(point.x + ox, point.y + oy)
#define CGPointMakeOffsetP(point,pointO) CGPointMake(point.x + pointO.x, point.y + pointO.y)


//CGRect offset
#define CGRectMakeOffset(rect,ox,oy,owidth,oheight)    CGRectMake(rect.origin.x + ox, rect.origin.y + oy, rect.size.width + owidth, rect.size.height + oheight)
#define CGRectMakeOffsetX(rect,ox)    (CGRect)CGRectMake(rect.origin.x + ox, rect.origin.y, rect.size.width, rect.size.height)
#define CGRectMakeOffsetY(rect,oy)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y + oy, rect.size.width, rect.size.height)
#define CGRectMakeOffsetW(rect,ow)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + ow, rect.size.height)
#define CGRectMakeOffsetH(rect,oh)    (CGRect)CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + oh)

#define CGRectMakeHalf(rect) (CGRect)CGRectMake(0, 0, rect.size.width/2, rect.size.height/2)
#define CGRectMakeScale(rect,scale) (CGRect)CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale)
#endif
