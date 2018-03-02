//
//  AUUTableAction.m
//  GenTable
//
//  Created by 胡金友 on 2018/2/19.
//

#import "AUUTableAction.h"
#import "AUUTableProtocol.h"

@interface _AUUActionCache: NSObject
@property (weak, nonatomic) id target;
@property (nonatomic) SEL sel;
@property (copy, nonatomic) AUUCellSelectedAction action;
@end

@implementation _AUUActionCache
+ (instancetype)cacheWithAction:(AUUCellSelectedAction)action {
    _AUUActionCache *cache = [[_AUUActionCache alloc] init];
    cache.action = [action copy];
    return cache;
}
+ (instancetype)cacheWithTarget:(id)target selector:(SEL)sel {
    _AUUActionCache *cache = [[_AUUActionCache alloc] init];
    cache.target = target;
    cache.sel = sel;
    return cache;
}
@end

@interface AUUTableAction()

@property (nonatomic, strong) NSMutableDictionary *objectActions;
@property (nonatomic, strong) NSMutableDictionary *classActions;

@end

@implementation AUUTableAction

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.dataSource conformsToProtocol:@protocol(AUUCellFactory)] &&
        [tableView.dataSource respondsToSelector:@selector(objectForTable:atIndexPath:)]) {
        // 拿到当前位置的数据信息
        id <AUUCellObject> object = [(id <AUUCellFactory>)tableView.dataSource objectForTable:tableView atIndexPath:indexPath];
        if ([object.cellClass respondsToSelector:@selector(heightWithObject:)]) {
            // 获取高度
            return [object.cellClass heightWithObject:object];
        }
    }
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.dataSource conformsToProtocol:@protocol(AUUCellFactory)] &&
        [tableView.dataSource respondsToSelector:@selector(objectForTable:atIndexPath:)]) {
        
        [self performActionForObject:[(id <AUUCellFactory>)tableView.dataSource objectForTable:tableView atIndexPath:indexPath]];
    }
}

#pragma mark - operator

- (id<AUUCellObject>)attachObject:(id<AUUCellObject>)object action:(AUUCellSelectedAction)action {
    if (object) {
        [self.objectActions setObject:[_AUUActionCache cacheWithAction:action] forKey:[self keyForObject:object]];
    }
    return object;
}

- (id <AUUCellObject>)attachObject:(id<AUUCellObject>)object target:(id)target action:(SEL)action {
    if (object) {
        [self.objectActions setObject:[_AUUActionCache cacheWithTarget:target selector:action] forKey:[self keyForObject:object]];
    }
    return object;
}

- (void)attachClass:(Class)cls action:(AUUCellSelectedAction)action {
    [self.classActions setObject:[_AUUActionCache cacheWithAction:action] forKey:(id <NSCopying>)cls];
}

- (void)attachClass:(Class)cls target:(id)target action:(SEL)action {
    [self.classActions setObject:[_AUUActionCache cacheWithTarget:target selector:action] forKey:(id <NSCopying>)cls];
}

- (void)performActionForObject:(id <AUUCellObject>)object {
    if (!object) {
        return;
    }
    
    _AUUActionCache *action = [self.objectActions objectForKey:[self keyForObject:object]];
    if (!action) {
        Class keyClass = [(NSObject *)object class];
        
        for (Class class in self.classActions.allKeys) {
            if ([keyClass isKindOfClass:class] || [keyClass isSubclassOfClass:class]) {
                // 需要做处理，比如  A<-B<-C
                // 我添加了A、B的监听，当我拿C class来取响应者的时候，到底是取谁？
                // 所以这里只是简单的写了一下
                action = [self.classActions objectForKey:(id<NSCopying>)class];
            }
        }
    }
    
    if (!action) {
        return;
    }
    
    if (action.action) {
        action.action(object);
    }
    if (action.target && action.sel && [action.target respondsToSelector:action.sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [action.target performSelector:action.sel withObject:object];
#pragma clang diagnostic pop
    }
}

#pragma mark - getter

- (NSNumber *)keyForObject:(id <AUUCellObject>)object {
    return @([(NSObject *)object hash]);
}

- (NSMutableDictionary *)objectActions {
    if (!_objectActions) {
        _objectActions = [[NSMutableDictionary alloc] init];
    }
    return _objectActions;
}

- (NSMutableDictionary *)classActions {
    if (!_classActions) {
        _classActions = [[NSMutableDictionary alloc] init];
    }
    return _classActions;
}

@end
