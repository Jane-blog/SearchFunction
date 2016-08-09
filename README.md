# SearchFunction
这是一个搜索功能的DEMO，其中涉及到系统自带的控件搜索和自定义的搜索
||该项目中涉及到了UISearchController（注释：iOS8.0后启用，UISearchDisplayControlleriOS8.0前已被UISearchController替代），以及UITextField自定义的搜索框
> 关键点代码 (查找内容)
>    // 方法一:([c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。)
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] %@",searchController.searchBar.text];
    
    //  数组提供的快速遍历,返回的类型是NSArray
    
    NSLog(@"%@",[ _searchResults filteredArrayUsingPredicate:predicate]);
    
    // 方法二:
    
    for (int i = 0; i < _searchResults.count; i++) {
        
        if ([predicate evaluateWithObject:[ _searchResults objectAtIndex:i]]) {
            
            NSLog(@"%@",[_searchResults objectAtIndex:i]);
            
        }
        
    }
# 实现textField实时搜索
> 关键代码
>  实时搜索: - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    
    // 变化后的字符串
    NSString * new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    // 变化后的字符串只要发送变化就打印，这里也可以实时网络请求
    if (new_text_str.length > 0) {
        
        NSLog(@"%@",new_text_str);
    }

#Contact
This is according to the relevant information on the apple official documentation and  making do some summary, if you found inaccurate or have new Suggestions can contact me WeChat: cz192230531, or to carry my PR in the making, welcome to contact.
