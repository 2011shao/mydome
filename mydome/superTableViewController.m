//
//  superTableViewController.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superTableViewController.h"
#import "MJRefresh.h"
#import "dataMode.h"
#import "baseCell.h"
#import "MBTipClass.h"
#import "superDetailsViewController.h"
@interface superTableViewController ()

@end

@implementation superTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownUpData)];
    [self.tableView.mj_header beginRefreshing];

}

-(void)DownUpData
{
    WS(ws);
    //在分线程中进行刷新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]initWithCapacity:0];
        [[HttpRequestManager shareInstance]getNewsListRequestWithNewsType:self.newsType dataType:self.dataType loadType:@"down" parameters:dic andRequesetSuccess:^(HttpRequestManager *manager, id object) {

            //NSLog(@"%@",object);

            
        self.dataArray=[dataMode newsListDataTomode:object newsType:self.newsType];
                //成功后回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    //object 里面是放的所有的模型
                    
                    //刷新用的
                    
                    //刷新表 同时停止刷新
                    [ws.tableView reloadData];
                    
                    
                    [ws.tableView.mj_header endRefreshing];
                });
        }andRequestFailed:^(HttpRequestManager *manager, NSError *error) {
            [ws.tableView.mj_header endRefreshing];
            [MBTipClass setTipTitle:@"暂时没有最新数据,请稍后刷新" andView:self.view];

        }];

        
    
    });
                   
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard * sory=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    superDetailsViewController * vc =[sory instantiateViewControllerWithIdentifier:@"superDetailsViewController"];
    vc.mode=self.dataArray[indexPath.row];
    vc.titleLabel.text=@"对对对";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    baseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    cell.mode=self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
