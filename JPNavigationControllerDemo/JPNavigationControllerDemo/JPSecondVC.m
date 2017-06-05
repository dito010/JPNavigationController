/*
 * This file is part of the JPNavigationController package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "JPSecondVC.h"
#import "JPThirdVc.h"
#import "JPLinkSubview.h"
#import "JPNavigationControllerKit.h"
#import <AFNetworking.h>
#import "JPSnapTool.h"

@interface JPSecondVC()<JPLinkSubviewDelegate, JPNavigationControllerDelegate>

/** linkSubview */
@property(nonatomic, strong)JPLinkSubview *linkSubview;

/** dataListArr */
@property(nonatomic, strong)NSArray *listArr;

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
        _linkSubview.jp_pushDelegate = self;
    }
    return _linkSubview;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"Loaded second viewController, 加载了第二个控制器");
    
    // Hide left return button.
    // 隐藏返回按钮.
    // self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sec_reuseID];
    
    // Set link view height.
    self.navigationController.jp_linkViewHeight = 80.0f;
    
    // You just need pass your link view to this property, framework will display your link view automatically.
    // 你只需要在viewDidLoad:方法里把你的联动视图传给框架, 框架会制动帮你显示.
    self.navigationController.jp_linkView = self.linkSubview;
 
    
    // Become the delegate of JPNavigationControllerDelegate protocol and, implemented protocol method, then you own left-slip to push function.
    // 成为JPNavigationControllerDelegate协议的代理, 实现协议方法即可拥有左滑push功能.
    self.navigationController.jp_pushDelegate = self;
    
    [self loadData];
    [self.navigationController.navigationBar setBackgroundImage:[JPSnapTool imageWithColor:self.view.tintColor] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark --------------------------------------------------
#pragma mark Data

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *listArr = responseObject[@"list"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in listArr) {
            NSString *name = dict[@"name"];
            [arrM addObject:name];
        }
        self.listArr = [arrM copy];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


# pragma mark --------------------------------------
# pragma mark JPNavigationControllerDelegate

-(void)jp_navigationControllerDidPushLeft{
    [self click];
}

-(void)click{
    JPThirdVc *vc = [[JPThirdVc alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --------------------------------------------------
#pragma mark JPLinkSubviewDelegate

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickCloseAllPop:(UIButton *)sender{
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"全局关闭pop"]) {
        self.navigationController.jp_closePopForAllViewController = YES;
        [sender setTitle:@"全局打开pop" forState:UIControlStateNormal];
    }
    else if ([btnTitle isEqualToString:@"全局打开pop"]){
        self.navigationController.jp_closePopForAllViewController = NO;
        [sender setTitle:@"全局关闭pop" forState:UIControlStateNormal];
    }
}

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickClosePop:(UIButton *)sender{
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"为这个页面关闭pop"]) {
        self.navigationController.jp_closePopForCurrentViewController = YES;
        [sender setTitle:@"为这个页面打开pop" forState:UIControlStateNormal];
    }
    else if ([btnTitle isEqualToString:@"为这个页面打开pop"]){
        self.navigationController.jp_closePopForCurrentViewController = NO;
        [sender setTitle:@"为这个页面关闭pop" forState:UIControlStateNormal];
    }
}


# pragma mark --------------------------------------
# pragma mark TableView Events

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Watch out: If the of current display in window is a UITableViewController class, frame will add a contentInset automatically to avoid the link view cover on UITableViewController. but if you add a UITableView on UIViewController's, framework will do nothing for that, you may handle this by yourself.
    // 注意 : 如果识别到你当前控制器为UITableViewController的时候, 如果有联动底部视图, 就会自动为你添加jp_linkViewHeight高度的底部额外滚动区域. 但是, 如果你的控制器是UIViewController上添加了UITableView, 那我不会自动为你添加底部额外滚动区域, 需要你自己为UITableView添加contentInset
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sec_reuseID forIndexPath:indexPath];
    if (indexPath.row<self.listArr.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"数据来自百思推荐页 %@", self.listArr[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    if (indexPath.row == self.listArr.count) {
        cell.textLabel.text = @"底部联动视图可跟随全屏手势滑动";
        cell.backgroundColor = [UIColor greenColor];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    if (indexPath.row == self.listArr.count+1) {
        cell.textLabel.text = @"有联动底部视图, 已自动添加底部额外滚动区域";
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

@end
