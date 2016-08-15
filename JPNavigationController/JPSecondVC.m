//
//  JPSecondVC.m
//  JPNavigationController
//
//  Created by Chris on 16/7/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPSecondVC.h"
#import "JPThirdVc.h"
#import "JPLinkSubview.h"
#import "JPNavigationController/JPNavigationControllerKit.h"

@interface JPSecondVC()<JPLinkSubviewDelegate>

/** linkSubview */
@property(nonatomic, strong)JPLinkSubview *linkSubview;

@end

const CGFloat sec_linkSubviewH = 80;
#define JPScreenH [UIScreen mainScreen].bounds.size.height
#define JPScreenW [UIScreen mainScreen].bounds.size.width
static NSString *sec_reuseID = @"reuse";
@implementation JPSecondVC
-(JPLinkSubview *)linkSubview{
    if (!_linkSubview) {
        _linkSubview = [JPLinkSubview viewForXib];
        _linkSubview.frame = CGRectMake(0, 0, JPScreenW, sec_linkSubviewH);
        _linkSubview.jp_delegate = self;
    }
    return _linkSubview;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"加载了第二个控制器");
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sec_reuseID];
    
    [self.navigationController.jp_linkContainerView addSubview:self.linkSubview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sec_reuseID forIndexPath:indexPath];
    
    // 如果识别到你当前控制器为UITableViewController的时候, 并且有联动底部视图, 就会自动为你添加jp_linkViewHeight高度的底部额外滚动区域
    
     cell.textLabel.text = @"盼哥最帅";
    if (indexPath.row == 15) {
         cell.textLabel.text = @"有联动底部视图, 已自动添加底部额外滚动区域";
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}


#pragma mark --------------------------------------------------
#pragma mark JPLinkSubviewDelegate
-(void)linkSubview:(JPLinkSubview *)linkSubview didClickBuy:(UIButton *)sender{
    [self click];
}

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickClosePop:(UIButton *)sender{
    NSString *btnTitle = sender.titleLabel.text;
    
    if ([btnTitle isEqualToString:@"暂时关闭pop"]) {
        self.navigationController.jp_closePopForTemporary = YES;
        [sender setTitle:@"打开pop" forState:UIControlStateNormal];
    }
    else if ([btnTitle isEqualToString:@"打开pop"]){
        self.navigationController.jp_closePopForTemporary = NO;
        [sender setTitle:@"暂时关闭pop" forState:UIControlStateNormal];
    }
}

-(void)click{
    JPThirdVc *vc = [[JPThirdVc alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationController.jp_linkViewHeight = 44.0f;
    vc.second = self;
}

@end
