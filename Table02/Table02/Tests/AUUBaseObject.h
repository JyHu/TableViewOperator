//
//  AUUBaseObject.h
//  Table02
//
//  Created by 胡金友 on 2018/3/1.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AUUTableProtocol.h"

@interface AUUBaseObject : NSObject <AUUCellObject>

+ (instancetype)objectWithClass:(Class)cls;

+ (instancetype)object;

@end

