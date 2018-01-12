//
//  UIView+YAPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "UIView+YAPresenter.h"
#import "NSObject+YASwizzle.h"
#import "YAComponentProtocol.h"
#import "YAViewPresenterProtocol.h"
#import "NSObject+YAComponent.h"

@implementation UIView (YAPresenter)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ya_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(yapresenter_layoutSubviews)];
    });
}

- (void)yapresenter_layoutSubviews
{
    [self yapresenter_layoutSubviews];
    for (id<YAComponentProtocol, YAViewPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(layoutSubviews)]) {
            [component layoutSubviews];
        }
    }
}

@end
