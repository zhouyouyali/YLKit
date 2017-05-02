//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "YLFile.h"

@implementation YLFile


+(NSString *)yl_cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,  NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Caches"];
}

@end
