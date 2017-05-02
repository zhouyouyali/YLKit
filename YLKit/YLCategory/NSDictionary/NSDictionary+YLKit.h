//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDictionary(NSString_code)


- (id)yl_objectForKey:(NSString *)key;

- (id)yl_objectForKeys:(NSString *)keys,...;

//多层级读取转换NSNumber或者NSString -> NSString
- (NSString *)yl_convertObjectToStringBy:(id)keys ,...;
@end
