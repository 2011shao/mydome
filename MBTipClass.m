//
//  MBTipClass.m
//  YHSPJ_ios
//
//  Created by LYKJ on 15/7/24.
//  Copyright (c) 2015年 LYKJ. All rights reserved.
//

#import "MBTipClass.h"
//#import "XYBHeader.h"
#import <CommonCrypto/CommonDigest.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "MBProgressHUD.h"
#define US  [NSUserDefaults standardUserDefaults]
#define FM     [NSFileManager defaultManager]

@implementation MBTipClass

#pragma 数据格式化
+  (NSString *)setDataFormat:(NSString *)data{
    if (data == nil||[data isEqual:[NSNull null]]||[data isEqualToString:@"(null)"]) {
        return @"0";
    }
    
    
//    NSRange range;
//    NSString *string;
//    range = [data rangeOfString:@"-"];
//    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//    if (range.location != NSNotFound) {
//        NSDecimalNumber *formatter = [[NSDecimalNumber alloc] initWithString:data];
//        formatter = [formatter decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
//        NSString *maxPr = [data substringFromIndex:range.length+range.location];
//        
//        string = [NSString stringWithFormat:@"%@~%@",formatter,[self setDataFormat:maxPr]];
//    }else{
//        NSDecimalNumber *formatter = [[NSDecimalNumber alloc] initWithString:data];
//        formatter = [formatter decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
//        string = [NSString stringWithFormat:@"%@",formatter];
//    }
    return data;
}
+(NSString *)getLocalVersion{
    
    NSDictionary * appInfo = [[NSBundle mainBundle] infoDictionary];
   //<1> CFBundleShortVersionString  <2>CFBundleVersion
    NSString * currentVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}
//+(void)deleteUseridFile
//{
//       BOOL isDelete=[US boolForKey:@"deleteUserFile"];
//
//    NSInteger  agoV=[[US objectForKey:@"BB"] integerValue];
//    NSInteger  curV=[[[MBTipClass getLocalVersion] stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
//    
//    if (isDelete && curV!=agoV) {
//      [FM removeItemAtPath:getFilePath(GETUSERID) error:nil];
//
//    }
//    [US setObject:[NSString stringWithFormat:@"%ld",(long)curV] forKey:@"BB"];
//    [US synchronize];
//}
+(BOOL)isDelegateAgoFile
{
    //设置需不需要删除全部数据
    [US setBool:YES forKey:@"deleteUserFile"];
    [US synchronize];
    BOOL isDelete=[US boolForKey:@"deleteUserFile"];


     NSInteger  curV=[[[MBTipClass getLocalVersion] stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
   
    NSInteger  agoV=[[US objectForKey:@"BB"] integerValue];
    
    if (curV!=agoV && isDelete) {
        return YES;
    }else{
        return NO;

    }

}
+ (NSDecimalNumber *)totalMoney:(int)num andPrice:(NSString*)price{
    if (price == nil||[price isEqual:[NSNull null]]||[price isEqualToString:@"(null)"]) {
        return 0;
    }else{
        NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",num]];
        NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:price];
        NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
        return product;
    }

}
#pragma 计算购物车总价格
+ (NSDecimalNumber *)totalAddMoney:(NSDecimalNumber *)Product1
                       andProduct2:(NSDecimalNumber *)Product2{
    NSDecimalNumber *product = [Product1 decimalNumberByAdding:Product2];
    return product;
}
//数字该汉字
+  (NSString *)setChinaFormat:(NSString *)data{
    NSString *aa= [[NSLocale currentLocale]localeIdentifier];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterSpellOutStyle;
    
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:aa];
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:data.doubleValue]];
    return string;
    
}

+  (void)setTipTitle:(NSString *)title  andView:(UIView *)view{

    
    MBProgressHUD  *hud = [MBProgressHUD   showHUDAddedTo:view animated:YES];
   // hud.backgroundColor =GreenColor;
   // hud.color =RGBA(249, 249, 249, 1);
   // hud.color = HightligntColor;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = title;
    hud.detailsLabel.textColor = [UIColor  whiteColor];
    hud.detailsLabel.font = [UIFont  systemFontOfSize:15];
    hud.yOffset = 10.f;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.2];

}


+ (void)setAlertView:(UIView *)view{

    MBProgressHUD  *hud = [MBProgressHUD   showHUDAddedTo:view animated:YES];
    //hud.backgroundColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor whiteColor];
    hud.label.text = @"正在加载";
    hud.label.textColor = [UIColor  blackColor];
}

//iOS MD5加密;
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return     [MBTipClass toLower:result];
}

// 是否联网;
//根据文字的字号的大小得到宽度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    NSString *hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    NSString *minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    NSString *second = [NSString stringWithFormat:@"%02ld", (long)[components second]];
    
    
    
    
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    [todayDic setObject:hour forKey:@"hour"];
    [todayDic setObject:minute forKey:@"minute"];
    [todayDic setObject:second forKey:@"second"];
    
    return todayDic;
    
}
#pragma  mark - 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    telNumber = [telNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *pattern = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    

    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    NSPredicate *pred = nil;
    BOOL isMatch;
    
    //isMatch = [pred evaluateWithObject:telNumber];

    NSString *paymethod = NSLocalizedString(@"Payment method", @"支付方式");
    if (![paymethod isEqualToString:@"Paypal"]) {
        pattern = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
        
        pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        isMatch = [pred evaluateWithObject:telNumber];
        
       
    }else{
        pattern = @"^[0-9]*$";
        
        pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        isMatch = [pred evaluateWithObject:telNumber];
        
       
    }
    return isMatch;
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}
#pragma 匹配银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo{
    cardNo = [cardNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *paymethod = NSLocalizedString(@"Payment method", @"支付方式");
    if (![paymethod isEqualToString:@"Paypal"]) {

    int sum = 0;
    NSInteger len = [cardNo length];
    int i = 0;
    
    while (i < len) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(len - 1 - i, 1)];
        int tmpVal = [tmpString intValue];
        if (i % 2 != 0) {
            tmpVal *= 2;
            if(tmpVal>=10) {
                tmpVal -= 9;
            }
        }
        sum += tmpVal;
        i++;
    }
    
    if((sum % 10) == 0)
        return YES;
    else
        return NO;
    }else{
        return [self checkTelNumber:cardNo]||[self validateEmail:cardNo];
    }
    return YES;
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

+ (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;

    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+(BOOL)nowTime:(NSString*)newTime oldTime:(NSString*)oldTime
{
   
        
        //把字符串转为NSdate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *timeDate = [dateFormatter dateFromString:oldTime];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *newTimeDate = [dateFormatter dateFromString:newTime];
    
        //得到与当前时间差
        NSTimeInterval  timeInterval = [timeDate timeIntervalSinceDate:newTimeDate];
        timeInterval = -timeInterval;
    //NSLog(@"%f",timeInterval);

        //标准时间和北京时间差8个小时
        //timeInterval = timeInterval - 8*60*60;
        
        float  temp = 0;
    if ((temp = timeInterval/(60*60)) <24) {
        //大于0说明 有新的作业,这个时候可以发送通知显示角标了,该功能咱没要求
      //  NSLog(@"%f",temp);
        
        return YES;
    }else{
        return NO;
    }

}
+(BOOL)isTodayWithdate:(NSString*)dateStr
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:currentDate];
    
    NSDate *today = [calendar dateFromComponents:components];
    
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:dateStr];

    components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:timeDate];
    
    NSDate *otherDate = [calendar dateFromComponents:components];
    if ([today isEqualToDate:otherDate]) {
        return YES;

    }
    return NO;
}

+ (NSString *)getBabyHowOld:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;
    
    long temp = timeInterval/(60*60);
  
   
     NSString *   result1 = [NSString stringWithFormat:@"%ld天",(temp/24)%30];
    
    
  
     NSString *   result2 = [NSString stringWithFormat:@"%ld个月",(temp/(24*30))%12];
    
   
        
      NSString *  result3 = [NSString stringWithFormat:@"%ld岁",temp/(24*30*12)];

    return  [NSString stringWithFormat:@"%@%@%@",result3,result2,result1];
}
+ (NSString *)getBabyBirthdayDay:(NSString *)str
{
    
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    NSDate * dete=[NSDate date];
    NSString * nowDate=[dateFormatter stringFromDate:dete];
    
    ;
    
    NSString * srdate=[NSString stringWithFormat:@"%@%@",[nowDate substringToIndex:4],[str substringFromIndex:4]];
    
    NSDate *timeDate = [dateFormatter dateFromString:srdate];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;
    
    long temp = timeInterval/(60*60);
    
    
    NSString *   result1 = [NSString stringWithFormat:@"%ld天",(temp/24)%30];
    
    
    
    NSString *   result2 = [NSString stringWithFormat:@"%ld个月",(temp/(24*30))%12];
    
    
    
   // NSString *  result3 = [NSString stringWithFormat:@"%ld岁",temp/(24*30*12)];
    
    return  [NSString stringWithFormat:@"距离孩子生日还有%@%@",result2,result1];
}

//字符串转小写
+(NSString *)toLower:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
//字符串转大写
+(NSString *)toUpper:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile

{
    if (mobile.length == 0) {
        NSString *message = @"手机号码不能为空！";
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phoneTest evaluateWithObject:mobile]) {
        NSString *message = @"手机号码格式不正确！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}



//验证密码
+(BOOL)validatePassword:(NSString *)password
{
    if (password.length == 0) {
        NSString *message = @"密码不能为空！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    if (password.length < 6) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"密码不足六位！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
   
    
    return YES;
}
//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}
//将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)StrArray
{
    if (StrArray.count == 0) {
        return nil;
    }
    for (id obj in StrArray) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    //创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    //按字母顺序进行分组
    NSInteger lastIndex = -1;
    for (int i = 0; i < StrArray.count; i++) {
        NSInteger index = [indexedCollation sectionForObject:StrArray[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:StrArray[i]];
        lastIndex = index;
    }
    //去掉空数组
    for (int i = 0; i < objects.count; i++) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    //获取索引字母
    for (NSMutableArray *obj in objects) {
        NSString *str = obj[0];
        NSString *key = [self firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    return dic;
}
/**
 *  截取view生成一张图片
 */
+ (UIImage *)shotWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  压缩图片到指定尺寸大小
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size
{
    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return resultImage;
}
/**
 *  压缩图片到指定文件大小
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
/**
 *  将字典对象转换为 JSON 字符串
 *
 */
+ (NSString *)dicTojson:(NSDictionary *)dictionary{
    if ([NSJSONSerialization isValidJSONObject:dictionary ]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    return nil;
}
+ (NSString*)arrayTojson:(NSArray *)array
{
    if ([NSJSONSerialization isValidJSONObject:array]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    return nil;
}
+(id)switchDicToServerWithDic:(id)dd
{
    
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:dd];
    
    for (NSString * key in [dic allKeys]) {
        
        if ([dic[key] isKindOfClass:[NSArray class]]) {
            
            NSMutableString * str=[[NSMutableString alloc]initWithCapacity:0];
            
            
            for (NSString * aa in dic[key]) {
                
                [str appendFormat:@"%@,",aa];
            }
            
            [dic setObject:str forKey:key];
            
            
        }
    }
    
    return dic;
    
    
}
/**
 * 数组转化为 可悲服务器接收的格式
 */

+(id)switchArrToServerWithDic:(NSMutableArray*)arr
{
    NSData * daya=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str=[[NSString alloc]initWithData:daya encoding:NSUTF8StringEncoding];
    
    return str;
}


+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
+(NSString*)strDeleteEmptyWith:(NSString*)str
{
    NSString * zjkg=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return  zjkg;
    //return  [zjkg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

}

+(UIImage *)getImage:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 6.0);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
    
}


@end
