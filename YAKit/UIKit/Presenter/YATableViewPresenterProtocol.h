//
//  YATableViewPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YATableViewPresenterProtocol_h
#define YATableViewPresenterProtocol_h

#import <UIKit/UIKit.h>
#import "YAMatrix2DataOpTrack.h"
#import "YAScrollViewPresenterProtocol.h"

@protocol YATableViewPresenterProtocol <YAScrollViewPresenterProtocol>
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void)batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks animation:(UITableViewRowAnimation)animation completion:(void(^)(void))completion;
- (void)reloadData;
@end

#endif /* YATableViewPresenterProtocol_h */
