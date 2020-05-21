//
//  XZPerson.h
//  KVC异常小技巧
//
//  Created by Alan on 5/20/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    float x, y, z;
} ThreeFloats;

@interface XZPerson : NSObject{
    @public
    NSString *name;
    NSString *_name;
    NSString *_isName;
    NSString *isName;
    
}

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, assign) int  age;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic) ThreeFloats  threeFloats;

@end

NS_ASSUME_NONNULL_END
