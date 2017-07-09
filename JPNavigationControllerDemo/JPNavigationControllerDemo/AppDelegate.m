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

#import "AppDelegate.h"
#import "JPNavigationControllerDemo_home.h"
#import "JPNavigationControllerDemo_more.h"

#import "JPNavigationControllerKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启动图片延时: 2 秒
    [NSThread sleepForTimeInterval:2];

    JPNavigationControllerDemo_home *home = [JPNavigationControllerDemo_home new];
    JPNavigationController *nav_home = [[JPNavigationController alloc]initWithRootViewController:home];
    nav_home.tabBarItem.image = [UIImage imageNamed:@"home"];
    nav_home.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_se"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_home.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    JPNavigationControllerDemo_more *more = [JPNavigationControllerDemo_more new];
    JPNavigationController *nav_more = [[JPNavigationController alloc]initWithRootViewController:more];
    nav_more.tabBarItem.image = [UIImage imageNamed:@"more"];
    nav_more.tabBarItem.selectedImage = [[UIImage imageNamed:@"more_se"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_more.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    UITabBarController *tabbarVc = [UITabBarController new];
    tabbarVc.viewControllers = @[nav_home, nav_more];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

//    UIViewController *rootVc = [UIViewController new];
//    [rootVc addChildViewController:tabbarVc];
//    [rootVc.view addSubview:tabbarVc.view];
    
    self.window.rootViewController = tabbarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
