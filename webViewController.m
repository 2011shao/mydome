//
//  webViewController.m
//  mydome
//
//  Created by ios-少帅 on 2016/11/10.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()
@property (nonatomic,strong) UIWebView * webview;

@end

@implementation webViewController
-(UIWebView*)webview
{
    if (!_webview) {
        _webview=[[UIWebView alloc]init];
        [_webview setScalesPageToFit:YES];
        
    }
    return _webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    // Do any additional setup after loading the view.
}
-(void)setMode:(mainScrollMode *)mode
{
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mode.PicHref]]];
    NSLog(@"%@",mode.PicHref);
}
-(void)setUrlStr:(NSString *)urlStr
{
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    NSLog(@"%@",urlStr);

}
-(void)navLeftButton
{
    [super navLeftButton];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
