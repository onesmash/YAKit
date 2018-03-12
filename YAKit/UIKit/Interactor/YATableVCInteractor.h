//
//  YATableVCInteractor.h
//  IGListKit
//
//  Created by 徐晖 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "YAInteractor.h"
#import "YAMatrix2DataSource.h"

@class YATableVCPresenter;

@interface YATableVCInteractor : YAInteractor

@property (nonatomic, weak) YATableVCPresenter *presenter;
@property (nonatomic, strong) YAMatrix2DataSource *dataSource;

@end
