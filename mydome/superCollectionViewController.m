//
//  superCollectionViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superCollectionViewController.h"
#import "MJRefresh.h"
#import "dataMode.h"
#import "MBTipClass.h"
#import "superCollectionCell.h"
#import "previewViewController.h"
#import "HttpRequestManager.h"
#import "superVideoViewController.h"
#import "moviePlayViewController.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height
@interface superCollectionViewController ()

@end

@implementation superCollectionViewController

static NSString * const reuseIdentifier = @"supercollectioncell";



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownUpData)];
    [self.collectionView.mj_header beginRefreshing];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=YES;
}
-(void)DownUpData
{
    WS(ws);
    self.hub.hidden=NO;
    //在分线程中进行刷新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]initWithCapacity:0];
        
        [[HttpRequestManager shareInstance]getNewsListRequestWithNewsType:self.newsType dataType:100 loadType:@"down" parameters:dic andRequesetSuccess: ^(HttpRequestManager *manager, id object) {
            self.hub.hidden=YES;
            //object 里面是放的所有的模型
            self.dataArray=[dataMode newsListDataTomode:object newsType:self.newsType];
            
                //成功后回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{

                    
                    //刷新用的
                    
                    //刷新表 同时停止刷新
                    [ws.collectionView reloadData];
                    
                    
                    [ws.collectionView.mj_header endRefreshing];
                });
        }andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
            self.hub.hidden=YES;
            [ws.collectionView.mj_header endRefreshing];
            [MBTipClass setTipTitle:@"暂时没有最新数据,请稍后刷新" andView:self.view];

        }];
        
        
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    superCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.mode=self.dataArray[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.newsType==newsVideoType){
        return CGSizeMake(SCREEN_WID, 180);

    }else{
    return CGSizeMake(SCREEN_WID-20, 180);
}
}
#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    dataMode * mode=self.dataArray[indexPath.row];

    if (self.newsType==newsVideoType) {
       

        NSInteger whichShow=arc4random()%3;
       
            UIStoryboard * story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        moviePlayViewController * vv;
        if(whichShow==1)
        {
            vv=[story instantiateViewControllerWithIdentifier:@"moviePlayViewController"];
        }else{
            vv=[[moviePlayViewController alloc]init];
        }
            vv.mode=mode;//为了 id
        
        [[HttpRequestManager shareInstance]getNewsDetailedRequestWithNewsType:newsVideoType newsID:mode.ID andRequesetSuccess:^(HttpRequestManager *manager, id object) {
            dataMode * modee=object;
            modee.ID=mode.ID;
            vv.mode=modee;
            
            [self.navigationController pushViewController:vv  animated:YES];

                    } andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
            
                    }];


        
//    //    }
//        moviePlayViewController * vcc=[[moviePlayViewController alloc]init];
//        vcc.mode=mode;//为了 id
//       [self.navigationController pushViewController:vcc  animated:YES];
//        
        
        
    
    }else{
    
    
    [[HttpRequestManager shareInstance]getNewsDetailedRequestWithNewsType:newsImgType newsID:mode.ID andRequesetSuccess:^(HttpRequestManager *manager, id object) {
        
        dataMode * detailedMode=object;
        previewViewController *vc = [[previewViewController alloc]init];
        vc.mode=mode;
        vc.currentIndex =0;//这个参数表示当前图片的index，默认是0
        
        //图片数组，可以是url，也可以是UIImage
        // 第一种用url
           vc.imgArr =detailedMode.imgUrlArr;
        vc.imageDetailsArray=detailedMode.titleUrlArr;
        
        [self.navigationController pushViewController:vc  animated:YES];
        
    } andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
        
    }];
    
   

    
    }
    
    
}


@end
