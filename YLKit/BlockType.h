//
//  BlockType.h
//  jsb
//
//  Created by Yaali on 16/3/16.
//  Copyright © 2016年 Yaali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^block_void)();
typedef void(^block_str)(NSString *string);
typedef void(^block_dic)(NSDictionary *info);
typedef void(^block_arr)(NSArray *info);
typedef void(^block_int)(NSInteger iIntValue);
typedef void(^block_float)(CGFloat iFloat);
typedef void(^block_bool)(BOOL iBool);
typedef void(^block_btn)(UIButton *btn);
typedef void(^block_img)(UIImage *img);


typedef void(^block_dic_bool)(NSDictionary *info,BOOL iBool);

typedef BOOL(^block_returnBool)();
typedef CGFloat(^block_returnFloat)();

typedef BOOL(^block_dic_returnBool)(NSDictionary *info);
typedef NSDictionary*(^block_returnDic)();


typedef void(^block_dic_type)(NSDictionary *info,NSString *type);


//<#returnValue#> * (^ <#Block#>)(<#par#>) = ^<#returnValue#> *(<#par#>){
//    return nil;
//};

//@property (nonatomic, copy)void (^block)(BOOL) ;

//- (void)function:( void (^)(int)) block{}

//NSArray * (^ addEdge)(NSArray *) = ^NSArray *(NSArray *value){
//    return nil;
//};;
