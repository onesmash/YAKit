//
//  YACollectionCellPresenter.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YACollectionCellPresenter.h"

@interface YACollectionCellPresenter ()
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation YACollectionCellPresenter

@synthesize indexPath;
@dynamic delegate;

- (Protocol *)requiredProtocol
{
    return @protocol(YACellPresenterRequiredProtocol);
}

#pragma mark - YACellPresenterProtocol
- (void)cellDidDisappear:(NSIndexPath *)indexPath
{
    self.collectionView = nil;
    self.indexPath = nil;
}

- (void)cellWillAppear:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    UIView *superView = self.delegate.superview;
    for (; ; ) {
        if(superView == nil || [superView isKindOfClass:[UICollectionView class]]) {
            self.collectionView = (UICollectionView *)superView;
            break;
        } else {
            superView = superView.superview;
        }
    }
}

@end
