//
//  YAMMapFile.h
//  KVOController
//
//  Created by 徐晖 on 2018/1/19.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    YAMMapFileOpenModeRead,
    YAMMapFileOpenModeWriteAppend,
    YAMMapFileOpenModeWriteTruncate,
} YAMMapFileOpenMode;

@interface YAMMapFile : NSObject

@property (nonatomic, assign, readonly) NSUInteger size;
@property (nonatomic, assign, readonly) char* base;

- (instancetype)initWithFilePath:(NSString *)path openMode:(YAMMapFileOpenMode)mode;
- (instancetype)initWithFilePath:(NSString *)path size:(NSUInteger)size openMode:(YAMMapFileOpenMode)mode;

- (BOOL)write:(const char*)data size:(NSUInteger)size offset:(NSUInteger)offset;
- (BOOL)append:(const char*)data size:(NSUInteger)size;
- (const char*)read:(NSUInteger)size offset:(NSUInteger)offset;

- (BOOL)flush:(BOOL)async;

@end
