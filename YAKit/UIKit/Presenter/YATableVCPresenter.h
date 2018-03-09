//
//  YATableVCPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAViewPresenter.h"
#import "YARoutingProtocol.h"
#import "YAVCPresenterProtocol.h"
#import "YATableViewPresenterProtocol.h"

@protocol YATableVCPresenterRequiredProtocol <YAViewPresenterRequiredProtocol, YARoutingProtocol>
@property (nonatomic, readonly) UITableView *tableView;
@end

@interface YATableVCPresenter : YAViewPresenter <YAVCPresenterProtocol, YATableViewPresenterProtocol, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<YATableVCPresenterRequiredProtocol> delegate;
@end
