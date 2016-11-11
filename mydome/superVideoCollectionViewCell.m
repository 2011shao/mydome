//
//  superVideoCollectionViewCell.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/8.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superVideoCollectionViewCell.h"

@implementation superVideoCollectionViewCell
-(void)setMode:(dataMode *)mode
{
    _mode=mode;
    NSString * aa=@"http://7s1sjv.com2.z0.glb.qiniucdn.com/9F76A25D-9509-DEE9-3D8A-E93F360BB0E5.mp4";
    self.titilabel.text=mode.Title;
    [self.myplayview updatePlayerWith:[NSURL URLWithString:aa]];;
    
    
}
@end
