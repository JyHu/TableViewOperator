//
//  AUUTableModel.h
//  GenTable
//
//  Created by 胡金友 on 2018/2/19.
//

#import <Foundation/Foundation.h>
#import "AUUTableProtocol.h"
#import <UIKit/UIKit.h>

@interface AUUTableSection : NSObject

/**
 此分组下的cell object
 */
@property (nonatomic, strong) NSMutableArray <id <AUUCellObject>> *rows;

@end

@interface AUUTableModel : NSObject <UITableViewDataSource, AUUCellFactory>

/**
 添加一个cell
 */
- (void)appendObject:(id <AUUCellObject>)object;

/**
 table中的分组
 */
@property (nonatomic, strong) NSMutableArray *sections;

/**
 注册一个空白的cell，用于补偿数据量大、数据更新卡顿时，导致获取不到object引发的崩溃的问题
 */
- (void)registerPlaceholderObject:(id <AUUCellObject>)object;

@end
