//
//  AUUImageScrollerCell.h
//  GenTest
//
//  Created by 胡金友 on 2018/3/1.
//

#import "AUUBaseCell.h"

@class AUUImageScrollerObject;

@protocol AUUImageScrollerProtocol <NSObject>

@optional
- (void)selectedImageAtIndex:(NSInteger)index object:(AUUImageScrollerObject *)object;

@end

@interface AUUImageScrollerCell : AUUBaseCell

@end

@interface AUUImageScrollerObject : AUUBaseObject

+ (instancetype)objectWithDelegate:(id <AUUImageScrollerProtocol>)delegate;

@end
