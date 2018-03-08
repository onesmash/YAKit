//
//  YAMatrix2DataSource.m
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import "YAMatrix2DataSource.h"
#import "YAMatrix2DataOpTrack.h"

@interface YAMatrix2DataSource ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *store;
@property (nonatomic, strong) NSMutableArray<YAMatrix2DataOpTrack *> *opBatch;
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

- (void)insertData:(id)data at:(NSIndexPath *)indexPath
{
    YAMatrix2DataOpTrack *track = [YAMatrix2DataOpTrack opTrack:YAMatrix2DataTrackOperationAdd data:data pos:indexPath to:nil];
    [self addDataOp:track];
}

- (void)addData:(NSArray *)datas at:(NSInteger)section
{
    //NSInteger index =
    for (id data in datas) {
        
    }
}

- (void)deleteDataAt:(NSSet<NSIndexPath *> *)indexPaths
{
    
}

- (NSArray *)dataAtSection:(NSInteger)section
{
    
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)updateDataAt:(NSSet<NSIndexPath *> *)indexPaths
{
    
}

- (void)moveDataFrom:(NSIndexPath *)from to:(NSIndexPath *)to
{
    
}

- (void)batchDataUpdate:(void(^)(void))updateBlock completion:(void(^)(void))completionBlock
{
    
}

- (void)addDataOp:(YAMatrix2DataOpTrack *)opTrack
{
    if(self.opBatch != nil) {
        [self.opBatch addObject:opTrack];
    } else {
        [self excuteDataOp:opTrack];
    }
}

- (void)excuteDataOp:(YAMatrix2DataOpTrack *)opTrack
{
    
}

@end
