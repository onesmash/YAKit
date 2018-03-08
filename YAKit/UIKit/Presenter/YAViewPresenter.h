//
//  YAViewPresenter.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAComponent.h"
#import "YAViewPresenterProtocol.h"
#import "YAViewPresenterRequiredProtocol.h"

@interface YAViewPresenter : YAComponent <YAViewPresenterProtocol>
@property (nonatomic, weak) id<YAViewPresenterRequiredProtocol> delegate;
@end
