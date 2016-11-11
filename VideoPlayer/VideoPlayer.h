//
//  VideoPlayer.h
//  AVPlayer
//
//  Created by ClaudeLi on 16/4/13.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SuperVideoDelegate <NSObject>
//开启横屏
-(void)startlandscapeLayout;
//开启竖屏
-(void)startPortraitLayout;
-(void)backClick;
@end

/**
 *  手势类型
 */
typedef NS_ENUM(NSInteger, TouchPlayerViewMode) {
    /**
     *  轻触
     */
    TouchPlayerViewModeNone,
    /**
     *  横滑（快进&快退）
     */
    TouchPlayerViewModeHorizontal,
    /**
     *  未知
     */
    TouchPlayerViewModeUnknow,
};
// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
typedef NS_ENUM(NSInteger, PlayerLayerGravity) {
    PlayerLayerGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
    PlayerLayerGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
    PlayerLayerGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

@interface VideoPlayer : UIView
{
    TouchPlayerViewMode _touchMode;
}
/**
 *  AVPlayer播放器
 */
@property (nonatomic, strong) AVPlayer *player;
/**
 *  播放状态，YES为正在播放，NO为暂停
 */
@property (nonatomic, assign) BOOL isPlaying;
/**
 *  是否横屏，默认NO -> 竖屏
 */
@property (nonatomic, assign) BOOL isLandscape;
/**
 *  是否锁定屏幕
 */
@property (nonatomic, assign) BOOL isLockScreen;

@property(nonatomic,assign)id<SuperVideoDelegate>delegate;
/**
 *  视频填充模式
 */
@property (nonatomic,assign)PlayerLayerGravity  videoLayerGravity;


-(instancetype)initWithNIB;



/**
 *  视频 url
 */
- (void)updatePlayerWith:(NSURL *)url;

/**
 *  移除通知&KVO
 */
- (void)removeObserverAndNotification;

/**
 *  横屏Layout
 */
- (void)setlandscapeLayout;

/**
 *  竖屏Layout
 */
- (void)setPortraitLayout;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;

@end
