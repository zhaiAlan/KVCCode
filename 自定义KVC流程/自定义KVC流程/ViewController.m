//
//  ViewController.m
//  自定义KVC流程
//
//  Created by Alan on 5/20/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "XZPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XZPerson *p = [[XZPerson alloc]init];
    
    [p setValue:nil forKey:nil];
    // Do any additional setup after loading the view.
}


@end
