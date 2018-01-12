//
//  NSObject+YAComponent.m
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "NSObject+YAComponent.h"
#import <objc/runtime.h>

static char* kComponentsKey;

@implementation NSObject (YAComponent)

- (NSMutableDictionary<NSString *, id<YAComponentProtocol>> *)ya_components
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &kComponentsKey);
    if(!dict) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &kComponentsKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    return dict;
}

- (BOOL)ya_addComponent:(id<YAComponentProtocol>)component
{
    if([self conformsToProtocol:[component requiredProtocol]]) {
        [[self ya_components] setObject:component forKey:NSStringFromProtocol([component requiredProtocol])];
        component.delegate = self;
        [component onComponentAttached];
        return YES;
    }
    return NO;
}

- (void)ya_removeComponent:(Protocol *)protocol
{
    id<YAComponentProtocol> component = [[self ya_components] objectForKey:NSStringFromProtocol(protocol)];
    component.delegate = nil;
    [[self ya_components] removeObjectForKey:NSStringFromProtocol(protocol)];
}

- (id<YAComponentProtocol>)ya_component:(Protocol *)protocol
{
    return [[self ya_components] objectForKey:NSStringFromProtocol(protocol)];
}

@end
