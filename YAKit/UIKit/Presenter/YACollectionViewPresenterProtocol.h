//
//  YACollectionViewPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YACollectionViewPresenterProtocol_h
#define YACollectionViewPresenterProtocol_h

#import <UIKit/UIKit.h>
#import "YAScrollViewPresenterProtocol.h"

@protocol YACollectionViewPresenterProtocol <YAScrollViewPresenterProtocol>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
@end

#endif /* YACollectionViewPresenterProtocol_h */
