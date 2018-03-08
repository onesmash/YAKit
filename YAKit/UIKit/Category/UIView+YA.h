//
//  UIView+YA.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YA)

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height;
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom;
@property (nonatomic, assign) CGFloat $centerX, $centerY;

@end
