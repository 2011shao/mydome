//
//  superCollectionCell.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "superCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "MBTipClass.h"

@interface superCollectionCell ()


@end

@implementation superCollectionCell

-(void)setMode:(dataMode *)mode
{
   // self.stopImgageview.hidden=YES;

    _mode=mode;
    self.titileLabel.text=mode.Title;
    if (mode.newstype==newsVideoType) {
        NSString * aa=@"http://7s1sjv.com2.z0.glb.qiniucdn.com/9F76A25D-9509-DEE9-3D8A-E93F360BB0E5.mp4";
        self.imgView.image=[MBTipClass getImage:aa];
        self.stopImgageview.hidden=NO;
    }else{
        
          [self.imgView sd_setImageWithURL:[NSURL URLWithString:mode.Address] placeholderImage:nil];
    }
   
}
@end
