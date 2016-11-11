//
//  superTableViewController.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "customSuperTableViewController.h"
#import "HttpRequestManager.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


@interface superTableViewController : customSuperTableViewController
/**
 * 数据
 */
@property (nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,assign)NewsType  newsType;
@property(nonatomic,assign)NewRequestURL  dataType;

/**
 *下拉刷新
 */
-(void)DownUpData;

@end
