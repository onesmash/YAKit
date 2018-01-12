//
//  UIViewController+YAPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "UIViewController+YAPresenter.h"
#import "NSObject+YASwizzle.h"
#import "YAComponentProtocol.h"
#import "YAVCPresenterProtocol.h"
#import "NSObject+YAComponent.h"

@implementation UIViewController (YAPresenter)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ya_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(yapresenter_viewDidLoad)];
        [self ya_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(yapresenter_viewWillAppear:)];
        [self ya_swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(yapresenter_viewDidAppear:)];
        [self ya_swizzleMethod:@selector(viewWillDisappear:) withMethod:@selector(yapresenter_viewWillDisappear:)];
        [self ya_swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(yapresenter_viewDidDisappear:)];
        [self ya_swizzleMethod:@selector(viewWillLayoutSubviews) withMethod:@selector(yapresenter_viewWillLayoutSubviews)];
        [self ya_swizzleMethod:@selector(viewDidLayoutSubviews) withMethod:@selector(yapresenter_viewDidLayoutSubviews)];
    });
}

- (void)yapresenter_viewDidLoad
{
    [self yapresenter_viewDidLoad];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewDidLoad)]) {
            [component viewDidLoad];
        }
    }
}

- (void)yapresenter_viewWillAppear:(BOOL)animated
{
    [self yapresenter_viewWillAppear:animated];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewWillAppear:)]) {
            [component viewWillAppear:animated];
        }
    }
}

- (void)yapresenter_viewDidAppear:(BOOL)animated
{
    [self yapresenter_viewDidAppear:animated];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewDidAppear:)]) {
            [component viewDidAppear:animated];
        }
    }
}

- (void)yapresenter_viewWillDisappear:(BOOL)animated
{
    [self yapresenter_viewWillDisappear:animated];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewWillDisappear:)]) {
            [component viewWillDisappear:animated];
        }
    }
}

- (void)yapresenter_viewDidDisappear:(BOOL)animated
{
    [self yapresenter_viewDidDisappear:animated];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewDidDisappear:)]) {
            [component viewDidDisappear:animated];
        }
    }
}

- (void)yapresenter_viewWillLayoutSubviews
{
    [self yapresenter_viewWillLayoutSubviews];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewWillLayoutSubviews)]) {
            [component viewWillLayoutSubviews];
        }
    }
}

- (void)yapresenter_viewDidLayoutSubviews
{
    [self yapresenter_viewDidLayoutSubviews];
    for (id<YAComponentProtocol, YAVCPresenterProtocol> component in [self ya_components].allValues) {
        if([component respondsToSelector:@selector(viewDidLayoutSubviews)]) {
            [component viewDidLayoutSubviews];
        }
    }
}
@end
