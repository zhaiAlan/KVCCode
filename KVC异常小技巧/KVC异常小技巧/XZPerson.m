//
//  XZPerson.m
//  KVC异常小技巧
//
//  Created by Alan on 5/20/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "XZPerson.h"

@implementation XZPerson
- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"你傻不傻: 设置 %@ 是空值",key);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"你瞎啊: %@ 没有这个key",key);
}

- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"你瞎啊: %@ 没有这个key - 给你一个其他的吧,别奔溃了!",key);
    return @"Master 牛逼";
}
//
//MARK: - 键值验证 - 容错 - 派发 - 消息转发

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing  _Nullable *)outError{
    if([inKey isEqualToString:@"names"]){
        [self setValue:[NSString stringWithFormat:@"里面修改一下: %@",*ioValue] forKey:@"subject"];
        return YES;
    }
    *outError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%@ 不是 %@ 的属性",inKey,self] code:10088 userInfo:nil];
    return NO;
}

@end
