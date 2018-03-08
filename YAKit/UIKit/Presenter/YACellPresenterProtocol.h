//
//  YACellPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YACellPresenterProtocol_h
#define YACellPresenterProtocol_h

#import "YAViewPresenterProtocol.h"

@protocol YACellPresenterProtocol <YAViewPresenterProtocol>
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)cellWillAppear:(NSIndexPath *)indexPath;
- (void)cellDidDisappear:(NSIndexPath *)indexPath;
@optional
- (void)cellDidEndScroll:(NSIndexPath *)indexPath;
@end

#endif /* YACellPresenterProtocol_h */
