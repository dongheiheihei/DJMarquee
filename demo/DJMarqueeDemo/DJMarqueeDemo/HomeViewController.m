//
//  HomeViewController.m
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

#import "HomeViewController.h"
#import <DJMarquee/DJMarqueeView.h>

/**
 屏幕宽度

 @param currentMode 无
 @return float
 */
#define DJScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeViewController ()<DJMarqueeViewDelegate>

///横向跑马灯的view
@property (weak, nonatomic) IBOutlet UIView *crosswiseMarqueeView;
///竖向跑马灯的view
@property (weak, nonatomic) IBOutlet UIView *verticalMarqueeView;

@property (nonatomic, strong) DJMarqueeView *crosswiseMarquee;
@property (nonatomic, strong) DJMarqueeView *verticalMarquee;
@property (nonatomic, strong) NSArray *crossWiseData;
@property (nonatomic, strong) NSArray *verticalData;

@end

@implementation HomeViewController

- (NSArray *)crossWiseData {
    if (!_crossWiseData) {
        _crossWiseData = [NSArray array];
    }
    return _crossWiseData;
}

- (NSArray *)verticalData {
    if (!_verticalData) {
        _verticalData = [NSArray array];
    }
    return _verticalData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *stringArr = @[@"思聪公司破产拍品估值仅8707元，网友：不如一起摆地摊？",
                           @"买下五菱神级“地摊车”，真能上路卖货吗？",
                           @"微信推新功能！马化腾朋友圈四处挑战，10分钟后被打败" ,
                           @"因22.7万呷哺呷哺被列为被执行人 回应：完全还得起另有原因",
                           @"26岁奶茶妹和强东久违同框，还吃烛光晚餐，网友：哪有婚变",
                           @"外地少年网购校服，混进青岛一高中！说起原因，小编一脸黑线",
                           @"这是一段超长的文字特别长都会好的好的好的哈导航页思考扫我哦爱哦带动爱戴窝气四季豆发放阿萨德科技大家对方就看看大家发快递收款方开始交罚款"];
    NSMutableArray *crosswiseArr = [NSMutableArray array];
    for (NSString *contentString in stringArr) {
        NSDictionary *dict = @{@"color":[self RandomColor], @"label":contentString};
        [crosswiseArr addObject:dict];
    }
    self.crossWiseData = crosswiseArr.mutableCopy;
    [self creatCrosswiseMarquee];
    
    //为了区分两组数据，重复执行一遍，随机色不一样
    NSMutableArray *verticalArr = [NSMutableArray array];
    for (NSString *contentString in stringArr) {
        NSDictionary *dict = @{@"color":[self RandomColor], @"label":contentString};
        [verticalArr addObject:dict];
    }
    self.verticalData = verticalArr.mutableCopy;
    [self creatVerticalMarquee];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建横向的跑马灯
- (void)creatCrosswiseMarquee {
    self.crosswiseMarquee = [[DJMarqueeView alloc] initWithFrame:CGRectMake(0, 0, DJScreenWidth-2*20.0f, 40.0f) direction:DJMarqueeViewDirectionLeftward];
    self.crosswiseMarquee.delegate = self;
    self.crosswiseMarquee.timeIntervalPerScroll = 0.0f;
    self.crosswiseMarquee.scrollSpeed = 50.0f;
    self.crosswiseMarquee.itemSpacing = 20.0f;
    self.crosswiseMarquee.touchEnabled = YES;
    [self.crosswiseMarqueeView addSubview:self.crosswiseMarquee];
    [self.crosswiseMarquee reloadData];
}

#pragma mark 创建竖向的跑马灯
- (void)creatVerticalMarquee {
    self.verticalMarquee = [[DJMarqueeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, DJScreenWidth-2*15.0f, 52.0f) direction:DJMarqueeViewDirectionUpward];
    self.verticalMarquee.delegate = self;
    self.verticalMarquee.timeIntervalPerScroll = 2.0f;
    self.verticalMarquee.timeDurationPerScroll = 1.0f;
    self.verticalMarquee.touchEnabled = YES;
    [self.verticalMarqueeView addSubview:self.verticalMarquee];
    [self.verticalMarquee reloadData];
}

- (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() %255;
    NSInteger aGreenValue = arc4random() %255;
    NSInteger aBlueValue = arc4random() %255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

#pragma mark - DJMarqueeViewDelegate
#pragma mark 横向和竖向都会执行
- (NSUInteger)numberOfDataForMarqueeView:(DJMarqueeView*)marqueeView {
    if (marqueeView == self.crosswiseMarquee) {
        return self.crossWiseData.count;
    }
    return self.verticalData.count;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(DJMarqueeView*)marqueeView {
    if (marqueeView == self.crosswiseMarquee) {
        itemView.backgroundColor = [UIColor clearColor];
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(itemView.bounds)-10)/2.00, 10, 10)];
        pointView.layer.masksToBounds = YES;
        pointView.layer.cornerRadius = 5;
        pointView.tag = 1000;
        [itemView addSubview:pointView];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(itemView.bounds)-10, CGRectGetHeight(itemView.frame))];
        content.font = [UIFont systemFontOfSize:14];
        content.textColor = [UIColor blackColor];
        content.tag = 1001;
        [itemView addSubview:content];
    }
    
    if (marqueeView == self.verticalMarquee) {
        itemView.backgroundColor = [UIColor clearColor];
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(itemView.bounds)-40)/2.00, 40, 40)];
        pointView.layer.masksToBounds = YES;
        pointView.layer.cornerRadius = 20;
        pointView.tag = 1002;
        [itemView addSubview:pointView];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, CGRectGetWidth(itemView.bounds)-70, CGRectGetHeight(itemView.frame))];
        content.font = [UIFont systemFontOfSize:14];
        content.textColor = [UIColor blueColor];
        content.numberOfLines = 0;
        content.tag = 1003;
        [itemView addSubview:content];
    }
}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView {
    if (marqueeView == self.crosswiseMarquee) {
        UIView *point = [itemView viewWithTag:1000];
        UILabel *content = [itemView viewWithTag:1001];
        NSDictionary *contentDict = self.crossWiseData[index];
        point.backgroundColor = contentDict[@"color"];
        content.text = contentDict[@"label"];
        content.textColor = contentDict[@"color"];
    }
    
    if (marqueeView == self.verticalMarquee) {
        UIView *point = [itemView viewWithTag:1002];
        UILabel *content = [itemView viewWithTag:1003];
        NSDictionary *contentDict = self.verticalData[index];
        point.backgroundColor = contentDict[@"color"];
        content.text = contentDict[@"label"];
        content.textColor = contentDict[@"color"];
    }
}

- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView {
    if (marqueeView == self.crosswiseMarquee) {
        NSDictionary *contentDict = self.crossWiseData[index];
        self.view.backgroundColor = contentDict[@"color"];
    }
    
    if (marqueeView == self.verticalMarquee) {
        NSDictionary *contentDict = self.verticalData[index];
        self.view.backgroundColor = contentDict[@"color"];
    }
}

#pragma mark 横向滚动时执行
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView {
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:14];
    NSDictionary *contentDict = self.crossWiseData[index];
    content.text = contentDict[@"label"];
    return 10.f + content.intrinsicContentSize.width;
}

#pragma mark 竖向滚动时执行
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(DJMarqueeView*)marqueeView {
    return 1;
}

- (CGFloat)itemViewHeightAtIndex:(NSUInteger)index forMarqueeView:(DJMarqueeView*)marqueeView {
    return 52;
}

@end
