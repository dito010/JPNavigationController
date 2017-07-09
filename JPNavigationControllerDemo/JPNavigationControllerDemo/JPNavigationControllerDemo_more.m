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

#import "JPNavigationControllerDemo_more.h"
#import "JPQRCodeTool.h"

@interface JPNavigationControllerDemo_more ()

@property (weak, nonatomic) IBOutlet UIImageView *imv;

@property (weak, nonatomic) IBOutlet UIButton *jianshuBtn;

@property (weak, nonatomic) IBOutlet UIButton *githubBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@end

@implementation JPNavigationControllerDemo_more

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imv.layer.cornerRadius = self.imv.bounds.size.width * 0.5;
    self.imv.clipsToBounds = YES;
    self.title = @"JPNavigationController";
    
    self.jianshuBtn.layer.cornerRadius =
    self.githubBtn.layer.cornerRadius =
    self.qqBtn.layer.cornerRadius = 5.0;
}

- (IBAction)jianshuBtnClick:(id)sender {
    [self gotoWebForGivenWebSite:@"http://www.jianshu.com/u/e2f2d779c022"];
}

- (IBAction)githubBtnClick:(id)sender {
    [self gotoWebForGivenWebSite:@"https://github.com/newyjp"];
}

- (IBAction)qqBtnClick:(id)sender {
    [self goQRCode];
}

-(void)gotoWebForGivenWebSite:(NSString *)webSite{
    if (webSite.length==0)
        return;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webSite]];
}

-(void)goQRCode{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"扫描加入 NewPan 和他的朋友们群";
    
    NSArray *colors = @[[UIColor colorWithRed:98.0/255.0 green:152.0/255.0 blue:209.0/255.0 alpha:1], [UIColor colorWithRed:190.0/255.0 green:53.0/255.0 blue:77.0/255.0 alpha:1]];
    NSString *codeStr = @"http://qm.qq.com/cgi-bin/qm/qr?k=iOcOSuD9eYS7kdmcclRFnWFkHZbGIjdm";
    
    UIImage *img = [JPQRCodeTool generateCodeForString:codeStr withCorrectionLevel:kQRCodeCorrectionLevelNormal SizeType:kQRCodeSizeTypeCustom customSizeDelta:50 drawType:kQRCodeDrawTypeCircle gradientType:kQRCodeGradientTypeDiagonal gradientColors:colors];
    UIImageView *imv = [UIImageView new];
    imv.image = img;
    imv.center = CGPointMake(vc.view.center.x, vc.view.center.y - 60.f);
    imv.bounds = CGRectMake(0, 0, 250, 250);
    [vc.view addSubview:imv];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
