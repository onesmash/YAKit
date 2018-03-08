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
    track.data = data;
    track.op = op;
    track.pos = pos;
    track.to = to;
    return track;
}

@end
