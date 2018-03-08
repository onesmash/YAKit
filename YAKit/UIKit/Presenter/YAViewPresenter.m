//
//  YAViewPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAViewPresenter.h"

@interface YAViewPresenter ()

@end

@implementation YAViewPresenter

@synthesize interactor;
@synthesize router;
@synthesize dataSource;
@dynamic delegate;

- (Protocol *)requiredProtocol
{
    return @protocol(YAViewPresenterRequiredProtocol);
}

@end
