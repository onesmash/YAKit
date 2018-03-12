//
//  YACollectionVCPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAViewPresenter.h"
#import "YARoutingProtocol.h"
#import "YAVCPresenterProtocol.h"
#import "YACollectionViewPresenterProtocol.h"
#import "YAMatrix2DataSource.h"
#import "YACollectionVCInteractor.h"

@protocol YACollectionVCPresenterRequiredProtocol <YAViewPresenterRequiredProtocol, YARoutingProtocol>
@property (nonatomic, readonly) UICollectionView *collectionView;
@end

@interface YACollectionVCPresenter : YAViewPresenter <YAVCPresenterProtocol, YACollectionViewPresenterProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<YACollectionVCPresenterRequiredProtocol> delegate;
@property (nonatomic, strong) YAMatrix2DataSource *dataSource;
@property (nonatomic, strong) YACollectionVCInteractor *interactor;

@end
