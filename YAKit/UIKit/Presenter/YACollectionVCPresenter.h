//
//  YACollectionVCPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAComponent.h"
#import "YARoutingProtocol.h"
#import "YAVCPresenterProtocol.h"
#import "YACollectionViewPresenterProtocol.h"

@protocol YACollectionVCPresenterRequiredProtocol <YARoutingProtocol>
@property (nonatomic, readonly) UICollectionView *collectionView;
@end

@interface YACollectionVCPresenter : YAComponent <YAVCPresenterProtocol, YACollectionViewPresenterProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<YACollectionVCPresenterRequiredProtocol> delegate;

@end
