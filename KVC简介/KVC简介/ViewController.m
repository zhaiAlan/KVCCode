//
//  ViewController.m
//  KVC简介
//
//  Created by Alan on 5/15/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "XZPerson.h"
#import "XZStudent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *v;
    //一般的setter方法
    XZPerson *person = [[XZPerson alloc]init];
    person.name     = @"Alan";
    person.age      = 18;
    person->myName  = @"XZAlan";
    NSLog(@"%@ - %d - %@",person.name,person.age,person->myName);

    //2.key- Value  Codeing (KVC) 基本数据类型
    [person setValue:@"XZ" forKey:@"name"];
    [person setValue:@19 forKey:@"age"];
    [person setValue:@"星" forKey:@"myName"];
    NSLog(@"%@ - %d - %@",person.name,person.age,person->myName);
    
    //3： KVC 集合类型
    person.array = @[@"1",@"2",@"3"];
    // 由于不是可变数组 - 无法做到
    // person.array[0] = @"100";
    NSArray *array = [person valueForKey:@"array"];
    // 用 array 的值创建一个新的数组
    array = @[@"100",@"2",@"3"];
    [person setValue:array forKey:@"array"];
    NSLog(@"%@",[person valueForKey:@"array"]);

    // KVC 的方式,使用深拷贝地址，直接改变数组
    NSMutableArray *ma = [person mutableArrayValueForKey:@"array"];
    ma[0] = @"101";
    ma[3] = @"103";
    //可以顺序插入，如果跳过插入会导致崩溃
    //ma[5] = @"105";
    NSLog(@"%@",[person valueForKey:@"array"]);
    
//    // 3:KVC - 集合操作符
//    [self dictionaryTest];
//    [self arrayMessagePass];
//    [self aggregationOperator];
//    [self arrayOperator];
//    [self arrayNesting];
//    [self setNesting];
    [self arrayDemo];
    
     //4:KVC - 访问非对象属性
    ThreeFloats floats = {1., 2., 3.};
    //结构体需要转换成相应的NSValue
    NSValue *value  = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
    [person setValue:value forKey:@"threeFloats"];
    NSValue *reslut = [person valueForKey:@"threeFloats"];
    NSLog(@"%@",reslut);

    ThreeFloats th;
    [reslut getValue:&th] ;
    NSLog(@"%f - %f - %f",th.x,th.y,th.z);

    // 5:KVC - 层层访问
    XZStudent *student = [[XZStudent alloc] init];
    student.subject    = @"iOS";
    person.student     = student;
    [person setValue:@"iOS学习" forKeyPath:@"student.subject"];
    NSLog(@"%@",[person valueForKeyPath:@"student.subject"]);


    // Do any additional setup after loading the view.
}
#pragma mark - array取值
- (void)arrayDemo{
    XZStudent *p = [XZStudent new];
    p.penArr = [NSMutableArray arrayWithObjects:@"pen0", @"pen1", @"pen2", @"pen3", nil];
    NSArray *arr = [p valueForKey:@"penArr"]; // 动态成员变量
    NSLog(@"pens = %@", arr);
    //NSLog(@"%@",arr[0]);
    NSLog(@"%d",[arr containsObject:@"pen9"]);
    // 遍历
    NSEnumerator *enumerator = [arr objectEnumerator];
    NSString* str = nil;
    while (str = [enumerator nextObject]) {
        NSLog(@"%@", str);
    }
}
#pragma mark - 字典操作

- (void)dictionaryTest{
    
    NSDictionary* dict = @{
                           @"name":@"Alan",
                           @"nick":@"XZ",
                           @"subject":@"iOS",
                           @"age":@18,
                           @"length":@180
                           };
    XZStudent *p = [[XZStudent alloc] init];
    // 字典转模型
    [p setValuesForKeysWithDictionary:dict];
    NSLog(@"%@",p);
    // 键数组转模型到字典
    NSArray *array = @[@"name",@"age"];
    NSDictionary *dic = [p dictionaryWithValuesForKeys:array];
    NSLog(@"%@",dic);
}

#pragma mark - KVC消息传递
- (void)arrayMessagePass{
    NSArray *array = @[@"Alan",@"Xing",@"XZ",@"ZhaiAlan"];
    NSArray *lenStr= [array valueForKeyPath:@"length"];
    NSLog(@"%@",lenStr);// 消息从array传递给了string
    NSArray *lowStr= [array valueForKeyPath:@"lowercaseString"];
    NSLog(@"%@",lowStr);
}

#pragma mark - 聚合操作符
// @avg、@count、@max、@min、@sum
- (void)aggregationOperator{
    NSMutableArray *personArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        XZStudent *p = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"subject":@"iOS",
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [p setValuesForKeysWithDictionary:dict];
        [personArray addObject:p];
    }
    NSLog(@"length-->%@", [personArray valueForKey:@"length"]);
    
    /// 平均身高
    float avg = [[personArray valueForKeyPath:@"@avg.length"] floatValue];
    NSLog(@"avg-->%f", avg);
    
    int count = [[personArray valueForKeyPath:@"@count.length"] intValue];
    NSLog(@"count-->%d", count);
    
    int sum = [[personArray valueForKeyPath:@"@sum.length"] intValue];
    NSLog(@"sum--->%d", sum);
    
    int max = [[personArray valueForKeyPath:@"@max.length"] intValue];
    NSLog(@"max.lenght-->%d", max);
    
    int min = [[personArray valueForKeyPath:@"@min.length"] intValue];
    NSLog(@"min.lenght-->%d", min);
}

// 数组操作符 @distinctUnionOfObjects @unionOfObjects
- (void)arrayOperator{
    NSMutableArray *personArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        XZStudent *student = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [personArray addObject:student];
    }
    NSLog(@"%@", [personArray valueForKey:@"age"]);
    // 返回操作对象指定属性的集合
    NSArray* arr1 = [personArray valueForKeyPath:@"@unionOfObjects.age"];
    NSLog(@"@unionOfObjects.age--> %@", arr1);
    // 返回操作对象指定属性的集合 -- 去重
    NSArray* arr2 = [personArray valueForKeyPath:@"@distinctUnionOfObjects.age"];
    NSLog(@"@distinctUnionOfObjects.age--> %@", arr2);
    NSArray* arr3 = [personArray valueForKeyPath:@"@distinctUnionOfObjects.nick"];
    NSLog(@"@distinctUnionOfObjects.nick--> %@", arr3);

}

// 嵌套集合(array&set)操作 @distinctUnionOfArrays @unionOfArrays @distinctUnionOfSets
- (void)arrayNesting{
    
    NSMutableArray *studentArray1 = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        XZStudent *student = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(15+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [studentArray1 addObject:student];
    }
    
    NSMutableArray *studentArray2 = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        XZStudent *student = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [studentArray2 addObject:student];
    }
    
    // 嵌套数组
    NSArray* nestArr = @[studentArray1, studentArray2];
    
    NSArray* arr = [nestArr valueForKeyPath:@"@distinctUnionOfArrays.age"];
    NSLog(@"@distinctUnionOfArrays.age--> %@", arr);
    
    NSArray* arr1 = [nestArr valueForKeyPath:@"@unionOfArrays.age"];
    NSLog(@"@unionOfArrays.age--> %@", arr1);
}

- (void)setNesting{
    
    NSMutableSet *studentSet1 = [NSMutableSet set];
    for (int i = 0; i < 5; i++) {
        XZStudent *student = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(15+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [studentSet1 addObject:student];
    }
    NSLog(@"studentSet1 = %@", [studentSet1 valueForKey:@"length"]);
    
    NSMutableSet *studentSet2 = [NSMutableSet set];
    for (int i = 0; i < 5; i++) {
        XZStudent *student = [XZStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [studentSet2 addObject:student];
    }
    NSLog(@"studentSet2 = %@", [studentSet2 valueForKey:@"length"]);

    // 嵌套set
    NSSet* nestSet = [NSSet setWithObjects:studentSet1, studentSet2, nil];
    // 并集
    NSSet* set1 = [nestSet valueForKeyPath:@"@distinctUnionOfSets.age"];
    NSLog(@"@distinctUnionOfSets.age--> %@", set1);
    
}



@end
