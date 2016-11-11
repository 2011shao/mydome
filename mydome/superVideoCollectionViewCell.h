//
//  superVideoCollectionViewCell.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/8.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayer.h"
#import "dataMode.h"
@interface superVideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titilabel;
@property (weak, nonatomic) IBOutlet VideoPlayer *myplayview;
@property (nonatomic,strong) dataMode* mode;

@end
