//
//  moviePlayViewController.m
//  mydome
//
//  Created by ios-少帅 on 2016/11/9.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "moviePlayViewController.h"
#import "VideoPlayer.h"
#import "Masonry.h"
@interface moviePlayViewController ()<SuperVideoDelegate>
@property (nonatomic,strong) VideoPlayer * myPlayView;
@property (weak, nonatomic) IBOutlet VideoPlayer *xbPlayView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *gaiyaoLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailLabel;

@end

@implementation moviePlayViewController

-(VideoPlayer*)myPlayView
{
    if (!_myPlayView) {
        _myPlayView=[[VideoPlayer alloc]initWithNIB];
        _myPlayView.frame=self.view.bounds;
        _myPlayView.delegate=self;
    }
    return _myPlayView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"视频播放";
    if (self.xbPlayView) {
        [self twoTypeShowView];
    } else{  [self oneTypeShowView];}
    
}
-(void)twoTypeShowView
{
    self.xbPlayView.delegate=self;
     [self.xbPlayView updatePlayerWith:[NSURL URLWithString:@"http://7s1sjv.com2.z0.glb.qiniucdn.com/9F76A25D-9509-DEE9-3D8A-E93F360BB0E5.mp4"]];
}
-(void)oneTypeShowView
{
    [self.myPlayView updatePlayerWith:[NSURL URLWithString:@"http://7s1sjv.com2.z0.glb.qiniucdn.com/9F76A25D-9509-DEE9-3D8A-E93F360BB0E5.mp4"]];
    [self.view addSubview:self.myPlayView];
    
    [self.myPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // Do any additional setup after loading the view.

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.myPlayView removeObserverAndNotification];
    [super viewWillDisappear:animated];

}
-(void)startPortraitLayout
{
    self.navigationController.navigationBarHidden=NO;
    if (self.xbPlayView) {
[self.xbPlayView mas_remakeConstraints:^(MASConstraintMaker *make) {
    
}];
    }

//    [self.myPlayView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
}
-(void)startlandscapeLayout
{    self.navigationController.navigationBarHidden=YES;
    if (self.xbPlayView) {
        [self.xbPlayView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                }];

    }
//    [self.myPlayView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
}
-(void)backClick
{
    if (!self.xbPlayView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.xbPlayView)
    {
        self.titleLabel.text=self.mode.Title;
        self.creatTimeLabel.text=self.mode.RealseTime;
        self.tipLabel.text=[NSString stringWithFormat:@"%@",self.mode.ClickCount];
        self.gaiyaoLabel.text=self.mode.Summary;
        self.detailLabel.text=self.mode.Contnet;
    }

}
//-(void)customeNavLeftButton
//{
//    UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    leftButton.bounds=CGRectMake(0, 0, 44, 44);
//    [leftButton addTarget:self action:@selector(navLeftButton) forControlEvents:UIControlEventTouchUpInside];
//
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
//
//}
@end
