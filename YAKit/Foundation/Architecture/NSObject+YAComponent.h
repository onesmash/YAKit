//
//  NSObject+YAComponent.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAComponentProtocol.h"

@interface NSObject (YAComponent)

- (NSMutableDictionary<NSString *, id<YAComponentProtocol>> *)ya_components;
- (BOOL)ya_addComponent:(id<YAComponentProtocol>)component;
- (void)ya_removeComponent:(Protocol *)protocol;
- (id<YAComponentProtocol>)ya_component:(Protocol *)protocol;

@end
