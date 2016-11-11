//
//  superVideoViewController.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/8.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "customSuperCollectionViewController.h"
#import "HttpRequestManager.h"
@interface superVideoViewController : customSuperCollectionViewController
@property(nonatomic,assign)NewsType  newsType;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end
