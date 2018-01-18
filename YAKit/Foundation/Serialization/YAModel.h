//
//  YAModel.h
//  Pods-FeedDemo
//
//  Created by Xuhui on 16/01/2018.
//

#import <Foundation/Foundation.h>

@protocol YAModel <NSObject>
+ (void)registerAllKeyProtocols;
+ (void)registerKeyProtocol:(Protocol *)proto;
@end

@interface YAModel : NSObject <YAModel, NSCoding>

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsWithArray:(NSArray *)array modelCls:(Class)cls;

@end
