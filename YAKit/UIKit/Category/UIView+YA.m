//
//  UIView+YA.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "UIView+YA.h"

@implementation UIView (YA)
- (CGPoint)$origin
{
    return self.frame.origin;
}

- (void)set$origin:(CGPoint)origin
{
    self.frame = (CGRect){ .origin=origin, .size=self.frame.size };
}

- (CGFloat)$x
{
    return self.frame.origin.x;
}

- (void)set$x:(CGFloat)x
{
    self.frame = (CGRect){ .origin.x=x, .origin.y=self.frame.origin.y, .size=self.frame.size };
}

- (CGFloat)$y
{
    return self.frame.origin.y;
}

- (void)set$y:(CGFloat)y
{
    self.frame = (CGRect){ .origin.x=self.frame.origin.x, .origin.y=y, .size=self.frame.size };
}

- (CGSize)$size
{
    return self.frame.size;
}

- (void)set$size:(CGSize)size
{
    self.frame = (CGRect){ .origin=self.frame.origin, .size=size };
}

- (CGFloat)$width
{
    return self.frame.size.width;
}

- (void)set$width:(CGFloat)width
{
    self.frame = (CGRect){ .origin=self.frame.origin, .size.width=width, .size.height=self.frame.size.height };
}

- (CGFloat)$height
{
    return self.frame.size.height;
}

- (void)set$height:(CGFloat)height
{
    self.frame = (CGRect){ .origin=self.frame.origin, .size.width=self.frame.size.width, .size.height=height };
}

- (CGFloat)$left
{
    return self.frame.origin.x;
}

- (void)set$left:(CGFloat)left
{
    self.frame = (CGRect){ .origin.x=left, .origin.y=self.frame.origin.y, .size=self.frame.size };
}

- (CGFloat)$top
{
    return self.frame.origin.y;
}

- (void)set$top:(CGFloat)top
{
    self.frame = (CGRect){ .origin.x=self.frame.origin.x, .origin.y=top, .size=self.frame.size };
}

- (CGFloat)$right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)set$right:(CGFloat)right
{
    self.frame = (CGRect){ .origin.x=right - self.frame.size.width, .origin.y=self.frame.origin.y, .size = self.frame.size};
}

- (CGFloat)$bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)set$bottom:(CGFloat)bottom
{
    self.frame = (CGRect){ .origin.x=self.frame.origin.x, .origin.y=bottom - self.frame.size.height,.size=self.frame.size };
}

- (CGFloat)$centerX
{
    return self.$left + self.$width / 2;
}

- (void)set$centerX:(CGFloat)centerX
{
    self.$left = centerX - self.$width / 2;
}

- (CGFloat)$centerY
{
    return self.$top + self.$height / 2;
}

- (void)set$centerY:(CGFloat)centerY
{
    self.$top = centerY - self.$height / 2;
}

@end
