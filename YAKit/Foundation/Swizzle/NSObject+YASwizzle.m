//
//  NSObject+YASwizzle.m
//  YAKit
//
//  Created by 徐晖 on 2018/1/12.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "NSObject+YASwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (YASwizzle)

+ (BOOL)ya_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        return NO;
    }
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)ya_swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    return [object_getClass(self) ya_swizzleMethod:origSel withMethod:altSel];
}

@end
