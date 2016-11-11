//
//  superDetailsViewController.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "customSuperViewController.h"
#import "dataMode.h"

@interface superDetailsViewController : customSuperViewController
/*
 * 新闻标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*
 * 新闻时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/*
 * 新闻来源
 */
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

/*
 * 新闻评论
 */
@property (weak, nonatomic) IBOutlet UILabel *plLabel;
/*
 * 新闻点击
 */
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

/*
 * 新闻概要
 */
@property (weak, nonatomic) IBOutlet UILabel * profileLabel;
/*
 * 新闻详情
 */
@property (weak, nonatomic) IBOutlet UILabel * detailsLabel;
/*
 * 新闻详情
 */
@property (weak, nonatomic) IBOutlet UIWebView *datailsWebView;

@property (nonatomic,strong) dataMode * mode;

@end
