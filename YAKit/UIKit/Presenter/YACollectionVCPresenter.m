//
//  YACollectionVCPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YACollectionVCPresenter.h"
#import "UIView+YA.h"
#import "YAMVPProtocol.h"
#import "YACellPresenterProtocol.h"
#import "UICollectionView+YA.h"

@interface YACollectionVCPresenter ()
@property (nonatomic, strong) NSMutableArray *pendingUpdateOps;
@property (nonatomic, assign) BOOL updating;
@end

@implementation YACollectionVCPresenter

@dynamic delegate;
@dynamic dataSource;
@dynamic interactor;

- (Protocol *)requiredProtocol
{
    return @protocol(YACollectionVCPresenterRequiredProtocol);
}

- (void)onComponentAttached
{
    _pendingUpdateOps = [NSMutableArray array];
    _updating = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray<UICollectionViewCell *> *visibleCells = [self.delegate.collectionView.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UICollectionViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
            [presenter cellWillAppear:[self.delegate.collectionView indexPathForCell:cell]];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSArray<UICollectionViewCell *> *visibleCells = [self.delegate.collectionView.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UICollectionViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
            [presenter cellDidDisappear:[self.delegate.collectionView indexPathForCell:cell]];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
    id<YACellPresenterProtocol> presenter = mvpCell.presenter;
    if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
        [presenter cellWillAppear:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
    id<YACellPresenterProtocol> presenter = mvpCell.presenter;
    if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
        [presenter cellDidDisappear:indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate) {
        UICollectionView *collectionView = (UICollectionView *)scrollView;
        if(collectionView) {
            NSArray<UICollectionViewCell *> *visibleCells = [collectionView.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
                return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
            }];
            for (UICollectionViewCell *cell in visibleCells) {
                id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
                id<YACellPresenterProtocol> presenter = mvpCell.presenter;
                if(mvpCell && [presenter respondsToSelector:@selector(cellDidEndScroll:)]) {
                    [presenter cellDidEndScroll:[collectionView indexPathForCell:cell]];
                }
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    if(collectionView) {
        NSArray<UICollectionViewCell *> *visibleCells = [collectionView.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
            return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
        }];
        for (UICollectionViewCell *cell in visibleCells) {
            id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
            id<YACellPresenterProtocol> presenter = mvpCell.presenter;
            if(mvpCell && [presenter respondsToSelector:@selector(cellDidEndScroll:)]) {
                [presenter cellDidEndScroll:[collectionView indexPathForCell:cell]];
            }
        }
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (void)batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks completion:(void (^)(void))completion
{
    if(!self.updating) {
        self.updating = YES;
        __weak typeof(self) wself = self;
        [self.delegate.collectionView ya_batchUpdate:tracks completion:^(BOOL success) {
            if(completion) {
                completion();
            }
            [wself excutePendingUpdateOp];
        }];
    } else {
        [self.pendingUpdateOps addObject:@[tracks, completion]];
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
    [self.delegate.collectionView ya_batchUpdate:ops.firstObject completion:^(BOOL success) {
        void (^completion)(void) = ops.lastObject;
        if(completion) {
            completion();
        }
        [wself excutePendingUpdateOp];
    }];
}

- (void)reloadData
{
    [self.delegate.collectionView reloadData];
}

@end
