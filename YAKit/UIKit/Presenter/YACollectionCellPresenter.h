//
//  YACollectionCellPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAComponent.h"
#import "YAViewPresenter.h"
#import "YACellPresenterProtocol.h"
#import "YACellPresenterRequiredProtocol.h"

@interface YACollectionCellPresenter : YAViewPresenter <YACellPresenterProtocol>
@property (nonatomic, weak) id<YACellPresenterRequiredProtocol> delegate;
@property (nonatomic, weak, readonly) UICollectionView *collectionView;

@end
