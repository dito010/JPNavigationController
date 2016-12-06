//
//  JPLinkSubview.h
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import <UIKit/UIKit.h>

@class JPLinkSubview;

@protocol JPLinkSubviewDelegate <NSObject>

@optional

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickCloseAllPop:(UIButton *)sender;

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickClosePop:(UIButton *)sender;

@end


@interface JPLinkSubview : UIView

/** delegate */
@property(nonatomic, weak)id<JPLinkSubviewDelegate> jp_pushDelegate;

+(instancetype)viewForXib;

@end
