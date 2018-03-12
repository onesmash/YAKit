//
//  YAInteractor.m
//  IGListKit
//
//  Created by 徐晖 on 2018/3/12.
//

#import "YAInteractor.h"

@implementation YAInteractor

@synthesize presenter;
@synthesize datasource;

+ (instancetype)interactorWithPresenter:(id<YAViewPresenterProtocol>)presenter dataSource:(id)dataSource
{
    YAInteractor *interactor = [[self alloc] init];
    interactor.presenter = presenter;
    interactor.datasource = dataSource;
    return interactor;
}

@end
