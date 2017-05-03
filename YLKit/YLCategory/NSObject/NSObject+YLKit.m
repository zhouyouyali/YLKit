//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "NSObject+YLKit.h"

#import "objc/runtime.h"

#define NSObject_YLKit_Info       @"UIView_YLKit_Info"

@implementation NSObject(NSObject_YLKit)

@dynamic yl_cacheInfo;


-(void)yl_setCacheInfo:(id)info{
    
    objc_setAssociatedObject(self, NSObject_YLKit_Info, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)yl_cacheInfo{
    
    return objc_getAssociatedObject(self, NSObject_YLKit_Info);
}


@end
