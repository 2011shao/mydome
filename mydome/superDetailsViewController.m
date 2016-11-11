//
//  superDetailsViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superDetailsViewController.h"
#import "Masonry.h"
#import "MBTipClass.h"
@interface superDetailsViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@end

@implementation superDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}
-(void)loadData
{
    self.titleLabel.text=self.mode.Title;
    self.tipLabel.text=[NSString stringWithFormat:@"%@",self.mode.ClickCount];
    self.timeLabel.text=self.mode.RealseTime;
    self.sourceLabel.text=@"无";
    self.plLabel.text=@"没有";
    self.profileLabel.text=self.mode.Summary;
    [self.datailsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    self.datailsWebView.scrollView.bounces=NO;
    self.datailsWebView.scrollView.delegate=self;
    [self.datailsWebView setScalesPageToFit:YES];
    self.datailsWebView.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<140) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-scrollView.contentOffset.y);
        }];
    }
  
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.hub.hidden=NO;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.hub.hidden=YES;

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.hub.hidden=YES;
    
    [MBTipClass setTipTitle:@"加载失败" andView:self.view];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[HttpRequestManager shareInstance]upDataNewsTipCountWithNewsID:self.mode.ID andRequesetSuccess:^(HttpRequestManager *manager, id object) {
        NSLog(@"----");
    } andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
        
    }];
}

@end
