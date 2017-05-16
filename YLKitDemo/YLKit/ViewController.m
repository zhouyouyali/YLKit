//
//  ViewController.m
//  YLKit
//
//  Created by zhouyouyali on 2017/4/26.
//  Copyright © 2017年 Yaali. All rights reserved.
//

#import "ViewController.h"
#import "YLKit.h"
#import "UIView+YLKit.h"
#import "UIButton+YLKit.h"


#import "YLSegmentView.h"

@interface ViewController ()

@property (nonatomic, strong) YLSegmentView *segView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    
    _segView = [[YLSegmentView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
