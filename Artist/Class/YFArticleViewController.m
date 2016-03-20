//
//  YFArticleViewController.m
//  Artist
//
//  Created by Yingwei Fan on 3/17/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFArticleViewController.h"
#import "YFDetailArticleModel.h"
#import "constant.h"


@interface YFArticleViewController () <UIScrollViewDelegate, UITabBarDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bodyLabel;
@property (nonatomic,strong) UITabBar *tabBar;

@property (nonatomic, strong)YFDetailArticleModel *articleModel;
@end

@implementation YFArticleViewController

- (instancetype)initWithDetailArticleModel:(YFDetailArticleModel *)articleModel {
    if (self = [super init]) {
        _articleModel = articleModel;
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        CGFloat contentH = CGRectGetMaxY(self.topImageView.frame) + 20 + self.titleLabel.bounds.size.height + 20 + self.bodyLabel.bounds.size.height;
        _scrollView.contentSize = CGSizeMake(0, contentH);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, kScreenWidth, kScreenWidth-80)];
        _topImageView.image = [UIImage imageNamed:self.articleModel.topImage];
    }
    return _topImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        CGSize size = [self.articleModel.title boundingRectWithSize:CGSizeMake(kScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = (CGRect){{20, CGRectGetMaxY(self.topImageView.frame) + 20}, size};
        _titleLabel.text = self.articleModel.title;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel == nil) {
        _bodyLabel = [[UILabel alloc] init];
        CGSize size = [self.articleModel.body boundingRectWithSize:CGSizeMake(kScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _bodyLabel.frame = (CGRect){{20,CGRectGetMaxY(self.titleLabel.frame)+20},size};
        _bodyLabel.text = self.articleModel.body;
        _bodyLabel.font = [UIFont systemFontOfSize:14];
        _bodyLabel.numberOfLines = 0;
        
    }
    return _bodyLabel;
}

- (UITabBar *)tabBar {
    if (_tabBar == nil) {
        _tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
        UITabBarItem *backItem = [[UITabBarItem alloc] initWithTitle:@"back" image:[UIImage imageNamed:@"back_icon"] tag:0];
        UITabBarItem *likeItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
        _tabBar.items = [NSArray arrayWithObjects:backItem, likeItem, nil];
        _tabBar.delegate = self;
    }
    return _tabBar;
}

- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.topImageView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.bodyLabel];
    [self.view addSubview:self.tabBar];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

#pragma mark - srollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.scrollView.contentOffset.y;
    if (offsetY<-80) {
        self.scrollView.contentOffset = CGPointMake(0, -80);
    }
}

#pragma mark - tabBarItem delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
