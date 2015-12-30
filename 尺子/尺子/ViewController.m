//
//  ViewController.m
//  尺子
//
//  Created by xuchuangnan on 15/12/14.
//  Copyright © 2015年 xuchuangnan. All rights reserved.
//
#import "ViewController.h"
#import "XCNIndicatorView.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define scrollViewH 80 //scrollView的高度

#define scrollViewW screenW * 5 //scrollView的宽度

#define margin 10 // 刻度间距

@interface ViewController ()<UIScrollViewDelegate>;

@property (weak, nonatomic) UIView *contentView;
@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, weak) XCNIndicatorView *indict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.contentSize = CGSizeMake(scrollViewW, scrollViewH);
    scrollView.frame = CGRectMake(0, screenH*0.6, screenW, scrollViewH);
    //    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    // 容器视图
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(0, 0,screenW*5, scrollViewH);
    contentView.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:contentView];
    self.contentView = contentView;

    // 短复制层
    CAReplicatorLayer *shortRepLayer = [CAReplicatorLayer layer];
    shortRepLayer.frame = _contentView.bounds;
    
    NSInteger shortCount = 200;
    // 设置总分数
    shortRepLayer.instanceCount = shortCount;
    shortRepLayer.instanceTransform = CATransform3DMakeTranslation(margin, 0, 0);
    [_contentView.layer addSublayer:shortRepLayer];
    // 添加短的,到复制层
    CALayer *shortItem = [CALayer layer];
    shortItem.frame = CGRectMake(0, 0, 1, 15);
    shortItem.backgroundColor = [UIColor whiteColor].CGColor;
    [shortRepLayer addSublayer:shortItem];
    
    
    // 长复制制层
    CAReplicatorLayer *longRepLayer = [CAReplicatorLayer layer];
    
    longRepLayer.frame = _contentView.bounds;
    
    NSInteger longcount = shortCount/10;
    
    // 设置总份数
    longRepLayer.instanceCount = longcount;
    
    // 每条占用的间距
    CGFloat longmargin = margin*10;
    
    longRepLayer.instanceTransform = CATransform3DMakeTranslation(longmargin, 0, 0);
    [_contentView.layer addSublayer:longRepLayer];
    
    // 添加长条,到复制层
    CALayer *longItem = [CALayer layer];
    longItem.frame = CGRectMake(0, 0, 3, 30);
    longItem.backgroundColor = [UIColor whiteColor].CGColor;
    [longRepLayer addSublayer:longItem];
    
    
    // 底部数字
    for (int i = 0; i<longcount; i++) {
        UILabel *vauleLabel = [[UILabel alloc]init];
        vauleLabel.text = [NSString stringWithFormat:@"%d",i*10];
        // label 中心点
        vauleLabel.center = CGPointMake(i*margin*10-8, scrollViewH*0.5);
        [vauleLabel sizeToFit];
        vauleLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:vauleLabel];
    }
    
    // 上面箭头
    XCNIndicatorView *indict = [[XCNIndicatorView alloc]init];
    indict.backgroundColor = [UIColor clearColor];
    indict.frame = CGRectMake(0, self.scrollView.frame.origin.y-20, self.view.bounds.size.width, 30);
    [self.view addSubview:indict];
    self.indict = indict;
    
    // 初始箭头上数字
    CGFloat offsetX = [UIScreen mainScreen].bounds.size.width * 0.5;
    [self.indict refreshWithVaule:offsetX/margin];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = [UIScreen mainScreen].bounds.size.width * 0.5 + scrollView.contentOffset.x;
    [self.indict refreshWithVaule:offsetX/margin];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    CGFloat offsetX = ([UIScreen mainScreen].bounds.size.width * 0.5 + scrollView.contentOffset.x);
    [self.indict refreshWithVaule:offsetX/margin];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetX = [UIScreen mainScreen].bounds.size.width * 0.5 + scrollView.contentOffset.x;
    [self.indict refreshWithVaule:offsetX/margin];
}
@end
