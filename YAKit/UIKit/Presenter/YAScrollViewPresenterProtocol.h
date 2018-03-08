//
//  YAScrollViewPresenterProtocol.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#ifndef YAScrollViewPresenterProtocol_h
#define YAScrollViewPresenterProtocol_h

#import <UIKit/UIKit.h>

@protocol YAScrollViewPresenterProtocol <NSObject>
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end


#endif /* YAScrollViewPresenterProtocol_h */
