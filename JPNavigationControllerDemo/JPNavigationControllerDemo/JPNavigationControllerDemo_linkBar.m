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

#import "JPNavigationControllerDemo_linkBar.h"
#import "JPNavigationControllerKit.h"
#import <UIView+WebVideoCache.h>
#import "JPNavigationControllerCompat.h"
#import "JPNavigationControllerDemo_range.h"

@interface JPNavigationControllerDemo_linkBar ()<JPNavigationControllerDelegate, JPVideoPlayerDelegate>

/**
 * 视频播放容器.
 */
@property(nonatomic, strong) UIView *videoContainerView;

@end

@implementation JPNavigationControllerDemo_linkBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_videoContainerView jp_playVideoWithURL:[NSURL URLWithString:@"http://lavaweb-10015286.video.myqcloud.com/%E5%B0%BD%E6%83%85LAVA.mp4"]];
    _videoContainerView.jp_videoPlayerDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_videoContainerView jp_stopPlay];
}

- (void)dealloc{
    _videoContainerView.jp_videoPlayerDelegate = nil;
}


#pragma mark - JPNavigationControllerDelegate

- (void)navigationControllerDidPush:(JPNavigationController *)navigationController{
    JPNavigationControllerDemo_range *vc = [JPNavigationControllerDemo_range new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)navigationControllerShouldStartPop:(JPNavigationController *)navigationController{
    return YES;
}


#pragma mark - JPVideoPlayerDelegate

- (void)playingStatusDidChanged:(JPVideoPlayerPlayingStatus)playingStatus{
    if (playingStatus == JPVideoPlayerPlayingStatusPlaying) {
        NSLog(@"开始播放视频");
    }
}


#pragma mark - Setup

- (void)setup{
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"联动视图";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
    
    [self setupNavigationEvents];
    [self addVideoContainer];
    
    [self addLinkView];
}

- (void)setupNavigationEvents{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.18 green:0.66 blue:0.15 alpha:1] jp_image] forBarMetrics:UIBarMetricsDefault];
    
    // 因为界面中有 AVPLayer 在播放视频, 所以为了保证 pop 手势执行的过程中视频能正常播放, 使用自定义的 pop 动画.
    self.navigationController.jp_useCustomPopAnimationForCurrentViewController = YES;
    
    // 注册 `JPNavigationController` 导航控制器的代理.
    [self.navigationController jp_registerNavigtionControllerDelegate:self];
}

- (void)addVideoContainer{
    _videoContainerView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed:0.18 green:0.66 blue:0.15 alpha:1];
        view.bounds = CGRectMake(0, 0, JPScreenW, JPScreenW*9.0/16.0);
        view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        [self.view addSubview:view];
        
        view;
    });
}

- (void)addLinkView{
    UIView *linkView = [UIView new];
    linkView.backgroundColor = [UIColor colorWithRed:0.18 green:0.66 blue:0.15 alpha:1];
    self.navigationController.jp_linkViewHeight = 80.f;
    self.navigationController.jp_linkView = linkView;
    
    
    UILabel *label = [UILabel new];
    label.text = @"我是联动视图";
    label.font = [UIFont systemFontOfSize:18.f];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.center = CGPointMake(self.view.center.x, linkView.center.y - 20.f);
    [linkView addSubview:label];
    
    UIButton *popCloseBtn = [UIButton new];
    [linkView addSubview:popCloseBtn];
    popCloseBtn.frame = CGRectMake(0, 35.f, JPScreenW * 0.5, linkView.bounds.size.height - 35.f);
    [popCloseBtn setTitle:@"为当前页面关闭 pop" forState:UIControlStateNormal];
    [popCloseBtn setTitle:@"为当前页面打开 pop" forState:UIControlStateSelected];
    popCloseBtn.backgroundColor = [UIColor colorWithRed:242.0 / 255 green:35.0 / 255 blue:32.0 / 255 alpha:1.f];
    [popCloseBtn addTarget:self action:@selector(closePopForCurrentVcBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *popCloseAllBtn = [UIButton new];
    [linkView addSubview:popCloseAllBtn];
    popCloseAllBtn.frame = CGRectMake(JPScreenW * 0.5, 35.f, JPScreenW * 0.5, linkView.bounds.size.height - 35.f);
    [popCloseAllBtn setTitle:@"为所有页面关闭 pop" forState:UIControlStateNormal];
    [popCloseAllBtn setTitle:@"为所有页面打开 pop" forState:UIControlStateSelected];
    popCloseAllBtn.backgroundColor = [UIColor colorWithRed:248.0 / 255 green:107.0 / 255 blue:37.0 / 255 alpha:1.f];
    [popCloseAllBtn addTarget:self action:@selector(closePopForAllVcsBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Btn Events

- (void)closePopForCurrentVcBtnDidClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    // control pop gesture for current viewController.
    self.navigationController.jp_closePopForCurrentViewController = btn.selected;
    
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithRed:242.0 / 255 green:35.0 / 255 blue:32.0 / 255 alpha:0.6f];
    }
    else{
        btn.backgroundColor = [UIColor colorWithRed:242.0 / 255 green:35.0 / 255 blue:32.0 / 255 alpha:1];
    }
}

- (void)closePopForAllVcsBtnDidClick:(UIButton *)btn{
    btn.selected = !btn.selected;

    // control pop gesture for all viewControllers in stack.
    self.navigationController.jp_closePopForAllViewControllers = btn.selected;

    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithRed:248.0 / 255 green:107.0 / 255 blue:37.0 / 255 alpha:0.6f];
    }
    else{
        btn.backgroundColor = [UIColor colorWithRed:248.0 / 255 green:107.0 / 255 blue:37.0 / 255 alpha:1.f];
    }
}

@end
