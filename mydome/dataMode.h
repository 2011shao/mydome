//
//  dataMode.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "SuperModel.h"
#import "HttpRequestManager.h"
@interface dataMode : SuperModel
/**
 *新闻Id
 */
@property (nonatomic,copy)NSString * ID;
/**
 * 新闻标题
 */
@property (nonatomic,copy)NSString * Title;
/**
 * 新闻摘要
 */
@property (nonatomic,copy)NSString * Summary;
/**
 * 图片全路径
 */
@property (nonatomic,copy)NSString * Address;
/**
 * 发布时间
 */
@property (nonatomic,copy)NSString * RealseTime;
/**
 * 点击次数
 */
@property (nonatomic,copy)NSString * ClickCount;
/**
 * 新闻跳转的连接（显示于WebView中的连接
 */
@property (nonatomic,copy)NSString * AHref;


//**图片详情界面

/**
 * 图片新闻详情页的所有图片数组
 */
@property (nonatomic,strong) NSMutableArray * imgUrlArr;
/**
 * 图片新闻详情页的所有标题数组
 */
@property (nonatomic,strong) NSMutableArray * titleUrlArr;

@property(nonatomic,assign) NewsType newstype;


//**视频详情界面
@property (nonatomic,copy)NSString * Contnet;



/**
 * 新闻列表数据转为模型
 */
+(NSMutableArray*)newsListDataTomode:(id)object newsType:(NewsType)newstype;
+(dataMode*)imgNewsDetail:(id)object;

/**
 * 新闻图片视频列表数据转为模型
 */
+(NSMutableArray*)newsListIMGVIDEODataTomode:(id)object;
@end
