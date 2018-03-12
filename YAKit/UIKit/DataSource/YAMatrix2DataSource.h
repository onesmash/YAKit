//
//  YAMatrix2DataSource.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMatrix2DataOpTrack.h"

@protocol YAMatrix2DataSource <NSObject>
- (YAMatrix2DataOpTrack *)insertData:(id)data at:(NSIndexPath *)indexPath;
- (NSArray<YAMatrix2DataOpTrack *> *)addData:(NSArray *)datas at:(NSInteger)section;
- (NSArray<YAMatrix2DataOpTrack *> *)deleteDataAt:(NSSet<NSIndexPath *> *)indexPaths;
- (YAMatrix2DataOpTrack *)deleteDataAtSection:(NSInteger)section;
- (NSArray<YAMatrix2DataOpTrack *> *)updateDataAt:(NSSet<NSIndexPath *> *)indexPaths;
- (YAMatrix2DataOpTrack *)moveDataFrom:(NSIndexPath *)from to:(NSIndexPath *)to;
- (NSArray *)dataAtSection:(NSInteger)section;
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface YAMatrix2DataSource : NSObject <YAMatrix2DataSource>

@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *store;

@end
