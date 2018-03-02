//
//  AUUBaseObject.m
//  Table02
//
//  Created by 胡金友 on 2018/3/1.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import "AUUBaseObject.h"

@interface AUUBaseObject()

@property (nonatomic) Class cls;

@end

@implementation AUUBaseObject

+ (instancetype)object {
    return nil;
}

+ (instancetype)objectWithClass:(Class)cls {
    AUUBaseObject *object = [[self alloc] init];
    object.cls = cls;
    return object;
}

- (Class)cellClass {
    return self.cls;
}

- (BOOL)reuseable {
    return YES;
}

@end

