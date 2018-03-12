//
//  YAMatrix2DataSource.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAMatrix2DataSource.h"
#import "YAMatrix2DataOpTrack.h"
#import <UIKit/UIKit.h>

@interface YAMatrix2DataSource ()

@end

@implementation YAMatrix2DataSource

- (instancetype)init
{
    self = [super init];
    if(self) {
        _store = [NSMutableArray array];
    }
    return self;
}

- (YAMatrix2DataOpTrack *)insertData:(id)data at:(NSIndexPath *)indexPath
{
    YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack addOpTrackData:data pos:indexPath];
    [self excuteDataOp:track];
    return track;
}

- (NSArray<YAMatrix2DataOpTrack *> *)addData:(NSArray *)datas at:(NSInteger)section
{
    if(section > self.store.count) return nil;
    if(section == self.store.count) {
        [self.store addObject:[NSMutableArray array]];
        YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack sectionAddOpTrackData:datas section:section];
        [self excuteDataOp:track];
        return @[track];
    } else {
        NSMutableArray<YAMatrix2DataOpTrack *> *tracks = [NSMutableArray array];
        for (id data in datas) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.store objectAtIndex:section].count inSection:section];
            YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack addOpTrackData:data pos:indexPath];
            [self excuteDataOp:track];
            [tracks addObject:track];
        }
        return tracks;
    }
}

- (NSArray<YAMatrix2DataOpTrack *> *)deleteDataAt:(NSSet<NSIndexPath *> *)indexPaths
{
    NSMutableArray<YAMatrix2DataOpTrack *> *tracks = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack deleteOpTrackAtPos:indexPath];
        [self excuteDataOp:track];
        [tracks addObject:track];
    }
    return tracks;
}

- (YAMatrix2DataOpTrack *)deleteDataAtSection:(NSInteger)section
{
    YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack sectionDeleteOpTrackAtSection:section];
    [self excuteDataOp:track];
    return track;
}

- (NSArray *)dataAtSection:(NSInteger)section
{
    return [self.store objectAtIndex:section];
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.store objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSArray<YAMatrix2DataOpTrack *> *)updateDataAt:(NSSet<NSIndexPath *> *)indexPaths
{
    NSMutableArray<YAMatrix2DataOpTrack *> *tracks = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack updateOpTrackAt:indexPath];
        [self excuteDataOp:track];
        [tracks addObject:track];
    }
    return tracks;
}

- (YAMatrix2DataOpTrack *)moveDataFrom:(NSIndexPath *)from to:(NSIndexPath *)to
{
    YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack moveOpTrackFrom:from to:to];
    [self excuteDataOp:track];
    return track;
}

- (void)excuteDataOp:(YAMatrix2DataOpTrack *)opTrack
{
    switch (opTrack.op) {
        case YAMatrix2DataTrackOperationAdd: {
            [self excuteAdd:opTrack.data.firstObject at:opTrack.pos];
        } break;
        case YAMatrix2DataTrackOperationSectionAdd: {
            [self excuteSectionAdd:opTrack.data section:opTrack.section];
        } break;
        case YAMatrix2DataTrackOperationDelete: {
            [self excuteDelete:opTrack.pos];
        } break;
        case YAMatrix2DataTrackOperationSectionDelete: {
            [self excuteSectionDelete:opTrack.section];
        } break;
        case YAMatrix2DataTrackOperationMove: {
            [self excuteMoveFrom:opTrack.pos to:opTrack.to];
        } break;
        case YAMatrix2DataTrackOperationUpdate: {
            [self excuteUpdate:opTrack.pos];
        } break;
        default:
            break;
    }
}

- (void)excuteAdd:(id)data at:(NSIndexPath *)pos
{
    [[self.store objectAtIndex:pos.section] insertObject:data atIndex:pos.row];
}

- (void)excuteSectionAdd:(NSArray *)datas section:(NSInteger)section
{
    [[self.store objectAtIndex:section] addObjectsFromArray:datas];
}

- (void)excuteDelete:(NSIndexPath *)pos
{
    [[self.store objectAtIndex:pos.section] removeObjectAtIndex:pos.row];
}

- (void)excuteSectionDelete:(NSInteger)section
{
    [self.store removeObjectAtIndex:section];
}

- (void)excuteMoveFrom:(NSIndexPath *)from to:(NSIndexPath *)to
{
    NSMutableArray *sectionData = [self.store objectAtIndex:from.section];
    id data = [sectionData objectAtIndex:from.row];
    [sectionData removeObjectAtIndex:from.row];
    [self excuteAdd:data at:to];
}

- (void)excuteUpdate:(NSIndexPath *)pos
{
    
}

@end
