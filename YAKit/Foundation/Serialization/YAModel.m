//
//  YAModel.m
//  Pods-FeedDemo
//
//  Created by Xuhui on 16/01/2018.
//

#import "YAModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char* kSerializableKeyKey;

@interface YASerializableKeyInfo : NSObject
@property (nonatomic, assign) BOOL isObject;
@property (nonatomic, assign) BOOL isStruct;
@property (nonatomic, copy) NSString *typeEncode;
@property (nonatomic, assign) NSUInteger typeSize;
@property (nonatomic, assign) SEL customTransformer;
@end

@implementation YASerializableKeyInfo
@end

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
    NSString *idEncode = [NSString stringWithUTF8String:@encode(id)];
    char* voidEncode = @encode(void);
    unsigned int count = 0;
    struct objc_method_description *methodsDesc = protocol_copyMethodDescriptionList(proto, YES, YES, &count);
    for (unsigned i = 0; i < count; i++) {
        struct objc_method_description *methodDesc = &methodsDesc[i];
        NSMethodSignature *methodSig = [NSMethodSignature signatureWithObjCTypes:methodDesc->types];
        if(strcmp(voidEncode, methodSig.methodReturnType) == 0) {
            continue;
        } else {
            NSString *selName = NSStringFromSelector(methodDesc->name);
            SEL customTransformerSel = NSSelectorFromString([NSString stringWithFormat:@"%@Transformer:", selName]);
            YASerializableKeyInfo *info = [[YASerializableKeyInfo alloc] init];
            info.typeEncode = [NSString stringWithUTF8String:methodSig.methodReturnType];
            info.isObject = [info.typeEncode hasPrefix:idEncode];
            if(!info.isObject) {
                info.isStruct = [info.typeEncode hasPrefix:@"{"];
            }
            info.typeSize = methodSig.methodReturnLength;
            info.customTransformer = [self respondsToSelector:customTransformerSel] ? customTransformerSel : (SEL)0;
            [[self serializableKeyInfos] setObject:info forKey:selName];
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

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    YAModel *model = [self new];
    [model ya_setupWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)array modelCls:(Class)cls
{
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *model in array) {
        [models addObject:[cls modelWithDictionary:model]];
    }
    return [models copy];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    [[self.class serializableKeyInfos] enumerateKeysAndObjectsUsingBlock:^(NSString *sel, YASerializableKeyInfo *info, BOOL *stop) {
        id object = [aDecoder decodeObjectForKey:sel];
        if(info.isObject) {
            [self setValue:object forKey:sel];
        } else {
            NSData *data = object;
            NSValue *value;
            if(!info.isStruct) {
                do {
                    if([info.typeEncode isEqualToString:@(@encode(char))]) {
                        value = [NSNumber numberWithChar:*(char *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(unsigned char))]) {
                        value = [NSNumber numberWithUnsignedChar:*(unsigned char *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(short))]) {
                        value = [NSNumber numberWithShort:*(short *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(unsigned short))]) {
                        value = [NSNumber numberWithUnsignedShort:*(unsigned short *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(int))]) {
                        value = [NSNumber numberWithInt:*(int *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(unsigned int))]) {
                        value = [NSNumber numberWithUnsignedInt:*(unsigned int *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(long))]) {
                        value = [NSNumber numberWithLong:*(long *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(unsigned long))]) {
                        value = [NSNumber numberWithUnsignedLong:*(unsigned long *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(long long))]) {
                        value = [NSNumber numberWithLongLong:*(long long *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(unsigned long long))]) {
                        value = [NSNumber numberWithUnsignedLongLong:*(unsigned long long *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(float))]) {
                        value = [NSNumber numberWithFloat:*(float *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(double))]) {
                        value = [NSNumber numberWithDouble:*(double *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(BOOL))]) {
                        value = [NSNumber numberWithBool:*(BOOL *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(NSInteger))]) {
                        value = [NSNumber numberWithInteger:*(NSInteger *)data.bytes];
                        break;
                    }
                    if([info.typeEncode isEqualToString:@(@encode(NSUInteger))]) {
                        value = [NSNumber numberWithUnsignedInteger:*(NSUInteger *)data.bytes];
                        break;
                    }
                } while(false);
            } else {
                value = [NSValue value:data.bytes withObjCType:info.typeEncode.UTF8String];
            }
            [self setValue:value forKey:sel];
        }
    }];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [[self.class serializableKeyInfos] enumerateKeysAndObjectsUsingBlock:^(NSString *sel, YASerializableKeyInfo *info, BOOL *stop) {
        id object = [self valueForKey:sel];
        if(info.isObject) {
            [aCoder encodeObject:object forKey:sel];
        } else {
            NSValue *value = object;
            NSUInteger valueSize = info.typeSize;
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

- (void)ya_setupWithDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        YASerializableKeyInfo *info = [[self.class serializableKeyInfos] objectForKey:key];
        if(!info) return;
        id realValue = info.customTransformer ? ((id (*)(id, SEL, id))objc_msgSend)((id)self.class, info.customTransformer, value) : value;
        if(info.isObject) {
            NSObject *target = [self valueForKey:key];
            if([target isKindOfClass:[YAModel class]]) {
                ((void (*)(id, SEL, id))objc_msgSend)(target, @selector(ya_setupWithDictionary:), realValue);
            } else {
                [self setValue:realValue forKey:key];
            }
        } else {
            [self setValue:realValue forKey:key];
        }
    }];
}

@end
