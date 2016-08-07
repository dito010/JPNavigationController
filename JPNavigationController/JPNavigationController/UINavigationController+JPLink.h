//
//  UINavigationController+JPLink.h
//  JPNavigationController
//
//  Created by Chris on 16/8/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

// 这是导航控制器的分类，用来保存用户传进来的数据
@class JPLinkContainerView;

@interface UINavigationController (JPLink)

/** 
    联动底部视图的高度
 
    使用时注意 : 如果你下个界面需要有联动底部视图, 你在上个控制器 - (void)pushViewController:animated:方法后面立即把值传给我
    [self.navigationController pushViewController:YourOwnVC animated:YES];
    YourOwnVC.navigationController.jp_linkViewHeight = YourHopeHeight;
 
    同时注意 : 这两行代码有逻辑关系，必须先调用push方法，navigationController才会alloc，分配内存地址，才有值
 */
@property(nonatomic)CGFloat jp_linkViewHeight;


/** 
    联动底部视图
 
    需要添加自定义的视图的时候，只要把自定义的视图添加到这个视图上就可以了
 
    注意 : 如果识别到你当前控制器为UITableViewController的时候, 如果有联动底部视图, 就会自动为你添加jp_linkViewHeight高度的底部额外滚动区域
          但是, 如果你的控制器是UIViewController上添加了UITableView, 那我不会自动为你添加底部额外滚动区域, 需要你自己为UITableView添加contentInset
 */
@property(nonatomic)JPLinkContainerView *jp_linkContainerView;


@end
