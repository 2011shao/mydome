//
//  SuperPhotoBrowser.h
//
//  功能描述：用于显示并浏览图片，添加了加载进度条功能
//  Created by wyz on 15/10/18.
//  Copyright (c) 2015年 wyz. All rights reserved.
//

#import "customSuperViewController.h"

@interface SuperPhotoBrowser : customSuperViewController
/**
 *  接收图片标题数组
 */
@property(nonatomic,strong) NSMutableArray  *imageNameArray;
/**
 *  接收图片内容详情数组
 */
@property(nonatomic,strong) NSMutableArray  *imageDetailsArray;
/**
 *  接收图片数组，数组类型可以是url数组，image数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;
/**
 *  接收模型
 */
@property(nonatomic, strong) NSMutableArray *imgMode;

/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  显示名称
 */
@property(nonatomic, strong) UILabel *nameLabel;
/**
 *  显示信息内容
 */
@property(nonatomic, strong)  UITextView *TFview;

/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;

//SuperPhotoBrowser *wyzAlbumVC = [[SuperPhotoBrowser alloc]init];

//wyzAlbumVC.currentIndex =index;//这个参数表示当前图片的index，默认是0

//图片数组，可以是url，也可以是UIImage
//第一种用url
//wyzAlbumVC.imgArr = self.urlArrays;
//wyzAlbumVC.imageNameArray=self.imageNames;//图片名字数组可以为空
//wyzAlbumVC.imageDetailsArray=@[@"k",@"ddd",@"ccc"];
// 进入动画
//   [self.navigationController pushViewController:wyzAlbumVC animated:NO];
//        [self.navigationController.view.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1.0f];
//[self presentViewController:wyzAlbumVC animated:YES completion:^{}];

@end
