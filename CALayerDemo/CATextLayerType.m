//
//  CATextLayerType.m
//  CALayerDemo
//
//  Created by pengpeng yan on 16/3/15.
//  Copyright © 2016年 peng yan. All rights reserved.
//
//  展示搜索框
//  展示搜索框
//  展示搜索框
//  展示搜索框
//  展示搜索框
//  展示搜索框
#import "CATextLayerType.h"
@interface CATextLayerType()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UISearchBar *searchBar;
@end
@implementation CATextLayerType
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _mainTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self creatSearch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"All";
    return cell;
}

- (void)creatSearch{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 50, 40)];
    self.searchBar.placeholder = @"enter province name";
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All",@"A",@"B",@"C",nil];
    self.searchBar.showsScopeBar = YES;
    self.searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    self.searchBar.showsBookmarkButton = YES;
    self.mainTableView.tableHeaderView = self.searchBar;//将searchBar添加到tableView的头,注意滚动出屏幕后，搜索框也不在了，只出现在首页
    UISearchDisplayController *searchVC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    searchVC.active = NO;
    searchVC.delegate = self;
    searchVC.searchResultsDelegate = self;
    searchVC.searchResultsDataSource = self;
}





@end
