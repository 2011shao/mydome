//
//  dataMode.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "dataMode.h"

@implementation dataMode
+(NSMutableArray*)newsListDataTomode:(id)object newsType:(NewsType)newstype
{
    NSMutableArray * modeArr=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * dic in object) {
        dataMode * mode=[[dataMode alloc]init];
        mode.newstype=newstype;
        for (NSString * key in dic.allKeys) {
            [mode setValue:dic[key] forKeyPath:key];
        }
        [modeArr addObject:mode];
    }
    
    
    return modeArr;
}
+(dataMode*)imgNewsDetail:(id)object
{
    dataMode * mode=[[dataMode alloc]init];

    NSDictionary * dic=object;
    for (NSString * key in dic.allKeys) {
    
        [mode setValue:dic[key] forKey:key];
        
    }
    
    return mode;
    
}

+(NSMutableArray*)newsListIMGVIDEODataTomode:(id)object
{
    return nil;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"PicList"]) {//图片新闻才有的字段
        self.imgUrlArr=[[NSMutableArray alloc]initWithCapacity:0];
        self.titleUrlArr=[[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary * dic in value) {
            [self.imgUrlArr addObject:dic[@"Path"]];
            [self.titleUrlArr addObject:dic[@"Remark"]];
        }
        
    }
    
    
    
}
@end
