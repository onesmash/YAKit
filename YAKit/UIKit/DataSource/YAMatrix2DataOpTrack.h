//
//  YAMatrix2DataOpTrack.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    YAMatrix2DataTrackOperationSectionAdd,
    YAMatrix2DataTrackOperationAdd,
    YAMatrix2DataTrackOperationSectionDelete,
    YAMatrix2DataTrackOperationDelete,
    YAMatrix2DataTrackOperationMove,
    YAMatrix2DataTrackOperationUpdate
} YAMatrix2DataTrackOperation;

@interface YAMatrix2DataOpTrack : NSObject

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSIndexPath *pos;
@property (nonatomic, assign) YAMatrix2DataTrackOperation op;
@property (nonatomic, strong) NSIndexPath *to;

+ (instancetype)addOpTrackData:(id)data pos:(NSIndexPath *)pos;
+ (instancetype)sectionAddOpTrackData:(NSArray *)datas section:(NSInteger)section;
+ (instancetype)deleteOpTrackAtPos:(NSIndexPath *)pos;
+ (instancetype)sectionDeleteOpTrackAtSection:(NSInteger)section;
+ (instancetype)moveOpTrackFrom:(NSIndexPath *)from to:(NSIndexPath *)to;
+ (instancetype)updateOpTrackAt:(NSIndexPath *)pos;

@end
