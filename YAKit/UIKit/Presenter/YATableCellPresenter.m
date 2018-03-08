//
//  YATableCellPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YATableCellPresenter.h"

@interface YATableCellPresenter ()
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation YATableCellPresenter

@synthesize indexPath;
@dynamic delegate;

- (Protocol *)requiredProtocol
{
    return @protocol(YACellPresenterRequiredProtocol);
}

#pragma mark - YACellPresenterProtocol
- (void)cellDidDisappear:(NSIndexPath *)indexPath
{
    self.tableView = nil;
    self.indexPath = nil;
}

- (void)cellWillAppear:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    UIView *superView = self.delegate.superview;
    for (; ; ) {
        if(superView == nil || [superView isKindOfClass:[UITableView class]]) {
            self.tableView = (UITableView *)superView;
            break;
        } else {
            superView = superView.superview;
        }
    }
}

@end
