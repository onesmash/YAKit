//
//  YAComponentProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YAComponentProtocol_h
#define YAComponentProtocol_h

@protocol YAComponentProtocol <NSObject>
@property (nonatomic, weak) id delegate;
- (Protocol *)requiredProtocol;
- (void)onComponentAttached;
@end

#endif /* YAComponentProtocol_h */
