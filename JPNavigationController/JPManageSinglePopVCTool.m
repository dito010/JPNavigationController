/*
 * This file is part of the JPNavigationController package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "JPManageSinglePopVCTool.h"

@implementation JPManageSinglePopVCTool

static JPManageSinglePopVCTool *_manageInstance;

+(instancetype)shareTool{
    return [[JPManageSinglePopVCTool alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_manageInstance) {
            _manageInstance = [super allocWithZone:zone];
        }
    });
    return _manageInstance;
}

@end
