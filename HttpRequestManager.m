

//
//  HttpRequestManager.m
//  XYB-DOME
//
//  Created by ios-少帅 on 16/4/28.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#define BaseURL @"http://123.56.153.172:8872/News/"// IP
#define GetMainScrollviewURL @"GetHomePicNews"//轮播图

/**
 *  获取新闻列表
 */
#define GetNewsListBase @"GetNewsList"//文字新闻列表
#define GetNewsImgBase @"GetPicNewsList"// 图片新闻列表
#define GetNewsVideoBase @"GetVideoNewsList"//视频新闻列表

#define GetNewsImgDetails_URL @"GetPicNewsDetails"//图片详情
#define GetNewsVideoDetails_URL @"GetVideoNewsDetails"//视频详情

#define DataNewsTipCount_Url @"UpdateReadTimes"//新闻点击次数更新

#define GetOneType_URL  @"1"
#define GetTwoType_URL  @"appHomework/findBySCid"
#define GetThreeType_URL  @"appHomework/findBySCid"
#define GetFourType_URL  @"2"
#define GetFiveType_URL  @"3"
#define GetSixType_URL  @"4"
#define GetSevenType_URL  @"5"
#define GetEightType_URL  @"6"




#import "HttpRequestManager.h"
#import "AFNetworking.h"
#import "MBTipClass.h"

#import "dataMode.h"
#import "mainScrollMode.h"
@implementation HttpRequestManager{
    AFHTTPSessionManager * _manager;
}


//网络管理的单例类
+(instancetype) shareInstance
{
    static HttpRequestManager * manager;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        manager = [[HttpRequestManager alloc]init] ;
    }) ;
    
    return manager ;
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        _manager=[[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
        _manager.responseSerializer = [AFJSONResponseSerializer  serializer];
        _manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 20.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _manager.responseSerializer.acceptableContentTypes = [NSSet  setWithObjects:@"text/html", @"text/javascript", @"application/json",@"text/plain",nil];

      
        //监控网络状态
        [self networkState];



    
}
    return self;

}

-(void)networkState
{
    //  __block AFHTTPSessionManager * mager=_manager;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //用的流量
                
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //nslog(@"我有wifi哦");
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //nslog(@"-------连不上网了------");
          
                //  [mager.operationQueue cancelAllOperations];
            }
                break;
            default:
                break;
        }
    }];
    [_manager.reachabilityManager startMonitoring];
}

-(void)getMainScrollviewDataAndRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;
{
    
    
    [_manager GET:GetMainScrollviewURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSMutableArray * scrollArr=[[NSMutableArray alloc]initWithCapacity:0];
            for (NSDictionary * dic in responseObject) {
                mainScrollMode * mode=[[mainScrollMode alloc]init];
                for (NSString * key in dic.allKeys) {
                    [mode setValue:dic[key] forKey:key];
                }
                [scrollArr addObject:mode];
            }
            
            success(self,scrollArr);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(self,error);
        
        NSLog(@"%@",error);
        
    }];
    
}



/**
 *  获取新闻列表数据
 *
 */
-(void)getNewsListRequestWithNewsType:(NewsType)newsType dataType:(NewRequestURL)datatype  loadType:(NSString*)loadtype parameters:(NSMutableDictionary*)parameters andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed
{
    [self networkState];
    
    [parameters setObject:@"0" forKey:@"newsId"];//
    [parameters setObject:loadtype forKey:@"loadType"];//加载方式
    
    NSString * WhitchURL = nil;

    switch (newsType) {
        case newsListType:
        {
            WhitchURL=GetNewsListBase;
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)datatype] forKey:@"dataType"];

        }            break;
        case newsImgType:
            WhitchURL=GetNewsImgBase;
            break;
        case newsVideoType:
            WhitchURL=GetNewsVideoBase;
            break;
                     default:
            break;}
    
    
    [_manager GET:WhitchURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        success(self,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(self,error);
        
        NSLog(@"%@",error);
        
    }];

    
//    [_manager POST:WhitchURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(self,responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failed(self,error);
//
//        NSLog(@"%@",error);
//        
//    }];
    
}

-(void)getNewsDetailedRequestWithNewsType:(NewsType)newsType  newsID:(NSString *)newsID andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;
{
    [self networkState];
    NSString * ImgVideoURL;
    switch (newsType) {
        case newsImgType:
            ImgVideoURL=GetNewsImgDetails_URL;
            break;
        case newsVideoType:
            ImgVideoURL=GetNewsVideoDetails_URL;

        default:
            break;
    }
    NSDictionary * parameters=@{@"newsId":newsID};
   
    
    
    [_manager GET:ImgVideoURL  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
       dataMode * mode= [dataMode  imgNewsDetail:responseObject];
        mode.newstype=newsType;
        success(self,mode);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(self,error);

    }];

}

/**
 *  更新新闻点击数据
 *
 */
-(void)upDataNewsTipCountWithNewsID:(NSString *)newsID andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed
{
    NSDictionary * parameters=@{@"newsId":newsID};
    [_manager GET:DataNewsTipCount_Url  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
            success(self,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(self,error);
        NSLog(@"%@",error);
        
    }];

    
}

@end
