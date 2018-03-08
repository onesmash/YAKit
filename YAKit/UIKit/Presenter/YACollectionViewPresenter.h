//
//  YACollectionViewPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAComponent.h"
#import "YARoutingProtocol.h"
#import "YAVCPresenterProtocol.h"
#import "YACollectionViewPresenterProtocol.h"

@interface YACollectionViewPresenter : YAComponent <YACollectionViewPresenterProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@end
