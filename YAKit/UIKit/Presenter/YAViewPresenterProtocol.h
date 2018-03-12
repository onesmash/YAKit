//
//  YAViewPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YAViewPresenterProtocol_h
#define YAViewPresenterProtocol_h

#import "YARoutingProtocol.h"

@protocol YAViewPresenterProtocol <NSObject>
@property (nonatomic, strong) id interactor;
@property (nonatomic, strong) id<YARoutingProtocol> router;
@property (nonatomic, strong) id dataSource;
@optional
- (void)layoutSubviews;
@end

#endif /* YAViewPresenterProtocol_h */
