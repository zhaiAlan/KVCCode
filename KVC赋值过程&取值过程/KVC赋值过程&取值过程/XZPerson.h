//
//  XZPerson.h
//  KVC赋值过程&取值过程
//
//  Created by Alan on 5/15/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZPerson : NSObject{
    @public
     NSString *_name;
     NSString *_isName;
     NSString *name;
     NSString *isName;
}

@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSSet   *set;

@property (nonatomic, strong) NSMutableArray        *namesArrM;
@property (nonatomic, strong) NSMutableSet          *namesSetM;
@property (nonatomic, strong) NSMutableOrderedSet   *orderedSetM;

@end

NS_ASSUME_NONNULL_END
