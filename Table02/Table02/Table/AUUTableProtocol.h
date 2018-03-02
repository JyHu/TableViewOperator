//
//  AUUTableProtocol.h
//  GenTable
//
//  Created by 胡金友 on 2018/2/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AUUTableProtocol <NSObject>

@end

/**
 Cell对应的Object需要实现的方法
 */
@protocol AUUCellObject <NSObject>

@required

/**
 当前object对应的cell的class
 */
- (Class)cellClass;

/**
 是否是可复用的
 */
- (BOOL)reuseable;

@end

/**
 UITableViewCell 需要实现的协议方法
 */
@protocol AUUCell

@required

/**
 当前cell的高度
 */
+ (CGFloat)heightWithObject:(id <AUUCellObject>)object;

/**
 每次显示一个cell的时候都调用的方法，用于刷新cell上的数据
 */
- (BOOL)shouldUpdateWithObject:(id <AUUCellObject>)object;

@optional

@end

/**
 AUUTableModel需要实现的方法
 */
@protocol AUUCellFactory

@required

/**
 获取指定位置的object

 @param tableView 当前的tableView
 @param indexPath 当前的索引
 @return object
 */
- (id <AUUCellObject>)objectForTable:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
