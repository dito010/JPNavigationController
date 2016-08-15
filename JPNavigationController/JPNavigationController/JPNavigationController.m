//
//  JPNavigationController.m
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPNavigationController.h"
#import "UIViewController+NavExtesion.h"
#import "JPNavigationBar.h"
#import "UINavigationController+JPLink.h"
#import "JPLinkContainerView.h"

#import <objc/runtime.h>


#define kDefaultBackImageName @"JPImage.bundle/backImage"



// ----------------------------------------- JPWarpNavigationController ----------------------------------------------

@interface JPWarpNavigationController : UINavigationController

/** 联动视图 */
@property(nonatomic, strong)JPLinkContainerView *linkView;

@end


#define JPScreenH [UIScreen mainScreen].bounds.size.height
#define JPScreenW [UIScreen mainScreen].bounds.size.width
@implementation JPWarpNavigationController
-(JPLinkContainerView *)linkView{
    if (!_linkView) {
        _linkView = [[JPLinkContainerView alloc]init];
        _linkView.backgroundColor = [UIColor clearColor];
        _linkView.frame = CGRectMake(0, JPScreenH - self.jp_linkViewHeight - 20, JPScreenW, self.jp_linkViewHeight);
        [self.navigationBar addSubview:_linkView];
    }
    return _linkView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    JPNavigationBar *navBar = [[JPNavigationBar alloc]init];
    [self setValue:navBar forKey:@"navigationBar"];
    
    UIViewController *childViewController = self.viewControllers.firstObject;
    if (!childViewController) return;
    
    // 有了联动底部视图以后，如果传进来的控制器是一个UITableViewController,我们要为这个UITableViewController底部添加一个额外的滚动区域，防止联动底部视图挡住UITableViewController的内容

    if (self.jp_linkViewHeight > 0) { // 视为有联动视图
        self.jp_linkContainerView = self.linkView;
        
        if ([childViewController isKindOfClass:[UITableViewController class]]) {
            UITableViewController *aVc = (UITableViewController *)self.viewControllers.firstObject;
            aVc.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.jp_linkViewHeight, 0);
            
            // NSLog(@"avc%@", NSStringFromUIEdgeInsets(aVc.tableView.contentInset));
        }
    }
    
    SEL popNoteSel = @selector(setJp_interactivePopMaxAllowedInitialDistanceToLeftEdgeNote:);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:popNoteSel name:@"jp_interactivePopMaxNote" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"jp_interactivePopMaxNote" object:nil];
}

-(void)setJp_interactivePopMaxAllowedInitialDistanceToLeftEdgeNote:(NSNotification *)note{
    UIViewController *childViewController = self.viewControllers.firstObject;
    if (!childViewController) return;
    CGFloat distance = [note.object floatValue];
    CGFloat orginDistance = childViewController.jp_navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    
    // 防止循环引用
    if (orginDistance == distance) return;
    
    if (distance >= 0 ) {
        childViewController.jp_navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = distance;
    }
}

/** 压入栈 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.jp_navigationController = (JPNavigationController *)self.navigationController;
    viewController.jp_fullScreenPopGestureEnabled = viewController.jp_navigationController.jp_fullScreenPopGestureEnabled;
    
    UIImage *backImage = viewController.jp_navigationController.backButtonImage;
    if (!backImage) {
        backImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    // 注意, 这里压入的是一个包装过后的控制器JPWarpViewController
    JPWarpViewController *warpViewController = [[JPWarpViewController new] warpViewController:viewController];
    viewController.jp_warpViewController = warpViewController;
    [self.navigationController pushViewController:warpViewController animated:animated];
}

/** 点击返回按钮 */
-(void)didTapBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 出栈 */
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [self.navigationController popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    // 弹出应该找到包裹viewController的那个JPWarpViewController,pop该控制器
    return [self.navigationController popToViewController:viewController.jp_warpViewController animated:animated];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.jp_navigationController = nil;
    self.jp_linkContainerView = nil;
}

@end




// ----------------------------------------- JPWarpViewController ----------------------------------------------

@interface JPWarpViewController()

/** 用户的传进来的控制器包装一层以后的nav ----> 解决懒加载问题 */
@property(nonatomic, strong)JPWarpNavigationController *warpNav;

@end


static NSValue *jp_tabBarRectValue;
@implementation JPWarpViewController
-(JPWarpViewController *)warpViewController:(UIViewController *)viewController{
    // 创建导航控制器
    JPWarpNavigationController *warpNav = [[JPWarpNavigationController alloc]init];
    // 把传进来的控制器用导航控制器包装
    warpNav.viewControllers = @[viewController];
    
    [self addChildViewController:warpNav];
    
    self.warpNav = warpNav;
    
    // 返回
    return self;
}

/* 解决懒加载问题 */
-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 把导航控制器的view添加到到新建的viewController上面, 把导航控制器作为新建view的子控制器
    [self.view addSubview:self.warpNav.view];
}

/** 传进来的被包装的控制器 */
-(UIViewController *)rootViewController{
    JPWarpNavigationController *warpNav = self.childViewControllers.firstObject;
    return warpNav.viewControllers.firstObject;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !jp_tabBarRectValue) {
        jp_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && jp_tabBarRectValue) {
        self.tabBarController.tabBar.frame = jp_tabBarRectValue.CGRectValue;
    }
}

-(BOOL)jp_fullScreenPopGestureEnabled{
    return [self rootViewController].jp_fullScreenPopGestureEnabled;
}

-(BOOL)hidesBottomBarWhenPushed{
    return [self rootViewController].hidesBottomBarWhenPushed;
}

-(UITabBarItem *)tabBarItem{
    return [self rootViewController].tabBarItem;
}

-(NSString *)title{
    return [self rootViewController].title;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return [self rootViewController];
}

-(UIViewController *)childViewControllerForStatusBarHidden{
    return [self rootViewController];
}

@end




// ----------------------------- _JPFullscreenPopGestureRecognizerDelegate -----------------------------------

@interface _JPFullscreenPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

/** 暂时关闭pop手势 */
@property(nonatomic, assign)BOOL closePopForTemporary;

@end


@implementation _JPFullscreenPopGestureRecognizerDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    // 根控制器不允许pop
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // 当用户禁止的时候,不允许pop
    if (!self.navigationController.jp_fullScreenPopGestureEnabled) {
        return NO;
    }
    
    // 当开始触发的点大于用户指定的最大触发点的时候,禁止pop
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = self.navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance >= 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // 正在做过渡动画的时候禁止pop
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // 反向滑动禁止pop
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    // 暂时关闭pop手势禁止pop
    if (self.closePopForTemporary) {
        return NO;
    }
    
    return YES;
}

@end




// ----------------------------------------- JPNavigationController ----------------------------------------------

@interface JPNavigationController()

// 全屏手势
@property (nonatomic, strong) UIPanGestureRecognizer *jp_fullscreenPopGestureRecognizer;

// pop手势代理这者
@property (nonatomic, strong) _JPFullscreenPopGestureRecognizerDelegate *jp_popGestureRecognizerDelegate;

@end


@implementation JPNavigationController
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        rootViewController.jp_navigationController = self;
        self.viewControllers = @[[[JPWarpViewController new]warpViewController:rootViewController]];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.viewControllers.firstObject.jp_navigationController = self;
        self.viewControllers = @[[[JPWarpViewController new] warpViewController:self.viewControllers.firstObject]];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 测地隐藏导航栏
    [self setNavigationBarHidden:YES];
    
    // 添加pop手势(懒加载)
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.jp_fullscreenPopGestureRecognizer]) {
        
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.jp_fullscreenPopGestureRecognizer];
        
        // 用自己的手势替换系统的pop
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id target = [targets.firstObject valueForKey:@"target"];
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        self.jp_fullscreenPopGestureRecognizer.delegate = [self jp_popGestureRecognizerDelegate];
        [self.jp_fullscreenPopGestureRecognizer addTarget:target action:action];
        
        // 系统手势置为不可用
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // 默认全屏pop
    self.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = [UIScreen mainScreen].bounds.size.width;
    self.jp_fullScreenPopGestureEnabled = YES;
    
    SEL selector = @selector(closePopForTemporaryNote:);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:selector name:@"jp_closePopForTemporaryNote" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"jp_closePopForTemporaryNote" object:nil];
}

-(void)closePopForTemporaryNote:(NSNotification *)note{
    BOOL isClose = [note.object boolValue];
    if (self.jp_popGestureRecognizerDelegate.closePopForTemporary != isClose) {
        self.jp_popGestureRecognizerDelegate.closePopForTemporary = isClose;
    }
}

// 自定义的pop手势
-(UIPanGestureRecognizer *)jp_fullscreenPopGestureRecognizer{
    if (!_jp_fullscreenPopGestureRecognizer) {
        _jp_fullscreenPopGestureRecognizer = [UIPanGestureRecognizer new];
        _jp_fullscreenPopGestureRecognizer.maximumNumberOfTouches = 1;
    }
    return _jp_fullscreenPopGestureRecognizer;
}

// 创建代理(懒加载的)
- (_JPFullscreenPopGestureRecognizerDelegate *)jp_popGestureRecognizerDelegate{
    if (!_jp_popGestureRecognizerDelegate) {
        _jp_popGestureRecognizerDelegate = [_JPFullscreenPopGestureRecognizerDelegate new];
        _jp_popGestureRecognizerDelegate.navigationController = self;
    }
    return _jp_popGestureRecognizerDelegate;
}

-(NSArray *)jp_viewControllers{
    NSMutableArray *arrM = [NSMutableArray array];
    for (JPWarpViewController *warpViewController in self.viewControllers) {
        [arrM addObject:warpViewController.rootViewController];
    }
    return arrM.copy;
}

@end




// ------------------------- UINavigationController_Category_JPFullScreenPopGesture ------------------------------

@implementation UINavigationController (JPFullScreenPopGesture)

// 最大允许开始pop手势的距离
-(void)setJp_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)jp_interactivePopMaxAllowedInitialDistanceToLeftEdge{

    SEL key = @selector(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    CGFloat distance = jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 推送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jp_interactivePopMaxNote" object:@(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge)];
}

-(CGFloat)jp_interactivePopMaxAllowedInitialDistanceToLeftEdge{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

// 暂时关闭pop手势
-(void)setJp_closePopForTemporary:(BOOL)jp_closePopForTemporary{
    // 推送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jp_closePopForTemporaryNote" object:@(jp_closePopForTemporary)];
}

-(BOOL)jp_closePopForTemporary{
    return 0;
}

@end

