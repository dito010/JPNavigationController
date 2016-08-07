//
//  ViewController.m
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "ViewController.h"
#import "JPSecondVC.h"
#import "JPNavigationController/JPNavigationControllerKit.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *girlImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

const CGFloat headerHeight = 300;
const CGFloat speed = 0.6;
static NSString *reuseID = @"reuse";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"加载了第一个控制器");
    
    // 隐藏导航条
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = @"盼哥最帅 ---> ";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect frame = self.girlImageView.frame;
    frame.origin.y = -speed * (scrollView.contentOffset.y + headerHeight ) - 100;
    self.girlImageView.frame = frame;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JPSecondVC *secondVc = [[JPSecondVC alloc]init];
    secondVc.hidesBottomBarWhenPushed = YES;
    
    // 注意： 这两行代码有逻辑关系，必须先push过去，navigationController才会alloc，分配内存地址，才有值
    [self.navigationController pushViewController:secondVc animated:YES];
    secondVc.navigationController.jp_linkViewHeight = 80.0f;
}

@end
