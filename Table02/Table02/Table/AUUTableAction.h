//
//  AUUTableAction.h
//  GenTable
//
//  Created by 胡金友 on 2018/2/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AUUCellObject;

typedef void (^AUUCellSelectedAction)(id <AUUCellObject> object);

@interface AUUTableAction : NSObject <UITableViewDelegate>


/**
 注册cell点击响应的事件
 */
- (id <AUUCellObject>)attachObject:(id <AUUCellObject>)object action:(AUUCellSelectedAction)action;
- (id <AUUCellObject>)attachObject:(id<AUUCellObject>)object target:(id)target action:(SEL)action;
- (void)attachClass:(Class)cls action:(void (^)(id <AUUCellObject>))action;
- (void)attachClass:(Class)cls target:(id)target action:(SEL)action;

@end
