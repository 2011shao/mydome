//
//  customSuperViewController.m
//  mydome
//
//  Created by ios-少帅 on 2016/11/10.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "customSuperViewController.h"

@interface customSuperViewController ()

@end

@implementation customSuperViewController


-(MBProgressHUD*)hub
{
    {
        if (!_hub) {
            _hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _hub.label.text=@"加载中...";
            _hub.label.textColor=[UIColor blackColor];
            _hub.contentColor = [UIColor colorWithRed:255.f green:166.0f blue:0.0f alpha:1.f];
            
        }
        return _hub;
    }
}




-(void)customeNavLeftButton
{
    UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftButton.bounds=CGRectMake(0, 0, 44, 44);
    [leftButton addTarget:self action:@selector(navLeftButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"daohang"] forBarMetrics:0];
    self.navigationController.navigationBar.translucent = NO;
    [self customeNavLeftButton];
    // Do any additional setup after loading the view.
}
-(void)navLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height
-(void)customNavTabView
{
    UIView * view=[[UIView alloc]init];
    view.backgroundColor=[UIColor blueColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, SCREEN_HEIHTE-64, 0));
    }];
    
    
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
