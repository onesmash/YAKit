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

@end
