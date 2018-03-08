//
//  YACellPresenterRequiredProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YACellPresenterRequiredProtocol_h
#define YACellPresenterRequiredProtocol_h

#import "YAViewPresenterRequiredProtocol.h"

@protocol YACellPresenterRequiredProtocol <YAViewPresenterRequiredProtocol>
@property (nonatomic, readonly, strong) UIView *contentView;
@end

#endif /* YACellPresenterRequiredProtocol_h */
