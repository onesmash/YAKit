//
//  YAVCPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/1/11.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YAVCPresenterProtocol_h
#define YAVCPresenterProtocol_h

@protocol YAVCPresenterProtocol <NSObject>
@optional
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

- (void)viewWillLayoutSubviews;

- (void)viewDidLayoutSubviews;
@end

#endif /* YAVCPresenterProtocol_h */
