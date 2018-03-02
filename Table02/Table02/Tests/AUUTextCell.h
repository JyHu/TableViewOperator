//
//  AUUTextCell.h
//  GenTest
//
//  Created by 胡金友 on 2018/2/19.
//

#import "AUUBaseCell.h"

@interface AUUTextCell : AUUBaseCell

@end

@interface AUUTextObject : AUUBaseObject

+ (instancetype)objectWithText:(NSString *)text;

@property (copy, nonatomic, readonly) NSString *text;

@end
