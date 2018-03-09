//
//  UITableView+YA.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/9.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "UITableView+YA.h"

@implementation UITableView (YA)

- (void)ya_batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks completion:(void (^)(BOOL finished))completion
{
    [self beginUpdates];
}

@end
