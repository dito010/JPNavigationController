//
//  ViewController.m
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "ViewController.h"
#import "JPSecondVC.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *girlImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

const CGFloat headerHeight = 370;
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
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = @"点我呀";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect frame = self.girlImageView.frame;
    frame.origin.y = -speed * scrollView.contentOffset.y - speed * headerHeight;
    self.girlImageView.frame = frame;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JPSecondVC *secondVc = [[JPSecondVC alloc]init];
    [self.navigationController pushViewController:secondVc animated:YES];
}
@end
