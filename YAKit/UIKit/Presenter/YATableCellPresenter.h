//
//  YATableCellPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAViewPresenter.h"
#import "YACellPresenterProtocol.h"
#import "YACellPresenterRequiredProtocol.h"

@interface YATableCellPresenter : YAViewPresenter <YACellPresenterProtocol>
@property (nonatomic, weak) id<YACellPresenterRequiredProtocol> delegate;
@property (nonatomic, weak, readonly) UITableView *tableView;

@end
