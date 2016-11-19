//
//  JPSecondVC.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import "JPSecondVC.h"
#import "JPThirdVc.h"
#import "JPLinkSubview.h"
#import "JPNavigationController/JPNavigationControllerKit.h"
#import "UINavigationController+JPFullScreenPopGesture.h"

@interface JPSecondVC()<JPLinkSubviewDelegate, JPNavigationControllerDelegate>

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
    
    NSLog(@"Loaded second viewController, 加载了第二个控制器");
    
    // Hide left return button.
    // 隐藏返回按钮.
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sec_reuseID];
    
    
    // You just need pass your link view to this property, framework will display your link view automatically.
    // 你只需要在viewDidLoad:方法里把你的联动视图传给框架, 框架会制动帮你显示.
    self.navigationController.jp_linkView = self.linkSubview;
 
    
    // Become the delegate of JPNavigationControllerDelegate protocol and, implemented protocol method, then you own left-slip to push function.
    // 成为JPNavigationControllerDelegate协议的代理, 实现协议方法即可拥有左滑push功能.
    self.navigationController.jp_delegate = self;
}


# pragma mark --------------------------------------
# pragma mark JPNavigationControllerDelegate

-(void)jp_navigationControllerDidPushLeft{
    [self click];
}

-(void)click{
    JPThirdVc *vc = [[JPThirdVc alloc]init];
    
    // You must call pushViewController:animated: first before set jp_linkViewHeight.
    // 注意： 这两行代码有逻辑关系，必须先push过去，navigationController才会alloc，分配内存地址，才有值.
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationController.jp_linkViewHeight = 44.0f;
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
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Watch out: If the of current display in window is a UITableViewController class, frame will add a contentInset automatically to avoid the link view cover on UITableViewController. but if you add a UITableView on UIViewController's, framework will do nothing for that, you may handle this by yourself.
    // 注意 : 如果识别到你当前控制器为UITableViewController的时候, 如果有联动底部视图, 就会自动为你添加jp_linkViewHeight高度的底部额外滚动区域. 但是, 如果你的控制器是UIViewController上添加了UITableView, 那我不会自动为你添加底部额外滚动区域, 需要你自己为UITableView添加contentInset
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sec_reuseID forIndexPath:indexPath];
    cell.textLabel.text = @"left-slip push to next view controller 👈 👈 ";
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    if (indexPath.row == 7) {
        cell.textLabel.text = @"底部联动视图可跟随全屏手势滑动";
        cell.backgroundColor = [UIColor greenColor];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    if (indexPath.row == 8) {
        cell.textLabel.text = @"有联动底部视图, 已自动添加底部额外滚动区域";
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

@end
