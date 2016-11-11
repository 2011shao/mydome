//
//  HttpRequestManager.h
//  XYB-DOME
//
//  Created by ios-少帅 on 16/4/28.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define GETUSERID @"d4b8e4e5627f4f89bf73ec0a995b3b76"




typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

typedef NS_ENUM(NSInteger,NewsType){
    
    newsListType=0,//文字
    newsImgType=1,//图片
    newsVideoType=2,//视频
    
};

typedef NS_ENUM(NSInteger,NewRequestURL){
    /**
     *  检查新闻
     */
    oneType = 1,
    /**
     *  图说检查
     */
     twoType = 2,
    /**
     *  视频新闻
     */
    threeType = 3,

    /**
     *  廉政建设
     */
     fourType = 4,
    /**
     *  案件聚焦
     */
    fiveType = 5,
    /**
     *  预防天地
     */
    sixType=6,
    /**
     *  检务公开
     */
    sevenType = 7,
    /**
     *  检查文学
     */
    eightType = 8,
    

};



@interface HttpRequestManager : NSObject
#pragma mark -
typedef void (^httpSessionSuccess)(HttpRequestManager  *manager,id  object);
typedef void (^httpSessionFailed)(HttpRequestManager  *manager,NSError  *error);
@property (nonatomic,copy)NSString * aa;



//typedef void (^httpSessionSuccess)(HttpRequestManager  *manager,id  object);

+(instancetype) shareInstance;
-(void)getMainScrollviewDataAndRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;


/**
 *  获取新闻列表数据
 *
 */
-(void)getNewsListRequestWithNewsType:(NewsType)newsType dataType:(NewRequestURL)datatype  loadType:(NSString*)loadtype parameters:(NSMutableDictionary*)parameters andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;

/**
 *  获取新闻详情数据
 *
 */
-(void)getNewsDetailedRequestWithNewsType:(NewsType)newsType  newsID:(NSString *)newsID andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;
/**
 *  更新新闻点击数据
 *
 */
-(void)upDataNewsTipCountWithNewsID:(NSString *)newsID andRequesetSuccess:(httpSessionSuccess)success andRequestFailed:(httpSessionFailed)failed;
@end
