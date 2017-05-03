//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLBlockType.h"

@interface UIView(UIView_YLKit)

@property (nonatomic,copy,setter=yl_setTapGesture:) yl_block_Void yl_tapGesture;
@property (nonatomic,strong,setter=yl_setSuperVC:) UIViewController * yl_superVC;




-(void)yl_ani_zoomIn:(CGFloat)scale duration:(CGFloat)duration;
-(void)yl_ani_rotate:(NSInteger)angle duration:(CGFloat)duration;
-(void)yl_ani_resume;
-(void)yl_ani_clean;
@end
