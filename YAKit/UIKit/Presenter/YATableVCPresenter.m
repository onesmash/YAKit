//
//  YATableVCPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YATableVCPresenter.h"
#import "UIView+YA.h"
#import "YAMVPProtocol.h"
#import "YACellPresenterProtocol.h"

@interface YATableVCPresenter ()

@end

@implementation YATableVCPresenter

@dynamic delegate;

- (Protocol *)requiredProtocol
{
    return @protocol(YATableVCPresenterRequiredProtocol);
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray<UITableViewCell *> *visibleCells = [self.delegate.tableView.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UITableViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
            [presenter cellWillAppear:[self.delegate.tableView indexPathForCell:cell]];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSArray<UITableViewCell *> *visibleCells = [self.delegate.tableView.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UITableViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
            [presenter cellDidDisappear:[self.delegate.tableView indexPathForCell:cell]];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
    id<YACellPresenterProtocol> presenter = mvpCell.presenter;
    if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
        [presenter cellDidDisappear:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
    id<YACellPresenterProtocol> presenter = mvpCell.presenter;
    if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
        [presenter cellWillAppear:indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate) {
        UITableView *tableView = (UITableView *)scrollView;
        if(tableView) {
            NSArray<UITableViewCell *> *visibleCells = [tableView.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
                return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
            }];
            for (UITableViewCell *cell in visibleCells) {
                id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
                id<YACellPresenterProtocol> presenter = mvpCell.presenter;
                if(mvpCell && [presenter respondsToSelector:@selector(cellDidEndScroll:)]) {
                    [presenter cellDidEndScroll:[tableView indexPathForCell:cell]];
                }
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    if(tableView) {
        NSArray<UITableViewCell *> *visibleCells = [tableView.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
            return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
        }];
        for (UITableViewCell *cell in visibleCells) {
            id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
            id<YACellPresenterProtocol> presenter = mvpCell.presenter;
            if(mvpCell && [presenter respondsToSelector:@selector(cellDidEndScroll:)]) {
                [presenter cellDidEndScroll:[tableView indexPathForCell:cell]];
            }
        }
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
