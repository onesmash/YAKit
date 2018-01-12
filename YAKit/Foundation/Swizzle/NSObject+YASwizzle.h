//
//  NSObject+YASwizzle.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/12.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YASwizzle)

+ (BOOL)ya_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)ya_swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end
