//
//  webViewController.h
//  mydome
//
//  Created by ios-少帅 on 2016/11/10.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "customSuperViewController.h"
#import "mainScrollMode.h"
@interface webViewController : customSuperViewController
@property (nonatomic,strong) mainScrollMode * mode;
@property (nonatomic,copy)NSString * urlStr;

@end
