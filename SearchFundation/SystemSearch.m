//
//  SystemSearch.m
//  SearchFundation
//
//  Created by Jing  on 16/8/8.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import "SystemSearch.h"

#define TableCell @"tablecell"

@interface SystemSearch ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>
// 数据源表格
@property (nonatomic, strong) UITableView * tableView;
//搜索结果的表格视图
@property (nonatomic, strong) UITableViewController * searchTableView;
//搜索视图
@property(nonatomic,retain)UISearchController *searchController;
//数据源
@property(nonatomic,retain)NSMutableArray *items;
//接收数据源结果
@property(nonatomic,retain)NSMutableArray *searchResults;

@end
@implementation SystemSearch
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"控件搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    // 数据源
    _items = @[@"钢铁侠",@"绿箭侠",@"闪电侠",@"夜魔侠",@"破产姐妹",@"生活大爆炸",@"复仇者联盟",@"斯密斯夫妇",@"超体",@"功夫熊",@"小碗熊"].mutableCopy;
    //创建数据源表格
    [self createTableView];
    //搜索视图
    [self createSearchController];
}

#pragma mark - 创建数据源表格
- (void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableCell];
    [self.view addSubview:self.tableView];
}

#pragma mark 搜索视图
- (void)createSearchController
{
    //表格界面
    _searchTableView = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    //UITableViewController表格视图控制器
    _searchTableView.tableView.dataSource = self;
    _searchTableView.tableView.delegate = self;
    [_searchTableView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableCell];
#pragma mark - 把表格视图控制器跟搜索界面相关联
    //设置大小
    _searchTableView.tableView.frame = self.view.bounds;
    //创建搜索界面
    _searchController = [[UISearchController alloc]initWithSearchResultsController:_searchTableView];
    //设置搜索栏的大小
    _searchController.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    _searchController.searchResultsUpdater = self;
    //把搜索栏放到tableview的头视图上
    _tableView.tableHeaderView = _searchController.searchBar;
    //设置搜索的代理
    _searchController.searchResultsUpdater = self;
    
}

#pragma mark UISearchResultsUpdating协议
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self.searchResults removeAllObjects];
    //NSPredicate 谓词
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchController.searchBar.text];
    //过滤数据
    self.searchResults = [[self.items filteredArrayUsingPredicate:searchPredicate]mutableCopy];
    //刷新表格
    [self.searchTableView.tableView reloadData];
    
    
//    // 方法一:([c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。)
//    
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] %@",searchController.searchBar.text];
//    
//    //  数组提供的快速遍历,返回的类型是NSArray
//    
//    NSLog(@"%@",[ _searchResults filteredArrayUsingPredicate:predicate]);
//    
//    // 方法二:
//    
//    for (int i = 0; i < _searchResults.count; i++) {
//        
//        if ([predicate evaluateWithObject:[ _searchResults objectAtIndex:i]]) {
//            
//            NSLog(@"%@",[_searchResults objectAtIndex:i]);
//            
//        }
//        
//    }
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tableView) {
        
        return self.items.count;
    }else {
        
        return self.searchResults.count;
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableCell forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableCell];
    }
    
    if (tableView == _tableView) {
        
        cell.textLabel.text = self.items[indexPath.row];
    }else {
        
         cell.textLabel.text = self.searchResults[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 懒加载
- (NSMutableArray *)items{
    
    if (!_items) {
        self.items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)searchResults{
    
    if (!_searchResults) {
        self.searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
