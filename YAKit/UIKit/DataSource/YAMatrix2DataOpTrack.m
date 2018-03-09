//
//  YAMatrix2DataOpTrack.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAMatrix2DataOpTrack.h"

@implementation YAMatrix2DataOpTrack

+ (instancetype)opTrack:(YAMatrix2DataTrackOperation)op data:(id)data pos:(NSIndexPath *)pos to:(NSIndexPath *)to
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.data = @[data];
    track.op = op;
    track.pos = pos;
    track.to = to;
    return track;
}

+ (instancetype)addOpTrackData:(id)data pos:(NSIndexPath *)pos
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationAdd;
    track.data = @[data];
    track.pos = pos;
    return track;
}

+ (instancetype)sectionAddOpTrackData:(NSArray *)datas section:(NSInteger)section
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationSectionAdd;
    track.data = datas;
    track.section = section;
    return track;
}

+ (instancetype)deleteOpTrackAtPos:(NSIndexPath *)pos
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationDelete;
    track.pos = pos;
    return track;
}

+ (instancetype)sectionDeleteOpTrackAtSection:(NSInteger)section
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationSectionDelete;
    track.section = section;
    return track;
}

+ (instancetype)moveOpTrackFrom:(NSIndexPath *)from to:(NSIndexPath *)to
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationMove;
    track.pos = from;
    track.to = to;
    return track;
}

+ (instancetype)updateOpTrackAt:(NSIndexPath *)pos
{
    YAMatrix2DataOpTrack *track = [[YAMatrix2DataOpTrack alloc] init];
    track.op = YAMatrix2DataTrackOperationUpdate;
    track.pos = pos;
    return track;
}

@end
