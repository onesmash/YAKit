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

@property (nonatomic, assign, readonly) size_t size;
@property (nonatomic, assign, readonly) const char* base;

- (instancetype)initWithFilePath:(NSString *)path openMode:(YAMMapFileOpenMode)mode;
- (instancetype)initWithFilePath:(NSString *)path size:(size_t)size openMode:(YAMMapFileOpenMode)mode;

- (BOOL)write:(const char*)data size:(size_t)size offset:(off_t)offset;
- (BOOL)append:(const char*)data size:(size_t)size;
- (const char*)read:(size_t)size offset:(off_t)offset;

- (BOOL)flush:(BOOL)async;

@end
