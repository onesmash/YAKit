//
//  YATableViewPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YATableViewPresenter.h"
#import "UIView+YA.h"
#import "YAMVPProtocol.h"
#import "YACellPresenterProtocol.h"
#import "UITableView+YA.h"

@interface YATableViewPresenter ()
@property (nonatomic, weak) UITableView *delegate;
@property (nonatomic, strong) NSMutableArray *pendingUpdateOps;
@property (nonatomic, assign) BOOL updating;
@end

@implementation YATableViewPresenter

@dynamic delegate;
@dynamic dataSource;
@dynamic interactor;

- (void)onComponentAttached
{
    _pendingUpdateOps = [NSMutableArray array];
    _updating = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray<UITableViewCell *> *visibleCells = [self.delegate.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UITableViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
            [presenter cellWillAppear:[self.delegate indexPathForCell:cell]];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSArray<UITableViewCell *> *visibleCells = [self.delegate.visibleCells sortedArrayUsingComparator:^(UITableViewCell *cell1, UITableViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UITableViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
            [presenter cellDidDisappear:[self.delegate indexPathForCell:cell]];
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

- (void)batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks animation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion
{
    if(!self.updating) {
        self.updating = YES;
        __weak typeof(self) wself = self;
        [self.delegate ya_batchUpdate:tracks animation:animation completion:^(BOOL success) {
            if(completion) {
                completion();
            }
            [wself excutePendingUpdateOp];
        }];
    } else {
        [self.pendingUpdateOps addObject:@[tracks, @(animation), completion]];
    }
}

- (void)excutePendingUpdateOp
{
    if(self.pendingUpdateOps.count <= 0) {
        self.updating = NO;
    }
    NSArray *ops = self.pendingUpdateOps.firstObject;
    [self.pendingUpdateOps removeObjectAtIndex:0];
    __weak typeof(self) wself = self;
    [self.delegate ya_batchUpdate:ops.firstObject animation:[[ops objectAtIndex:1] integerValue] completion:^(BOOL success) {
        void (^completion)(void) = ops.lastObject;
        if(completion) {
            completion();
        }
        [wself excutePendingUpdateOp];
    }];
}

- (void)reloadData
{
    [self.delegate reloadData];
}
@end
