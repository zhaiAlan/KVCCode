//
//  NSObject+XZKVC.h
//  自定义KVC流程
//
//  Created by Alan on 5/20/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XZKVC)
// XZ KVC 自定义入口
- (void)xz_setValue:(nullable id)value forKey:(NSString *)key;
//
- (nullable id)xz_valueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
