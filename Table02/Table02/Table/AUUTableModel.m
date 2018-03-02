//
//  AUUTableModel.m
//  GenTable
//
//  Created by 胡金友 on 2018/2/19.
//

#import "AUUTableModel.h"

@implementation AUUTableSection

- (NSMutableArray *)rows {
    if (!_rows) {
        _rows = [[NSMutableArray alloc] init];
    }
    return _rows;
}

@end

@interface AUUTableModel()

@property (retain, nonatomic) id <AUUCellObject> placeholderObject;

@end

@implementation AUUTableModel

- (void)appendObject:(id<AUUCellObject>)object {
    if (object && [object conformsToProtocol:@protocol(AUUCellObject)]) {
        [[self lastSection].rows addObject:object];
    }
}

- (void)registerPlaceholderObject:(id<AUUCellObject>)object {
    if (object && [object conformsToProtocol:@protocol(AUUCellObject)]) {
        self.placeholderObject = object;
    }
}

#pragma mark - AUUCellFactory

- (id<AUUCellObject>)objectForTable:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    return [self.sections[indexPath.section] rows][indexPath.row] ?: self.placeholderObject;
}

#pragma mark - UITableViewDatasource

// 设置分组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

// 设置每个分组下的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.sections objectAtIndex:section] rows] count];
}

// 设置每行的cell视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取当前tableView的indexPath这个位置对应的数据信息
    id <AUUCellObject> object = [self objectForTable:tableView atIndexPath:indexPath];
    
    // 拼接复用的标识，如果是可复用的cell，直接用cell的类名来当做标识
    NSString *identifier = NSStringFromClass(object.cellClass);
    if (!object.reuseable) {
        // 如果不可复用，就拼接上数据的hash值，来控制唯一性
        identifier = [identifier stringByAppendingFormat:@"%@", @([(NSObject *)object hash])];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        // 根据数据信息对应的cell类型创建实例
        cell = [[object.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // 更新cell数据
    if ([cell conformsToProtocol:@protocol(AUUCell)] && [cell respondsToSelector:@selector(shouldUpdateWithObject:)]) {
        [(id <AUUCell>)cell shouldUpdateWithObject:object];
    }
    
    return cell;
}

#pragma mark - getter

- (AUUTableSection *)lastSection {
    if (self.sections.count == 0) {
        [self.sections addObject:[[AUUTableSection alloc] init]];
    }
    return self.sections.lastObject;
}

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

@end
