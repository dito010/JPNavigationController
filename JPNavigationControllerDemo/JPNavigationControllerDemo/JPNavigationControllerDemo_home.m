/*
 * This file is part of the JPNavigationController package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/newyjp
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "JPNavigationControllerDemo_home.h"
#import "JPNavigationControllerDemo_linkBar.h"
#import "JPNavigationControllerKit.h"

@interface JPNavigationControllerDemo_home ()<UITableViewDelegate, UITableViewDataSource, JPNavigationControllerDelegate>

/**
 * 底层图片容器.
 */
@property(nonatomic, strong) UIImageView *bottomImv;

/**
 * tableView.
 */
@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *const kJPNavigationControllerDemoHomeReuseID = @"com.newpan.navigationcontroller.home.reuse.id";
static const CGFloat kJPNavigationControllerDemoHomeBottomImageHeiDelta = 0.7f;
static const CGFloat kJPNavigationControllerDemoHomeBottomImageViewScrollSpeedDelta = 0.6f;
@implementation JPNavigationControllerDemo_home

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}


#pragma mark - Setup

- (void)setup{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _bottomImv = ({
        UIImageView *imv = [UIImageView new];
        imv.image = [UIImage imageNamed:@"left"];
        [self.view addSubview:imv];
        imv.frame = CGRectMake(0, 0, screenSize.width, screenSize.width * kJPNavigationControllerDemoHomeBottomImageHeiDelta);
        
        imv;
    });
    
    _tableView = ({
        UITableView *tableView = [UITableView new];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.frame = self.view.bounds;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        tableView.contentInset = UIEdgeInsetsMake(screenSize.width * kJPNavigationControllerDemoHomeBottomImageHeiDelta - 20.f, 0, 0, 0);
        
        tableView;
    });
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kJPNavigationControllerDemoHomeReuseID];
    
    // 隐藏导航栏.
    self.navigationController.navigationBar.hidden = YES;
    
    // 注册成为导航控制器代理.
    [self.navigationController jp_registerNavigtionControllerDelegate:self];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}


#pragma mark - JPNavigationControllerDelegate

//- (BOOL)navigationControllerShouldPushRight:(JPNavigationController *)navigationController{
//    return NO;
//}

- (void)navigationControllerDidPush:(JPNavigationController *)navigationController{
    [self push2NextVc];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJPNavigationControllerDemoHomeReuseID forIndexPath:indexPath];
    cell.textLabel.text = @"左滑 push 到下一个控制器";
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect frame = _bottomImv.frame;
    frame.origin.y = -kJPNavigationControllerDemoHomeBottomImageViewScrollSpeedDelta * (scrollView.contentOffset.y + screenSize.width * kJPNavigationControllerDemoHomeBottomImageHeiDelta);
    _bottomImv.frame = frame;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self push2NextVc];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"左滑了");
}


#pragma mark - Private

- (void)push2NextVc{
    JPNavigationControllerDemo_linkBar *vc = [JPNavigationControllerDemo_linkBar new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
