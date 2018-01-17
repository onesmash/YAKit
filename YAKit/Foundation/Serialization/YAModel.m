//
//  YAModel.m
//  Pods-FeedDemo
//
//  Created by Xuhui on 16/01/2018.
//

#import "YAModel.h"
#import <objc/runtime.h>

static char* kSerializableKeyKey;

@implementation YAModel

+ (NSMutableDictionary *)serializableKeyInfos
{
    NSMutableDictionary *infos = objc_getAssociatedObject(self, kSerializableKeyKey);
    if(!infos) {
        infos = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, kSerializableKeyKey, infos, OBJC_ASSOCIATION_RETAIN);
    }
    return infos;
}

+ (void)registerKeyProtocol:(Protocol *)proto
{
    char* voidEncode = @encode(void);
    unsigned int count = 0;
    struct objc_method_description *methodsDesc = protocol_copyMethodDescriptionList(proto, YES, YES, &count);
    for (unsigned i = 0; i < count; i++) {
        struct objc_method_description *methodDesc = &methodsDesc[i];
        NSMethodSignature *methodSig = [NSMethodSignature signatureWithObjCTypes:methodDesc->types];
        if(strcmp(voidEncode, methodSig.methodReturnType) == 0) {
            continue;
        } else {
            [[self serializableKeyInfos] setObject:[NSString stringWithUTF8String:methodSig.methodReturnType] forKey:NSStringFromSelector(methodDesc->name)];
        }
    }
}

+ (void)registerAllKeyProtocols
{
    
}

+ (void)initialize
{
    [self registerAllKeyProtocols];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString *idEncode = [NSString stringWithUTF8String:@encode(id)];
    [[self.class serializableKeyInfos] enumerateKeysAndObjectsUsingBlock:^(NSString *sel, NSString *typeEncode, BOOL *stop) {
        id object = [aDecoder decodeObjectForKey:sel];
        if([typeEncode hasPrefix:idEncode]) {
            [self setValue:object forKey:sel];
        } else {
            NSData *data = object;
            NSValue *value = [NSValue value:data.bytes withObjCType:typeEncode.UTF8String];
            [self setValue:value forKey:sel];
        }
    }];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSString *idEncode = [NSString stringWithUTF8String:@encode(id)];
    [[self.class serializableKeyInfos] enumerateKeysAndObjectsUsingBlock:^(NSString *sel, NSString *typeEncode, BOOL *stop) {
        id object = [self valueForKey:sel];
        if([typeEncode hasPrefix:idEncode]) {
            [aCoder encodeObject:object forKey:sel];
        } else {
            NSValue *value = object;
            NSUInteger valueSize = [self sizeofType:typeEncode.UTF8String];
            char buf[valueSize];
            memset(buf, 0, valueSize);
            if(@available(iOS 11.0, *)) {
                [value getValue:buf size:valueSize];
            } else {
                [value getValue:buf];
            }
            NSData *data = [NSData dataWithBytes:buf length:valueSize];
            [aCoder encodeObject:data forKey:sel];
        }
    }];
}

- (NSUInteger)sizeofType:(const char*)typeEncode
{
    NSMethodSignature *methodSig = [NSMethodSignature signatureWithObjCTypes:[NSString stringWithFormat:@"%s@:", typeEncode].UTF8String];
    return methodSig.methodReturnLength;
}

@end
