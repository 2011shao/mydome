//
//  SuperCell.h
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/7.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataMode.h"
@interface baseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titlLabel;
@property (weak, nonatomic) IBOutlet UILabel *simleLabel;

@property (nonatomic,strong) dataMode * mode;

@end
