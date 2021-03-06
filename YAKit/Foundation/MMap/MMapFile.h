//
//  MMapFile.h
//  MMapFile
//
//  Created by Xuhui on 16/5/13.
//  Copyright © 2016年 Xuhui. All rights reserved.
//

#ifndef MMapFile_h
#define MMapFile_h

#include <string>

class MMapFile
{
public:
    typedef enum {
        ModeRead,
        ModeWrite,
        ModeWriteAppend,
        ModeWriteTruncate
    } Mode;
    
    typedef enum {
        AccessModeNormal,
        AccessModeSequential,
        AccessModeRandom,
        AccessModeAggressive,
    } AccessMode;
    MMapFile();
    MMapFile(const MMapFile& mapFile);
    MMapFile(MMapFile&& mapFile);
    ~MMapFile();
    
    MMapFile& operator=(MMapFile&& mapFile);
    
    bool open(const std::string& file, Mode mode = ModeRead, AccessMode accessMode = AccessModeNormal, size_t size = 0);
    
    bool write(const char* src, size_t size, off_t offset);
    
    bool append(const char* src, size_t size);
    
    const char* read(size_t size, off_t offset);
    
    bool close();
    
    bool flush(bool aync = true);
    
    void truncate(size_t size);
    
    size_t size() const { return map_size_; }
    
    const char* mmapBase() const { return mmap_base_; }
private:
    
    int openFile(const std::string& filePath, Mode mode);
    void setAccessMode(AccessMode mode);
    
    bool opened_;
    bool resizeMapFile(size_t size);
    bool remap(size_t size);
    std::string filePath_;
    Mode mode_;
    int fd_;
    size_t map_size_;
    size_t file_size_;
    char* mmap_base_;
    AccessMode access_mode_;
};

#endif /* MMapFile_h */
