//
//  JPNavigationController.m
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPNavigationController.h"
#import "UIViewController+NavExtesion.h"

#define kDefaultBackImageName @"backImage"


#pragma mark -----------------------------------------
#pragma mark JPWarpNavigationController
@interface JPWarpNavigationController : UINavigationController

@end

@implementation JPWarpNavigationController

/** 压入栈 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.jp_navigationController = (JPNavigationController *)self.navigationController;
    viewController.jp_fullScreenPopGestureEnabled = viewController.jp_navigationController.fullScreenPopGestureEnabled;
    
    UIImage *backImage = viewController.jp_navigationController.backButtonImage;
    if (!backImage) {
        backImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    // 注意, 这里压入的是一个包装过后的控制器JPWarpViewController
    [self.navigationController pushViewController:[[JPWarpViewController new] warpViewController:viewController] animated:animated];
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
    JPNavigationController *nav = viewController.jp_navigationController;
    NSInteger index = [nav.jp_viewControllers indexOfObject:viewController];
    
    return [self.navigationController popToViewController:nav.jp_viewControllers[index] animated:animated];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.jp_navigationController = nil;
}

@end


#pragma mark -----------------------------------------
#pragma mark JPWarpViewController
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

#pragma mark -----------------------------------------
#pragma mark 导航控制器
@interface JPNavigationController()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

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
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}

#pragma mark -----------------------------------------
#pragma mark UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isRootViewController = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.jp_fullScreenPopGestureEnabled) {
        if (isRootViewController) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        }
        else{
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    else{
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootViewController;
    }
}


#pragma mark -----------------------------------------
#pragma mark UIGestureRecognizerDelegate
// 修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    // 该方法是询问代理, 当有一个手势对应多个操作的时候,是否同步执行多个操作
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return [gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]];
}

-(NSArray *)jp_viewControllers{
    NSMutableArray *arrM = [NSMutableArray array];
    for (JPWarpViewController *warpViewController in self.viewControllers) {
        [arrM addObject:warpViewController.rootViewController];
    }
    return arrM.copy;
}

@end

