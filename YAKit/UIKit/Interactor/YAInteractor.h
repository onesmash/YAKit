//
//  YAInteractor.h
//  IGListKit
//
//  Created by 徐晖 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "YAViewPresenterProtocol.h"

@protocol YAInteractorProtocol <NSObject>
@property (nonatomic, weak) id<YAViewPresenterProtocol> presenter;
@property (nonatomic, strong) id datasource;
+ (instancetype)interactorWithPresenter:(id<YAViewPresenterProtocol>)presenter dataSource:(id)dataSource;
@end

@interface YAInteractor : NSObject <YAInteractorProtocol>

@end
