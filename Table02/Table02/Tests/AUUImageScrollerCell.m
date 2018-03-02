//
//  AUUImageScrollerCell.m
//  GenTest
//
//  Created by 胡金友 on 2018/3/1.
//

#import "AUUImageScrollerCell.h"

@interface AUUImageScrollerObject()

@property (nonatomic, strong) NSMutableArray *imgNames;

@property (nonatomic, weak) id <AUUImageScrollerProtocol> delegate;

@end

@implementation AUUImageScrollerObject

+ (instancetype)objectWithDelegate:(id<AUUImageScrollerProtocol>)delegate {
    AUUImageScrollerObject *object = [super objectWithClass:[AUUImageScrollerCell class]];
    object.delegate = delegate;
    return object;
}

- (NSMutableArray *)imgNames {
    if (!_imgNames) {
        _imgNames = [[NSMutableArray alloc] init];
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:@"p0", @"p1", @"p2", @"p3", @"p4", @"p5", nil];
        
        for (NSInteger i = 0; i < 6; i ++) {
            NSInteger ind = (NSInteger)arc4random_uniform((unsigned int)temp.count);
            [_imgNames addObject:[temp objectAtIndex:ind]];
            [temp removeObjectAtIndex:ind];
        }
    }
    return _imgNames;
}

@end

@interface AUUImageScrollerCell()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (weak, nonatomic) AUUImageScrollerObject *object;

@end

@implementation AUUImageScrollerCell

+ (CGFloat)heightWithObject:(id<AUUCellObject>)object {
    return 120;
}

- (BOOL)shouldUpdateWithObject:(AUUImageScrollerObject *)object {
    
    if (self.scrollView.subviews.count == 0) {
        
        self.object = object;
        
        CGFloat x = 0;
        for (NSInteger i = 0; i < object.imgNames.count; i ++) {
            NSString *imgName = [object.imgNames objectAtIndex:i];
            UIImage *image = [UIImage imageNamed:[imgName stringByAppendingString:@".jpg"]];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(x, 0, image.size.width / image.size.height * 120, 120);
            [self.scrollView addSubview:button];
            
            x += CGRectGetWidth(button.frame);
        }
        
        self.scrollView.contentSize = CGSizeMake(MAX(x, [UIScreen mainScreen].bounds.size.width + 1), 120);
    }
    
    return [super shouldUpdateWithObject:object];
}

- (void)buttonAction:(UIButton *)button {
    if (self.object) {
        if ([self.object.delegate respondsToSelector:@selector(selectedImageAtIndex:object:)]) {
            [self.object.delegate selectedImageAtIndex:button.tag object:self.object];
        }
    }
}

- (void)initialize {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    [self addSubview:self.scrollView];
}

@end
