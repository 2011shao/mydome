//
//  customSuperViewController.h
//  mydome
//
//  Created by ios-少帅 on 2016/11/10.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "masonry.h"
#import "HttpRequestManager.h"
@interface customSuperViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD* hub;

-(void)navLeftButton;
@end
