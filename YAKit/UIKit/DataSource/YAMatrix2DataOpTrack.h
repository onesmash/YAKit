//
//  YAMatrix2DataOpTrack.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    YAMatrix2DataTrackOperationAdd,
    YAMatrix2DataTrackOperationDelete,
    YAMatrix2DataTrackOperationMove,
    YAMatrix2DataTrackOperationUpdate
} YAMatrix2DataTrackOperation;

@interface YAMatrix2DataOpTrack : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSIndexPath *pos;
@property (nonatomic, assign) YAMatrix2DataTrackOperation op;
@property (nonatomic, strong) NSIndexPath *to;

+ (instancetype)opTrack:(YAMatrix2DataTrackOperation)op data:(id)data pos:(NSIndexPath *)pos to:(NSIndexPath *)to;

@end
