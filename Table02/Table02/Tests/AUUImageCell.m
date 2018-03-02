//
//  AUUImageCell.m
//  GenTest
//
//  Created by 胡金友 on 2018/2/21.
//

#import "AUUImageCell.h"

@interface AUUImageObject ()

@property (nonatomic, strong) UIImage *image;
@property (assign, nonatomic) CGFloat height;

@end

@implementation AUUImageObject

+ (instancetype)object {
    AUUImageObject *object = [super objectWithClass:[AUUImageCell class]];
    object.image = [UIImage imageNamed:[NSString stringWithFormat:@"p%@.jpg", @(arc4random_uniform(6))]];
    object.height = object.image.size.height / object.image.size.width * ([UIScreen mainScreen].bounds.size.width - 40);
    return object;
}

@end




@interface AUUImageCell()

@property (nonatomic, strong) UIImageView *mimageView;

@end

@implementation AUUImageCell

+ (CGFloat)heightWithObject:(AUUImageObject *)object {
    return object.height + 20;
}

- (BOOL)shouldUpdateWithObject:(AUUImageObject *)object {
    
    self.mimageView.image = object.image;
    self.mimageView.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, object.height);
    
    return [super shouldUpdateWithObject:object];
}

- (void)initialize {
    self.mimageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, 0)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.mimageView];
}

@end

