//
//  AUUTextCell.m
//  GenTest
//
//  Created by 胡金友 on 2018/2/19.
//

#import "AUUTextCell.h"

@interface AUUTextObject ()
@property (copy, nonatomic, readwrite) NSString *text;
@end

@implementation AUUTextObject

+ (instancetype)objectWithText:(NSString *)text {
    AUUTextObject *object = [super objectWithClass:[AUUTextCell class]];
    object.text = text;
    return object;
}

- (NSString *)text {
    return _text;
}

@end

@interface AUUTextCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation AUUTextCell

+ (CGFloat)heightWithObject:(id<AUUCellObject>)object {
    return  44;
}

- (BOOL)shouldUpdateWithObject:(AUUTextObject *)object {
    self.label.text = object.text;
    return YES;
}

- (void)initialize {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 44)];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor redColor];
    [self addSubview:self.label];
}

@end

