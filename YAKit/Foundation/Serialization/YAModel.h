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
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsWithArray:(NSArray *)array modelCls:(Class)cls;
- (NSDictionary *)dictionaryModel;
@optional
- (void)customFormDictionaryTransformer:(NSDictionary *)dict;
- (void)customToDictionaryTransformer:(NSMutableDictionary *)dict;
@end

@interface YAModel : NSObject <YAModel, NSCoding>

@end
