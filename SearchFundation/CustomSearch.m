//
//  CustomSearch.m
//  SearchFundation
//
//  Created by Jing  on 16/8/8.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import "CustomSearch.h"

#define TableCell @"tablecell"

@interface CustomSearch()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
// 数据源表格
@property (nonatomic, strong) UITableView * tableView;
// 搜索框
@property (nonatomic, strong) UITextField * searchTextField;
// 接收数据源
@property (nonatomic, strong) NSMutableArray * dataArray;
// 搜索index
@property (nonatomic, assign) NSInteger indexSearch;
// 是否搜索
@property (nonatomic, assign) BOOL isSearch;
@end

@implementation CustomSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    // 数据源
    _dataArray = @[@"钢铁侠",@"绿箭侠",@"闪电侠",@"夜魔侠",@"破产姐妹",@"生活大爆炸",@"复仇者联盟",@"斯密斯夫妇",@"超体",@"功夫熊",@"小碗熊"].mutableCopy;
    // 设置导航栏
    [self resetNavigationBar];
    // 创建数据源表格
    [self createTableView];
    // 初始化的时候设置为不展示
    self.isSearch = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchTextField resignFirstResponder];
}
#pragma mark - 设置导航栏
- (void)resetNavigationBar {
    
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemSearch) target:self action:@selector(searchButtonAction)];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (void)searchButtonAction {
    
    self.isSearch = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationBottom)];
}

#pragma mark - 创建数据源表格
- (void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableCell];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.isSearch) {
        return 50;
    }
    return 0.00000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.isSearch) {
        
        UIView * headrView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headrView.backgroundColor = [UIColor yellowColor];
        self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(50,10,self.view.frame.size.width - 100, 30)];
        [headrView addSubview:self.searchTextField];
        self.searchTextField.placeholder = @"搜索单品";
        self.searchTextField.delegate = self;
        self.searchTextField.font = [UIFont systemFontOfSize:14];;
        self.searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.searchTextField.returnKeyType = UIReturnKeySearch;
        self.searchTextField.backgroundColor = [UIColor whiteColor];
        self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView * searchImageView = [[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"icon_searchBar"]];
        self.searchTextField.leftView = searchImageView;
        
        return headrView;
    }
    return nil;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableCell];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITextFieldDelegate
// 实时搜索
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 变化后的字符串
    NSString * new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    // 变化后的字符串只要发送变化就打印，这里也可以实时网络请求
    if (new_text_str.length > 0) {
        
        NSLog(@"%@",new_text_str);
    }
    return YES;

}
//  确定搜索词搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        
        [self.searchTextField resignFirstResponder];
        NSLog(@"%@",textField.text);
        return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


