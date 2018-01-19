//
//  YAMMapFile.m
//  KVOController
//
//  Created by 徐晖 on 2018/1/19.
//

#import "YAMMapFile.h"
#include "MMapFile.h"

@interface YAMMapFile () {
    MMapFile *_mmapFile;
}
@end

@implementation YAMMapFile

- (instancetype)initWithFilePath:(NSString *)path openMode:(YAMMapFileOpenMode)mode
{
    self = [self init];
    if(self) {
        _mmapFile = new MMapFile();
        _mmapFile->open(path.UTF8String, (MMapFile::Mode)mode);
    }
    return self;
}

- (instancetype)initWithFilePath:(NSString *)path size:(size_t)size openMode:(YAMMapFileOpenMode)mode
{
    self = [self init];
    if(self) {
        _mmapFile = new MMapFile();
        _mmapFile->open(path.UTF8String, (MMapFile::Mode)mode, MMapFile::AccessModeNormal, size);
    }
    return self;
}

- (void)dealloc
{
    delete _mmapFile;
}

- (size_t)size
{
    return _mmapFile->size();
}

- (const char *)base
{
    return _mmapFile->mmapBase();
}

- (BOOL)write:(const char*)data size:(size_t)size offset:(off_t)offset
{
    return _mmapFile->write(data, size, offset);
}

- (BOOL)append:(const char*)data size:(size_t)size
{
    return _mmapFile->append(data, size);
}

- (const char*)read:(size_t)size offset:(off_t)offset
{
    return _mmapFile->read(size, offset);
}

- (BOOL)flush:(BOOL)async
{
    return _mmapFile->flush(async);
}

@end
