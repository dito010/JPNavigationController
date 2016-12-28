//
//  ViewController.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import "ViewController.h"
#import "JPSecondVC.h"
#import "JPNavigationController/JPNavigationControllerKit.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, JPNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *girlImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

const CGFloat headerHeight = 300;
const CGFloat speed = 0.6;
static NSString *reuseID = @"reuse";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"loaded first viewController, 加载了第一个控制器");
    
    // Hide navigation bar.
    // 隐藏导航条.
    self.navigationController.navigationBarHidden = YES;
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    
    
    // Become the delegate of JPNavigationControllerDelegate protocol and, implemented protocol method, then you own left-slip to push function.
    // 成为JPNavigationControllerDelegate协议的代理, 实现协议方法即可拥有左滑push功能.
    self.navigationController.jp_pushDelegate = self;
    
    // Custom status bar style.
    // 自定义状态栏的样式(注意: 这个开关会影响全局).
    self.navigationController.jp_prefersStatusBarStyle = JPStatusBarStyleLight;
}


# pragma mark --------------------------------------
# pragma JPNavigationControllerDelegate

-(void)jp_navigationControllerDidPushLeft{
    [self push2NextVC];
}


# pragma mark --------------------------------------
# pragma Push

-(void)push2NextVC{
    JPSecondVC *secondVc = [[JPSecondVC alloc]init];
    secondVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:secondVc animated:YES];
}


# pragma mark --------------------------------------
# pragma mark TableView Events

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = @"left-slip push to next view controller 👈 👈 ";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect frame = self.girlImageView.frame;
    frame.origin.y = -speed * (scrollView.contentOffset.y + headerHeight ) - 100;
    self.girlImageView.frame = frame;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"左滑了");
//}

@end
