//
//  MBTipClass.h
//  YHSPJ_ios
//
//  Created by LYKJ on 15/7/24.
//  Copyright (c) 2015年 LYKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MBTipClass : NSObject

#pragma mark  - mark  - 数据格式化
+  (NSString *)setDataFormat:(NSString *)data;
#pragma -   mark 获取当前版本号
+(NSString*)getLocalVersion;
+(void)deleteUseridFile;
+(BOOL)isDelegateAgoFile;//是否删除之前的文件//为 yes 不能自动登录

#pragma mark  - 计算单个总价格
+ (NSDecimalNumber *)totalMoney:(int)num andPrice:(NSString*)price;

#pragma mark  - 计算购物车总价格
+ (NSDecimalNumber *)totalAddMoney:(NSDecimalNumber *)Product1 andProduct2:(NSDecimalNumber *)Product2;

#pragma mark  - 数字转化汉字
+  (NSString *)setChinaFormat:(NSString *)data;

#pragma mark  - 设置提示语;
+  (void)setTipTitle:(NSString *)title  andView:(UIView *)view;

#pragma mark  - 是否联网提示框;
+ (void)setAlertView:(UIView *)view;

//#pragma mark - - loading
//+ (void)showloading;

#pragma mark  - iOS MD5加密
+ (NSString *)md5HexDigest:(NSString*)input;

#pragma mark  - 字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

#pragma mark  - 字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

#pragma mark  - 获取今天的日期：年月日
+(NSDictionary *)getTodayDate;

#pragma mark  - 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma mark  - 正则匹配邮箱
+ (BOOL)validateEmail:(NSString *)email;

#pragma mark  - 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma mark  - 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma mark  - 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma mark  - 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma mark  - 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

#pragma mark  - 匹配银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo;

#pragma mark --根据时间返回时间段
+ (NSString *) compareCurrentTime:(NSString *)str;
#pragma mark - - 看看孩子有多大了
+ (NSString *)getBabyHowOld:(NSString *)str;
#pragma mark - - 看看孩子距离生日还有几天
+ (NSString *)getBabyBirthdayDay:(NSString *)str;
#pragma 判断两个时间大小
+(BOOL)nowTime:(NSString*)newTime oldTime:(NSString*)oldTime;
#pragma mark - - 判断日期是不是今天--
+(BOOL)isTodayWithdate:(NSString*)dateStr;

#pragma mark - - 字符串小写
+(NSString *)toLower:(NSString *)str;

#pragma mark - - 字符串大写
+(NSString *)toUpper:(NSString *)str;

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile;
//验证密码
+(BOOL)validatePassword:(NSString *)password;
/**
 *  获取字符串(或汉字)首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *)string;
/**
 *  将字符串数组按照元素首字母顺序进行排序分组
 */
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)StrArray;
/**
 *  截取view生成一张图片
 */
+ (UIImage *)shotWithView:(UIView *)view;
/**
 *  压缩图片到指定文件大小
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
/**
 *  压缩图片到指定尺寸大小
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
/**
 *  将字典对象转换为 JSON 字符串
 *
 */
+ (NSString *)dicTojson:(NSDictionary *)dictionary;
+(id)switchDicToServerWithDic:(id)dd;

/**
 *  将数组对象转换为 JSON 字符串
 *
 */
+ (NSString*)arrayTojson:(NSArray *)array;
+(id)switchArrToServerWithDic:(NSMutableArray*)arr;

+ (BOOL)isContainsEmoji:(NSString *)string;
/**
 *  uicode 转中文
 *
 */

/**
 *  字符串去空格
 */
+(NSString*)strDeleteEmptyWith:(NSString*)str;

+(UIImage *)getImage:(NSString *)videoURL;

@end
