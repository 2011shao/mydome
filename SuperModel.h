//
//  SuperModel.h
//  归档 runtime
//在 iOS 中归档数据时,如果归档的是我们自定义的数据模型类,则需要我们手动进行序列化和反序列化才能进行归档.
//在此,我们使用 runtime 进行序列化和反序列化,思路大致为:新建一个数据模型的基类,基类.h文件中不需要写任何属性, 然后在基类的.m文件中利用 runtime 进行序列化和反序列化,至此基类已经完成.此后如果我们工程中哪一个数据模型类需要进行归档存储,就可以直接继承前面的基类即可.也就是说继承基类的其它数据模型类无需再进行序列化和反序列化就可以进行归档数据.
//  Created by ios-少帅 on 16/8/25.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperModel : NSObject<NSCoding>

@end
