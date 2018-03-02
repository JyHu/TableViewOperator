//
//  ViewController.m
//  Table02
//
//  Created by 胡金友 on 2018/3/1.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import "ViewController.h"

#import "AUUTableModel.h"
#import "AUUTableAction.h"

#import "AUUTextCell.h"
#import "AUUInputCell.h"
#import "AUUImageCell.h"
#import "AUUPlaceholderCell.h"
#import "AUUImageScrollerCell.h"

@interface ViewController () <AUUImageScrollerProtocol>

@property (nonatomic, strong) AUUTableModel *tableModel;
@property (nonatomic, strong) AUUTableAction *tableAction;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableAction attachClass:[AUUTextObject class] action:^(AUUTextObject *object) {
        NSLog(@"tap : %@", object.text);
    }];
    
    [self.tableAction attachClass:[AUUImageObject class] target:self action:@selector(imageAction:)];
    
    [self.tableModel appendObject:[AUUTextObject objectWithText:@"title"]];
    [self.tableModel appendObject:[AUUInputObject object]];
    [self.tableModel appendObject:[self.tableAction attachObject:[AUUImageObject object] action:^(id<AUUCellObject> object) {
        NSLog(@"tap 你点击了这个图片cell");
    }]];
    [self.tableModel appendObject:[AUUImageScrollerObject objectWithDelegate:self]];
    [self.tableModel appendObject:[AUUTextObject objectWithText:@"title"]];
    [self.tableModel appendObject:[AUUInputObject object]];
    [self.tableModel appendObject:[self.tableAction attachObject:[AUUImageObject object] target:self action:@selector(imageCellAction:)]];
    [self.tableModel appendObject:[AUUTextObject objectWithText:@"title"]];
    [self.tableModel appendObject:[AUUImageScrollerObject objectWithDelegate:self]];
    [self.tableModel appendObject:[AUUInputObject object]];
    [self.tableModel appendObject:[AUUImageObject object]];
    [self.tableModel appendObject:[AUUTextObject objectWithText:@"title"]];
    [self.tableModel appendObject:[AUUImageScrollerObject objectWithDelegate:self]];
    [self.tableModel appendObject:[AUUInputObject object]];
    [self.tableModel appendObject:[AUUImageObject object]];
    [self.tableModel appendObject:[AUUTextObject objectWithText:@"title"]];
}

- (void)imageCellAction:(AUUImageObject *)object {
    NSLog(@"tap 我是通过方法调用来回调的事件");
}

- (void)imageAction:(AUUImageObject *)object {
    NSLog(@"tap 我是一类cell统一的方法拦截，要是没有对某个cell做单独的设置，都会跑这里来");
}

- (void)selectedImageAtIndex:(NSInteger)index object:(AUUImageScrollerObject *)object {
    NSLog(@"selected 选择图片：%@", @(index));
}

- (AUUTableModel *)tableModel {
    if (!_tableModel) {
        _tableModel = [[AUUTableModel alloc] init];
        [_tableModel registerPlaceholderObject:[AUUPlaceholderObject object]];
    }
    return _tableModel;
}

- (AUUTableAction *)tableAction {
    if (!_tableAction) {
        _tableAction = [[AUUTableAction alloc] init];
    }
    return _tableAction;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self.tableModel;
        _tableView.delegate = self.tableAction;
    }
    return _tableView;
}

@end

