//
//  superCollectionCell.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/6.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataMode.h"
@interface superCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) dataMode * mode;
@property (weak, nonatomic) IBOutlet UIImageView *stopImgageview;

@end
