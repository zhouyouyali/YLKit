//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "YLBlockType.h"
#import "YLCGType.h"

#import "UIView+YLAutoLayout.h"







#define YLScaleImgStandard16 (9.0/16.0)
#define YLScaleImgStandard4 (3.0/4.0)

#define YLVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



#define YLScreenHeight [[UIScreen mainScreen] bounds].size.height
#define YLScreenWidth [[UIScreen mainScreen] bounds].size.width

#define YLStatusBarHeight 20
#define YLNavigationHeight 44
#define YLTabBarHeight 49.0

#define YLVisibleHeight  YLScreenHeight - YLTabBarHeight - YLNavigationHeight - YLStatusBarHeight
#define YLKeyWindow      [[UIApplication sharedApplication] keyWindow]

#define YLTICK   NSDate *startTime = [NSDate date]
#define YLTOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define YLStr(x) [NSString stringWithFormat:@"%ld",(unsigned long)x]
#define YLStrF(float) [NSString stringWithFormat:@"%f",float]

#define YLImg(x) [UIImage imageNamed:x]

#if TARGET_IPHONE_SIMULATOR//模拟器

    #define chooseImage 1
#elif TARGET_OS_IPHONE //真机

    #define chooseImage 0
#endif
