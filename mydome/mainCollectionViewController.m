//
//  mainCollectionViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "mainCollectionViewController.h"
#import "mainCell.h"
#import "mainReusableFootCell.h"
#import "superTableViewController.h"
#import "superCollectionViewController.h"
#import "superVideoViewController.h"
#import "HttpRequestManager.h"
#import "mainScrollMode.h"
#import "MBTipClass.h"
#import "otherTableViewController.h"
#import "webViewController.h"
#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height
@interface mainCollectionViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSArray * itemImg;
@property (nonatomic,strong) NSArray * itemTitle;
@property (nonatomic,strong) NSArray * scrollModeArr;



@end

@implementation mainCollectionViewController

static NSString * const reuseIdentifier = @"maincell";
-(NSArray*)itemImg
{
    if (!_itemImg) {
        _itemImg=@[@"index1",@"index2",@"index3",@"index4",@"index5",@"index6",@"index7",@"index8",@"index9",];
    }
    return _itemImg;
}
-(NSArray*)itemTitle
{
    if (!_itemTitle) {
        _itemTitle=@[@"检查新闻",@"图说检查",@"视频新闻",@"廉政建设",@"案件聚焦",@"预防天地",@"检务公开",@"检查文学",@"便民服务"];
    }
    return _itemTitle;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
}
-(void)initview
{
    [self.view addSubview:self.scrollciew];
    self.scrollciew.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    
//     [self.view addSubview:self.navTool];
//     self.navTool.frame=CGRectMake(0, 0, SCREEN_WID, 64);

   // self.automaticallyAdjustsScrollViewInsets=NO;
    self.scrollciew.frame=CGRectMake(0, 0, SCREEN_WID, 160);
    self.scrollciew.delegate=self;
    self.collectionView.frame=CGRectMake(0, 160, SCREEN_WID, 600);
   
    [self loadmainScrollviewData];
    
    self.navigationItem.titleView=[self customNaview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat ww=(SCREEN_WID-41)/3;
    //CGFloat hh=ww*1.1;
    CGFloat hh=(SCREEN_HEIHTE-64-160-40-50)/3;

    return CGSizeMake(ww, hh);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    mainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imgView.image=[UIImage imageNamed:self.itemImg[indexPath.row]];
    cell.boomLabel.text=self.itemTitle[indexPath.row];
    return cell;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    mainReusableFootCell *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"mainfootview" forIndexPath:indexPath];
        return footerview;
   
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * stor=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    switch (indexPath.row) {
        case 0:case 3:case 4:case 5:case 6:case 7:
        {
            superTableViewController * vc =[stor instantiateViewControllerWithIdentifier:@"superTableViewController"];
            vc.newsType=newsListType;
            vc.dataType=indexPath.row+1;
            vc.title=self.itemTitle[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];

        }break;
        case 1:case 2:
        {
            superCollectionViewController * vc=[stor instantiateViewControllerWithIdentifier:@"superCollectionViewController"];
                vc.newsType=indexPath.row;//1  是图片 2  是视频
            vc.title=self.itemTitle[indexPath.row];

            [self.navigationController pushViewController:vc animated:YES];
        }break;
//        case 2:{
//            superVideoViewController * vc=[stor instantiateViewControllerWithIdentifier:@"superVideoViewController"];
//            vc.newsType=indexPath.row;//1  是图片 2  是视频
//            [self.navigationController pushViewController:vc animated:YES];
//        }break;
       case 8:
        {
            otherTableViewController *  vc =[stor instantiateViewControllerWithIdentifier:@"otherTableViewController"];
            vc.title=self.itemTitle[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            
        }break;
              default:
            break;
    }




}

//轮播图
-(void)loadmainScrollviewData
{
    [[HttpRequestManager shareInstance]getMainScrollviewDataAndRequesetSuccess:^(HttpRequestManager *manager, id object) {
        NSMutableArray * imgurlArr=[[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray * titleArr=[[NSMutableArray alloc]initWithCapacity:0];
        self.scrollModeArr=[NSArray arrayWithArray:object];
        for (mainScrollMode * mode in object) {
            [imgurlArr addObject:mode.PicHref];
            [titleArr addObject:mode.Title];
        }
        self.scrollciew.imageURLStringsGroup=imgurlArr;
        self.scrollciew.titlesGroup=titleArr;
        
        
    } andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
        
    }];
}
- (IBAction)serverButton:(UIButton *)sender
{
   
    
    webViewController * vc =[[webViewController alloc]init];
     UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navigation animated:YES completion:^{
        
//        vc.view.backgroundColor=[UIColor colorWithPatternImage:viewImage];
        
    }];
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    webViewController * vc=[[webViewController alloc]init];
    vc.mode=self.scrollModeArr[index];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView*)customNaview
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"daohang"] forBarMetrics:0];
    self.navigationController.navigationBar.translucent = NO;
    UIView * naview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WID, 44)];
    naview.backgroundColor=[UIColor clearColor];
    UIImageView * iconImgview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [naview addSubview:iconImgview];
    [iconImgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naview.mas_centerY);
        make.left.equalTo(naview.mas_left).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
        
    }];
    
    UILabel * titview=[[UILabel alloc]init];
    titview.frame=CGRectMake(0, 0, SCREEN_WID, 44);
    titview.backgroundColor=[UIColor clearColor];
    titview.text=@"三门峡市人民检察院";
    titview.textColor=[UIColor whiteColor];
    [naview addSubview:titview];
    
    [titview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naview.mas_centerY);
        make.left.equalTo(iconImgview.mas_right).offset(10);
        make.right.equalTo(naview.mas_right).offset(-20);
        make.height.equalTo(@(30));
    }];
    
    
    
   return naview;
    
}

@end
