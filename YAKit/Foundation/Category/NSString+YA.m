//
//  NSString+YA.m
//  YAKit
//
//  Created by Xuhui on 04/03/2018.
//  Copyright © 2018 徐晖. All rights reserved.
//

#import "NSString+YA.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YA)

- (NSString *)ya_md5
{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    return [output copy];
}

@end
