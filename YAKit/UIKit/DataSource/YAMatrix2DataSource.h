//
//  YAMatrix2DataSource.h
//  YAKit
//
//  Created by 徐晖 on 2018/3/8.
//  Copyright © 2018年 徐晖. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YAMatrix2DataSource <NSObject>
- (void)insertData:(id)data at:(NSIndexPath *)indexPath;
- (void)addData:(NSArray *)data at:(NSInteger)section;
- (void)deleteDataAt:(NSSet<NSIndexPath *> *)indexPaths;
- (void)updateDataAt:(NSSet<NSIndexPath *> *)indexPaths;
- (void)moveDataFrom:(NSIndexPath *)from to:(NSIndexPath *)to;
- (NSArray *)dataAtSection:(NSInteger)section;
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;
- (void)batchDataUpdate:(void(^)(void))updateBlock completion:(void(^)(void))completionBlock;
@end

@interface YAMatrix2DataSource : NSObject <YAMatrix2DataSource>

@end
