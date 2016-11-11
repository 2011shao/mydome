//
//  superVideoViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/8.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superVideoViewController.h"
#import "superVideoCollectionViewCell.h"
#import "MJRefresh.h"
#import "dataMode.h"
#import "MBTipClass.h"
#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height
@interface superVideoViewController ()
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@end

@implementation superVideoViewController

static NSString * const reuseIdentifier = @"supervideocollectioncell";


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    //  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownUpData)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    superVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.mode=self.dataArray[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WID, 180);
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
