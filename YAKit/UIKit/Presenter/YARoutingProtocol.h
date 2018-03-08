//
//  YARoutingProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YARoutingProtocol_h
#define YARoutingProtocol_h

#import <UIKit/UIKit.h>

@protocol YARoutingProtocol <NSObject>
- (UINavigationController *)navigationController;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;
@optional
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;
@end

#endif /* YARoutingProtocol_h */
