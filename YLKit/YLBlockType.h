//
//  Created by Yaali on 15/4/18.
//  Copyright © 2015年 Yaali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^yl_block_Void)   ();
typedef void(^yl_block_Int)    (NSInteger integerValue);
typedef void(^yl_block_Float)  (CGFloat floatValue);
typedef void(^yl_block_Bool)   (BOOL boolValue);

typedef void(^yl_block_Str) (NSString *string);
typedef void(^yl_block_Dic)    (NSDictionary *dictionary);
typedef void(^yl_block_Arr)    (NSArray *array);

typedef void(^yl_block_Btn)    (UIButton *button);
typedef void(^yl_block_Img)    (UIImage *image);

typedef BOOL                (^yl_blockR_Bool) ();
typedef CGFloat             (^yl_blockR_Float)();
typedef NSDictionary *      (^yl_blockR_Dic)  ();


typedef void(^yl_blockDic_Bool)       (NSDictionary *info,BOOL iBool);
typedef BOOL(^yl_blockDic_ReturnBool) (NSDictionary *info);


typedef void(^yl_blockdic_type)(NSDictionary *info,NSString *type);




// <#return#> * (^ <#Block#>)(<#par#>) = ^<#return#> *(<#par#>){
//     return <#return#>;
// };


// @property (nonatomic, copy) <#return#> (^<#Block#>)(<#par#>) ;

// -(<#return#>)<#Function#>:( <#return#> (^)(<#par#>)) <#Block#>{}

