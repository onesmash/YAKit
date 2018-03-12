//
//  UITableView+YA.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/9.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMatrix2DataOpTrack.h"

@interface UITableView (YA)

- (void)ya_batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks animation:(UITableViewRowAnimation)animation completion:(void (^)(BOOL finished))completion;

@end
