//
//  NSObject+YAObserve.h
//  Pods-FeedDemo
//
//  Created by 徐晖 on 2018/1/17.
//

#import <Foundation/Foundation.h>

typedef void(^YAObserveHandler)(id observer, id object);

@protocol YAObserveProtocol <NSObject>

- (void)ya_addObserver:(NSObject *)observer forKey:(NSString *)key block:(YAObserveHandler)block;
- (void)ya_addObserverOnce:(NSObject *)observer forKey:(NSString *)key block:(YAObserveHandler)block;
- (void)ya_removeObserver:(NSObject *)observer forKey:(NSString *)key;
- (void)ya_removeObserver:(NSObject *)observer;

@end

@interface NSObject (YAObserve) <YAObserveProtocol>

@end

#if DEBUG
#define YAObserve(object, key, handler) [object ya_addObserver:self forKey:@#key block:(handler)]; \
{ \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wunused-getter-return-value\"") \
object.key; \
_Pragma("clang diagnostic pop") \
}
#else
#define YAObserve(object, key, handler) [object ya_addObserver:self forKey:@#key block:(handler)];
#endif

#if DEBUG
#define YAObserveOnce(object, key, handler) [object ya_addObserverOnce:self forKey:@#key block:(handler)]; \
{ \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wunused-getter-return-value\"") \
object.key; \
_Pragma("clang diagnostic pop") \
}
#else
#define YAObserveOnce(object, key, handler) [object ya_addObserverOnce:self forKey:@#key block:(handler)];
#endif
