//
//  YAComponent.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAComponentProtocol.h"

@interface YAComponent : NSObject <YAComponentProtocol>

@property (nonatomic, weak) id delegate;

@end
