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

@interface YATableViewPresenter : YAViewPresenter <YATableViewPresenterProtocol, UITableViewDelegate, UITableViewDataSource>

@end
