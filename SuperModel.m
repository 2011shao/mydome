//
//  SuperModel.m
//  归档 runtime
//
//  Created by ios-少帅 on 16/8/25.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "SuperModel.h"
#import <objc/runtime.h>

@implementation SuperModel
//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        const char *ivar_name = ivar_getName(ivars[i]);
        NSString *key = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
        
        //值不为空时在序列化
       // if ([self valueForKey:key]!=nil) {
            [aCoder encodeObject:[self valueForKey:key] forKey:key];

      //  }
    }
}

//反序列化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &ivarCount);
        for (unsigned int i = 0; i < ivarCount; i++) {
            const char *ivar_name = ivar_getName(ivars[i]);
            NSString *key = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
            //当值不为空时进行反序列化,这步多余可去除
           // if ([coder decodeObjectForKey:key]!=nil) {
                [self setValue:[coder decodeObjectForKey:key] forKey:key];

           // }
        }
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
