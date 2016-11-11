//
//  previewViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/8.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "previewViewController.h"
@interface previewViewController ()

@end

@implementation previewViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden=no;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBarHidden=NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[HttpRequestManager shareInstance]upDataNewsTipCountWithNewsID:self.mode.ID andRequesetSuccess:^(HttpRequestManager *manager, id object) {
        NSLog(@"----");
    } andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
        
    }];
}
@end
