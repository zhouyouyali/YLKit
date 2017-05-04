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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 40)];
    [v1 setBackgroundColor:[UIColor blueColor]];
 
    [[self view] yl_autoLayoutByItem:@[v1]];
//    
//    [v1 setYl_tapGesture:^{
//        NSLog(@"xxx");
//    }];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setImage:YLImg(@"btn") forState:UIControlStateNormal];
    [btn yl_changeType:YLButtonArrangeType2 space:10.f];
    [[self view] addSubview:btn];
    [btn setCenter:CGCenterView(self.view)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
