//
//  FirstVC.m
//  TRN_3
//
//  Created by LiQunFei on 2019/7/11.
//  Copyright © 2019 IlreldI. All rights reserved.
//

#import "FirstVC.h"
#import "Macros.h"
#import <iAd/iAd.h>
#import <Masonry.h>

@interface FirstVC () <ADBannerViewDelegate>

//@property (nonatomic, strong) ADBannerView *adView;
@property (nonatomic, strong) UILabel *firstLabel;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.title isEqualToString:iAd]) {
        [self iAdTest];
    }
}

#pragma mark - iAd框架

- (void)iAdTest {
    [self.view addSubview:self.firstLabel];
    self.firstLabel.text = @"ADBannerView 在iOS 10 中已经废弃";
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
    }];
}

#pragma mark - Set
- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [UILabel new];
    }
    return _firstLabel;
}

@end
