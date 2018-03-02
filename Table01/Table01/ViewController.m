//
//  ViewController.m
//  Table01
//
//  Created by 胡金友 on 2018/2/28.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import "ViewController.h"

@interface BaseCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *data;
@end
@implementation BaseCell            @end

@interface TextCell : BaseCell      @end
@implementation TextCell            @end

@interface ImageCell : BaseCell     @end
@implementation ImageCell           @end

@interface InputCell : BaseCell     @end
@implementation InputCell           @end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <NSArray <NSDictionary *> *> *datas;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 一系列的初始化、数据请求等等。。。。
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.datas objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [[self.datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([data[@"type"] isEqualToString:@"text"]) {
        static NSString *textCellReusedIdentifier = @"com.auu.textCellReusedIdentifier";
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellReusedIdentifier];
        if (!cell) {
            cell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textCellReusedIdentifier];
        }
        cell.data = data;
        return cell;
    } else if ([data[@"type"] isEqualToString:@"image"]) {
        static NSString *imageCellReusedIdentifier = @"com.auu.imageCellReusedIdentifier";
        ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellReusedIdentifier];
        if (!cell) {
            cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellReusedIdentifier];
        }
        cell.data = data;
        return cell;
    } else if ([data[@"type"] isEqualToString:@"input"]) {
        static NSString *inputCellReusedIdentifier = @"com.auu.inputCellReusedIdentifier";
        InputCell *cell = [tableView dequeueReusableCellWithIdentifier:inputCellReusedIdentifier];
        if (!cell) {
            cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputCellReusedIdentifier];
        }
        cell.data = data;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [[self.datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([data[@"type"] isEqualToString:@"text"]) {
        NSLog(@"我选中了文本行，我需要做些事情");
    } else if ([data[@"type"] isEqualToString:@"image"]) {
        NSLog(@"我选中了图片行，我需要做些事情");
    } else if ([data[@"type"] isEqualToString:@"input"]) {
        NSLog(@"我选中了输入行，我需要做些事情");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [[self.datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([data[@"type"] isEqualToString:@"text"]) {
        // 计算一番.....
        return 44.0;
    } else if ([data[@"type"] isEqualToString:@"image"]) {
        // 计算一番.....
        return 108.0;
    } else if ([data[@"type"] isEqualToString:@"input"]) {
        // 计算一番.....
        return 64.0;
    }
    
    return 44.0;
}

@end
