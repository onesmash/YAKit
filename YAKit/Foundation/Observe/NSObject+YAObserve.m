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
static char kLockKey;

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
    __block id lock_ = objc_getAssociatedObject(self, &kLockKey);
    if(!lock_) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            lock_ = [[NSRecursiveLock alloc] init];
            objc_setAssociatedObject(self, &kLockKey, lock_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        });
        lock_ = objc_getAssociatedObject(self, &kLockKey);
    }
    return lock_;
}

- (void)ya_addObserver:(NSObject *)observer forKey:(NSString *)key block:(YAObserveHandler)block
{
    SEL sel = NSSelectorFromString(key);
    if([self respondsToSelector:sel]) {
        [observer.KVOController observe:self keyPath:key options:0 block:^(id observer, id object, NSDictionary *change) {
            if(block) {
                block(observer, object);
            }
        }];
    } else {
        [self.lock lock];
        NSMapTable *table = [self.observers objectForKey:key];
        if(!table) {
            table = [NSMapTable weakToStrongObjectsMapTable];
            [self.observers setObject:table forKey:key];
        }
        NSMutableArray *blocks = [table objectForKey:observer];
        if(!blocks) {
            blocks = [NSMutableArray array];
            [table setObject:blocks forKey:observer];
        }
        [blocks addObject:block];
        [self.lock unlock];
    }
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