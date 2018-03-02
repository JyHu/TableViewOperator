//
//  AUUInputCell.m
//  GenTest
//
//  Created by 胡金友 on 2018/2/21.
//

#import "AUUInputCell.h"

@interface AUUInputCell()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation AUUInputCell

+ (CGFloat)heightWithObject:(id<AUUCellObject>)object {
    return 44;
}

- (void)initialize {
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, [UIScreen mainScreen].bounds.size.width - 40, 34)];
    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.textColor = [UIColor greenColor];
    self.textField.placeholder = @"Place holder";
    [self addSubview:self.textField];
}

@end


@implementation AUUInputObject

+ (instancetype)object {
    return [super objectWithClass:[AUUInputCell class]];
}

- (BOOL)reuseable {
    return NO;
}

@end
