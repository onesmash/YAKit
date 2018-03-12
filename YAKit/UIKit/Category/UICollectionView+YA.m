//
//  UICollectionView+YA.m
//  IGListKit
//
//  Created by 徐晖 on 2018/3/12.
//

#import "UICollectionView+YA.h"

@implementation UICollectionView (YA)

- (void)ya_batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks completion:(void (^)(BOOL finished))completion;
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
    [self performBatchUpdates:^() {
        [self insertSections:insertSections];
        [self deleteSections:deleteSections];
        [self insertItemsAtIndexPaths:insertRows];
        [self deleteItemsAtIndexPaths:deleteRows];
        [self reloadItemsAtIndexPaths:reloadRows];
        for (YAMatrix2DataOpTrack *move in moveOps) {
            [self moveItemAtIndexPath:move.pos toIndexPath:move.to];
        }
        
    } completion:completion];
}

@end
