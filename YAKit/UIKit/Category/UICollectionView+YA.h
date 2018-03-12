//
//  UICollectionView+YA.h
//  IGListKit
//
//  Created by 徐晖 on 2018/3/12.
//

#import <UIKit/UIKit.h>
#import "YAMatrix2DataOpTrack.h"

@interface UICollectionView (YA)

- (void)ya_batchUpdate:(NSArray<YAMatrix2DataOpTrack *> *)tracks completion:(void (^)(BOOL finished))completion;

@end
