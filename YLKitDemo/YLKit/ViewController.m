//
//  ViewController.m
//  YLKit
//
//  Created by zhouyouyali on 2017/4/26.
//  Copyright © 2017年 Yaali. All rights reserved.
//

#import "ViewController.h"
#import "YLKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    [v1 setBackgroundColor:[UIColor blueColor]];
 
    [[self view] yl_autoLayoutByItem:@[v1]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
