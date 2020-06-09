//
//  DJMarqueeView.h
//  DJMarquee
//
//  Created by huke_dj on 2020/6/8.
//  Copyright © 2020 huke_dj. All rights reserved.
//
//  流云千丈堪醉卧，
//  是谁月下影独酌。
//  浮生谁能一笑过，
//  明灭楼台上灯火。
//              -- Coder_DJ
//

#import <UIKit/UIKit.h>

@class DJMarqueeView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DJMarqueeViewDirection) {
    /// 竖向从下往上翻滚
    DJMarqueeViewDirectionUpward,
    /// 横向从右往左翻滚
    DJMarqueeViewDirectionLeftward
};

#pragma mark - DJMarqueeViewDelegate
@protocol DJMarqueeViewDelegate <NSObject>
/// 数据更新
- (NSUInteger)numberOfDataForMarqueeView:(DJMarqueeView*)marqueeView;

/// 生成每个cell的view
- (void)createItemView:(UIView*)itemView forMarqueeView:(DJMarqueeView*)marqueeView;

/// 更新内容
- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView;

@optional
/// 只有横向滚动的时候才会调用
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView;

/// 只有竖向滚动并且使用动态的高度的时候才会调用(useDynamicHeight必须为YES)
- (CGFloat)itemViewHeightAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView;

/// 只有竖向滚动的时候才会调用，每一次翻滚显示几条数据
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(DJMarqueeView*)marqueeView;

/// 点击相应事件
- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView;
@end


@interface DJMarqueeView : UIView
/// 代理
@property (nonatomic, weak) id<DJMarqueeViewDelegate> delegate;
/// 滚动间隔时间
@property (nonatomic, assign) NSTimeInterval timeIntervalPerScroll;
/// 滚动持续时间(仅在竖向滚动并且useDynamicHeight为NO时可用)
@property (nonatomic, assign) NSTimeInterval timeDurationPerScroll;
/// 是否动态获取高度(仅在竖向滚动中使用，默认NO)
@property (nonatomic, assign) BOOL useDynamicHeight;
/// 滚动速度(在横向滚动或者useDynamicHeight为YES的竖向滚动中使用)
@property (nonatomic, assign) float scrollSpeed;
/// itemview之间的间隙(仅在横向滚动中使用)
@property (nonatomic, assign) float itemSpacing;
/// 当显示完所有数据之后是否停止掉滚动，默认NO
@property (nonatomic, assign) BOOL stopWhenLessData;
/// 边缘裁剪
@property (nonatomic, assign) BOOL clipsToBounds;
/// 是否可以点击
@property (nonatomic, assign, getter=isTouchEnabled) BOOL touchEnabled;
/// 滚动方向
@property (nonatomic, assign) DJMarqueeViewDirection direction;

/// 初始化方法
- (instancetype)initWithDirection:(DJMarqueeViewDirection)direction;
/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame direction:(DJMarqueeViewDirection)direction;
/// 刷新显示数据
- (void)reloadData;
/// 开始
- (void)start;
/// 暂停
- (void)pause;

@end

NS_ASSUME_NONNULL_END
