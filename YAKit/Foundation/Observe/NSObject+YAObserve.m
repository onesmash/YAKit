//
//  NSObject+YAObserve.m
//  Pods-FeedDemo
//
//  Created by 徐晖 on 2018/1/17.
//

#import "NSObject+YAObserve.h"
#import "NSObject+FBKVOController.h"
#import <objc/runtime.h>

static char kObserverKey;

@implementation NSObject (YAObserve)

- (NSMutableDictionary<NSString *,NSMapTable *> *)observers
{
    id ob = objc_getAssociatedObject(self, &kObserverKey);
    if(!ob) {
        ob = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &kObserverKey, ob, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ob;
}

- (NSRecursiveLock *)lock
{
    static NSRecursiveLock *lock_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock_ = [[NSRecursiveLock alloc] init];
    });
    return lock_;
}

- (void)ya_addObserverOnce:(NSObject *)observer forKey:(NSString *)key block:(YAObserveHandler)block
{
    [observer.KVOController observe:self keyPath:key options:0 block:^(NSObject *observer, id object, NSDictionary *change) {
        [observer.KVOController unobserve:object keyPath:key];
        if(block) {
            block(observer, object);
        }
    }];
}

- (void)ya_addObserver:(NSObject *)observer forKey:(NSString *)key block:(YAObserveHandler)block
{
    [observer.KVOController observe:self keyPath:key options:0 block:^(id observer, id object, NSDictionary *change) {
        if(block) {
            block(observer, object);
        }
    }];
}

- (void)ya_removeObserver:(NSObject *)observer forKey:(NSString *)key
{
    [observer.KVOController unobserve:self keyPath:key];
    [self.lock lock];
    NSMapTable *table = [self.observers objectForKey:key];
    [table removeObjectForKey:observer];
    [self.lock unlock];
}

- (void)ya_removeObserver:(NSObject *)observer
{
    [observer.KVOController unobserve:self];
    [self.lock lock];
    [self.observers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMapTable *table, BOOL *stop) {
        [table removeObjectForKey:observer];
    }];
    [self.lock unlock];
}

@end
