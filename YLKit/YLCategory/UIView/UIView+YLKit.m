//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import "UIView+YLKit.h"
#import "objc/runtime.h"

static NSString *const UIView_YLKit_TapGesture = @"UIView_YLKit_TapGesture";
static NSString *const UIView_YLKit_SuperViewController = @"UIView_YLKit_SuperViewController";


static NSString *const UIView_YLKit_Ani_Type = @"UIView_YLKit_Ani_Type";
static NSString *const UIView_YLKit_Ani_Duration = @"UIView_YLKit_Ani_Duration";


@implementation UIView(UIView_YLKit)

@dynamic yl_tapGesture;
@dynamic yl_superVC;

#pragma mark - TapGesture
- (yl_block_Void)yl_tapGesture {
    
    return objc_getAssociatedObject(self, &UIView_YLKit_TapGesture);
}

//OBJC_ASSOCIATION_RETAIN_NONATOMIC --> OBJC_ASSOCIATION_COPY_NONATOMIC
- (void)yl_setTapGesture:(yl_block_Void)tapGesture{
    
    [self setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yl_tapSelf)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &UIView_YLKit_TapGesture, tapGesture, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)yl_tapSelf{
    
    if (self.yl_tapGesture) {
        
        self.yl_tapGesture();
    }
}



#pragma mark - Super ViewController
- (void)yl_setSuperVC:(UIViewController *)superVC{
    
    objc_setAssociatedObject(self, &UIView_YLKit_SuperViewController, superVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)yl_superVC{
    
    return objc_getAssociatedObject(self, &UIView_YLKit_SuperViewController);
}



#pragma mark - Animation
-(void)yl_ani_zoomIn:(CGFloat)scale duration:(CGFloat)duration{
    
    objc_setAssociatedObject(self, &UIView_YLKit_Ani_Type, NSStringFromCGAffineTransform(self.transform),OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &UIView_YLKit_Ani_Duration, [NSNumber numberWithFloat:duration], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    CGAffineTransform newTransform = CGAffineTransformMakeScale(scale, scale);
    
    [UIView animateWithDuration:duration animations:^{
        
        [self setTransform:newTransform];
    }];
    
}

-(void)yl_ani_rotate:(NSInteger)angle duration:(CGFloat)duration{
    
    objc_setAssociatedObject(self, &UIView_YLKit_Ani_Type, NSStringFromCGAffineTransform(self.transform),OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &UIView_YLKit_Ani_Duration, [NSNumber numberWithFloat:duration], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((angle * M_PI) / 180.0f);
    
    [UIView animateWithDuration:duration animations:^{
        
        [self setTransform:endAngle];
    }];
}

-(void)yl_ani_resume{
    
    NSString *transfrom_Str = objc_getAssociatedObject(self, &UIView_YLKit_Ani_Type);
    
    if (!transfrom_Str || transfrom_Str.length == 0) { return;}
    
    CGAffineTransform transform =  CGAffineTransformFromString(transfrom_Str);
    CGFloat dur = [objc_getAssociatedObject(self, &UIView_YLKit_Ani_Duration) floatValue];
    
    [UIView animateWithDuration:dur animations:^{
        
        [self setTransform:transform];
    } completion:^(BOOL finished) {
        
        [self yl_ani_clean];
    }];
}

-(void)yl_ani_clean{
    
    objc_setAssociatedObject (self, &UIView_YLKit_Ani_Duration, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject (self, &UIView_YLKit_Ani_Type    , nil, OBJC_ASSOCIATION_ASSIGN);
}


@end
