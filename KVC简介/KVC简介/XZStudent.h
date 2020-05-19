//
//  XZStudent.h
//  KVC简介
//
//  Created by Alan on 5/15/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZStudent : NSObject
@property (nonatomic, copy)   NSString          *name;
@property (nonatomic, copy)   NSString          *subject;
@property (nonatomic, copy)   NSString          *nick;
@property (nonatomic, assign) int               age;
@property (nonatomic, assign) int               length;
@property (nonatomic, strong) NSMutableArray    *penArr;
@end

NS_ASSUME_NONNULL_END
