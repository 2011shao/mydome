//
//  SuperCell.m
//  MYDemo
//
//  Created by ios-少帅 on 2016/11/7.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "baseCell.h"
#import "UIImageView+WebCache.h"
@implementation baseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setMode:(dataMode *)mode
{
    _mode=mode;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mode.Address] placeholderImage:nil];;
    self.titlLabel.text=mode.Title;
    self.simleLabel.text=mode.Summary;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
