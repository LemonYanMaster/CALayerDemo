//
//  CALayerViewController.m
//  CALayerDemo
//
//  Created by pengpeng yan on 16/3/14.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "CALayerViewController.h"

@interface CALayerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UITableView *MainTableView;

@end

@implementation CALayerViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"CALayerType",@"CATextLayerType",@"CAShapeLayerType",@"CATiledLayerType",@"CAGradientLayerType",@"CAEmitterLayerType",@"CAReplicatorLayerType",@"CAScrollLayerType",@"CATransformLayerType"];
    }
    return _dataArr;
}

- (UITableView *)MainTableView{
    if (!_MainTableView) {
        _MainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _MainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = 60;
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
   // self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - system delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ClassString = self.dataArr[indexPath.row];
    Class class = NSClassFromString(ClassString);
    UIViewController *VC = [[class alloc] init];
    VC.title = ClassString;
    VC.view.backgroundColor = [UIColor whiteColor];
    //[self presentViewController:VC animated:YES completion:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

@end