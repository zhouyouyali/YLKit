//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import "NSDictionary+YLKit.h"
#import "YLBlockType.h"


#define setVariableToArray(values)\
    NSMutableArray *iResult = [[NSMutableArray alloc] init];\
    va_list params; \
    va_start(params,values);\
    id arg;\
    if (values) {\
        id prev = values;\
        [iResult addObject:prev];\
        while( (arg = va_arg(params,id)) )\
        {\
            if ( arg ){\
                [iResult addObject:arg];\
            }\
        }\
    va_end(params);\
    }\



typedef NSString *(^block_Nub_returnStr)(NSNumber *numb);


@implementation NSDictionary(NSDictionary_YLKit)

- (id)yl_objectForKey:(NSString *)key
{
    
    id value = [self objectForKey:key];
    
    if ([value isEqual:[NSNull null]] == NO &&
        value != nil) {
        
        return value;
    }
    return @"";
}


- (id)yl_objectForKeys:(NSString *)keys,...{
    
    setVariableToArray(keys)
    
    id result = self;
    
    for (NSInteger i = 0; i < [iResult count]; ++i) {
        
        result = [result objectForKey:[iResult objectAtIndex:i]];
    }
    return result;
}

- (NSString *)yl_convertObjectToStringBy:(id)keys ,...{
    
    setVariableToArray(keys)
    return [self convertObjectToStringBy:iResult];
}



- (NSString *)convertObjectToStringBy:(NSArray *)keys{
    
    id result = self;
    for (NSInteger i = 0; i < [keys count]; ++i) {
        
        result = [self convertObjectBy:[keys objectAtIndex:i] searchItem:result];
    }
    
    if (![result isKindOfClass:[NSString class]]) {
        
        NSAssert(0, @"need NSString");
    }
    return result;
}

- (id)convertObjectBy:(NSString *)aKey searchItem:(id)item{
    
    block_Nub_returnStr getStrByNub = ^(NSNumber *nub){
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:nub];
    };
    
    id value;
    if ([item isKindOfClass:[NSDictionary class]]) {
        
        value = [item yl_objectForKey:aKey];
    }else if ([item isKindOfClass:[NSString class]]){
        
        return item;
    }else if ([item isKindOfClass:[NSNumber class]]){
        
        return getStrByNub(item);
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        
        return getStrByNub(value);
    }else if ([value isKindOfClass:[NSString class]] ||
              [value isKindOfClass:[NSDictionary class]]){
        
        return value;
    }else{
        
        NSAssert(0, @"need NSNumber,NSString,NSDictionary");
    }

    return value;
}


//Zhouyouyali   TODO
//直接修改NSDictionary 的value  或者多层 NSDictionary
//.e.g :
//
//   dic:
//      {
//          key1:{
//                  key2:value
//               }
//      }
//
//   [dic setObject:obj forKeys:@"key1",@"key2",nil]

@end
