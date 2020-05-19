//
//  ViewController.m
//  KVC赋值过程&取值过程
//
//  Created by Alan on 5/15/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "XZPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XZPerson *person = [XZPerson new];
//    1: KVC - 设置值的过程
//    [person setValue:@"XZ_Alan" forKey:@"name"];
    
//    NSLog(@"%@-%@-%@-%@",person->_name,person->_isName,person->name,person->isName);
//    NSLog(@"%@-%@-%@",person->_isName,person->name,person->isName);
//    NSLog(@"%@-%@",person->name,person->isName);
//    NSLog(@"%@",person->isName);

    // 2: KVC - 取值的过程
//     person->_name = @"赋值_name";
//     person->_isName = @"赋值_isName";
//     person->name = @"赋值name";
//     person->isName = @"赋值isName";

//     NSLog(@"取值:%@",[person valueForKey:@"name"]);

    [self arraysAndSet];
    // Do any additional setup after loading the view.
}


- (void)arraysAndSet{
    
    XZPerson *person = [[XZPerson alloc] init];
    // 3: KVC - 集合类型
    person.arr = @[@"pen0", @"pen1", @"pen2", @"pen3"];
    NSArray *array = [person valueForKey:@"pens"];
    NSLog(@"%@",[array objectAtIndex:1]);
    NSLog(@"%d",[array containsObject:@"pen1"]);
    
    // set 集合
    
    person.set = [NSSet setWithArray:person.arr];
    NSSet *set = [person valueForKey:@"books"];
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"set遍历 %@",obj);
    }];
}

@end
