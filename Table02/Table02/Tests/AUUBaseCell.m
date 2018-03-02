//
//  AUUBaseCell.m
//  GenTest
//
//  Created by 胡金友 on 2018/2/19.
//

#import "AUUBaseCell.h"

@implementation AUUBaseCell
+ (CGFloat)heightWithObject:(id<AUUCellObject>)object {
    return 44.0;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}
- (void)initialize { }
- (BOOL)shouldUpdateWithObject:(id<AUUCellObject>)object {
    return YES;
}
@end
