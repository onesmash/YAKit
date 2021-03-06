//
//  UITableView+YA.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/9.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "UITableView+YA.h"

@implementation UITableView (YA)

- (void)ya_batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks animation:(UITableViewRowAnimation)animation completion:(void (^)(BOOL finished))completion
{
    NSMutableIndexSet *insertSections = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *deleteSections = [NSMutableIndexSet indexSet];
    NSMutableArray<NSIndexPath *> *insertRows = [NSMutableArray array];
    NSMutableArray<NSIndexPath *> *deleteRows = [NSMutableArray array];
    NSMutableArray<NSIndexPath *> *reloadRows = [NSMutableArray array];
    NSMutableArray<YAMatrix2DataOpTrack *> *moveOps = [NSMutableArray array];
    [tracks enumerateObjectsUsingBlock:^(YAMatrix2DataOpTrack *track, NSUInteger index, BOOL *stop) {
        switch (track.op) {
            case YAMatrix2DataTrackOperationSectionAdd: {
                [insertSections addIndex:track.section];
            } break;
            case YAMatrix2DataTrackOperationAdd: {
                [insertRows addObject:track.pos];
            } break;
            case YAMatrix2DataTrackOperationSectionDelete: {
                [deleteSections addIndex:track.section];
            } break;
            case YAMatrix2DataTrackOperationDelete: {
                [deleteRows addObject:track.pos];
            } break;
            case YAMatrix2DataTrackOperationMove: {
                [moveOps addObject:track];
            }break;
            case YAMatrix2DataTrackOperationUpdate: {
                [reloadRows addObject:track.pos];
            } break;
            default:
                break;
        }
    }];
    [self beginUpdates];
    [self insertSections:insertSections withRowAnimation:animation];
    [self deleteSections:deleteSections withRowAnimation:animation];
    [self insertRowsAtIndexPaths:insertRows withRowAnimation:animation];
    [self deleteRowsAtIndexPaths:deleteRows withRowAnimation:animation];
    [self reloadRowsAtIndexPaths:reloadRows withRowAnimation:animation];
    for (YAMatrix2DataOpTrack *move in moveOps) {
        [self moveRowAtIndexPath:move.pos toIndexPath:move.to];
    }
    [self endUpdates];
    if(completion) {
        completion(YES);
    }
}

@end
