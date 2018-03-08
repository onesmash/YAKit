//
//  YACollectionViewPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YACollectionViewPresenter.h"
#import "UIView+YA.h"
#import "YAMVPProtocol.h"
#import "YACellPresenterProtocol.h"

@interface YACollectionViewPresenter ()
@property (nonatomic, weak) UICollectionView *delegate;
@end

@implementation YACollectionViewPresenter

@dynamic delegate;

- (void)viewWillAppear:(BOOL)animated
{
    NSArray<UICollectionViewCell *> *visibleCells = [self.delegate.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UICollectionViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellWillAppear:)]) {
            [presenter cellWillAppear:[self.delegate indexPathForCell:cell]];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSArray<UICollectionViewCell *> *visibleCells = [self.delegate.visibleCells sortedArrayUsingComparator:^(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
        return cell1.$top < cell2.$top ? NSOrderedAscending : NSOrderedDescending;
    }];
    for (UICollectionViewCell *cell in visibleCells) {
        id<YAMVPProtocol> mvpCell = [cell conformsToProtocol:@protocol(YAMVPProtocol)] ? (id<YAMVPProtocol>)cell : nil;
        id<YACellPresenterProtocol> presenter = mvpCell.presenter;
        if(mvpCell && [presenter respondsToSelector:@selector(cellDidDisappear:)]) {
            [presenter cellDidDisappear:[self.delegate indexPathForCell:cell]];
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

@end
