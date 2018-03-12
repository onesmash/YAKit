//
//  YATableViewPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAComponent.h"
#import "YAViewPresenter.h"
#import "YATableViewPresenterProtocol.h"
#import "YAMatrix2DataSource.h"
#import "YATableViewInteractor.h"

@interface YATableViewPresenter : YAViewPresenter <YATableViewPresenterProtocol, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) YAMatrix2DataSource *dataSource;
@property (nonatomic, strong) YATableViewInteractor *interactor;
@end
