//
//  JPThirdVc.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import "JPThirdVc.h"
#import "JPNavigationController/JPNavigationControllerKit.h"
#import "JPSecondVC.h"
#import "JPWarpViewController.h"
#import "UINavigationController+JPFullScreenPopGesture.h"

@class JPSecondVC;

@interface JPThirdVc()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popZoneCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLeftCons;

@end

const CGFloat thi_linkSubviewH = 44;
const CGFloat fullPopGesTipLeftCons = 145;
const CGFloat partPopGesTipLeftCons = 20;
#define JPScreenH [UIScreen mainScreen].bounds.size.height
#define JPScreenW [UIScreen mainScreen].bounds.size.width
@implementation JPThirdVc
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"Loaded thrid View controller, 加载了第三个控制器");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *signBtn = [UIButton new];
    signBtn.frame = CGRectMake(0, 0, JPScreenW, thi_linkSubviewH);
    [signBtn setBackgroundColor:[UIColor colorWithRed:128 / 255.0f green:92 / 255.0f blue:248 / 255.0f alpha:1.0f]];
    [signBtn setTitle:@"pop手势范围设置为160" forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.jp_linkView = signBtn;
}

// 设置pop手势范围
-(void)signBtnClick:(UIButton *)btn{
    
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"pop手势范围设置为160"]) {
        
        // The biggest space allow pop leave screen left-slide in current root navigation controller.
        // 在当前根控制器内全局设置最大允许pop手势离屏幕左侧的距离.
        self.navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = 160.0f;
        
        [btn setTitle:@"pop手势范围设置为全屏" forState:UIControlStateNormal];
        self.popZoneCons.constant = 160.0f;
        self.tipLeftCons.constant = partPopGesTipLeftCons;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    else if ([title isEqualToString:@"pop手势范围设置为全屏"]){
        
        // The biggest space allow pop leave screen left-slide in current root navigation controller.
        // 在当前根控制器内全局设置最大允许pop手势离屏幕左侧的距离.
        self.navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = [UIScreen mainScreen].bounds.size.width;
        
        [btn setTitle:@"pop手势范围设置为160" forState:UIControlStateNormal];
        self.popZoneCons.constant = [UIScreen mainScreen].bounds.size.width;
        self.tipLeftCons.constant = fullPopGesTipLeftCons;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    NSLog(@"点击了%@", title);
}

- (IBAction)popto:(id)sender {
    
    // Pop to a target view controller.
    // pop到指定的控制器.
    
    // Plan A: find the target view controller by youself, then pop it.
    // 方案一: 找到目标控制器, pop
//    JPSecondVC *second = nil;
//    NSArray *viewControllers = self.navigationController.jp_rootNavigationController.jp_viewControllers;
//    for (UIViewController *c in viewControllers) {
//        if ([c isKindOfClass:[JPSecondVC class]]) {
//            second = (JPSecondVC *)c;
//        }
//    }
//    if (second) {
//        [self.navigationController popToViewController:second animated:YES];
//    }
    
    // Plan B: use jp_popToViewControllerClassIs: animated:.
    // 方案二: 使用 jp_popToViewControllerClassIs: animated:.
    [self.navigationController jp_popToViewControllerClassIs:[JPSecondVC class] animated:YES];
}


# pragma mark --------------------------------------
# pragma mark Private

-(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
