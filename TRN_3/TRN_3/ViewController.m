//
//  ViewController.m
//  TRN_3
//
//  Created by LiQunFei on 2019/7/11.
//  Copyright © 2019 IlreldI. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "FirstVC.h"
#import "Macros.h"

static NSString *const cellId = @"cellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTV;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.dataArray addObject:AddressBookUI];
    [self.dataArray addObject:EventKitUI];
    [self.dataArray addObject:iAd];
    [self.dataArray addObject:InputFormat];
    [self.dataArray addObject:BOOLOutOfBounds];
    [self.dataArray addObject:TypeMandatoryConversion];
    [self.dataArray addObject:CommaOperator];
    [self.dataArray addObject:MacrosAbout];
    
    self.myTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTV.delegate = self;
    self.myTV.dataSource = self;
    [self.view addSubview:self.myTV];
    
    [self.myTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.myTV dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArray[indexPath.row];
    if ([self.dataArray containsObject:title]) {
        FirstVC *firstVC = [FirstVC new];
        firstVC.titleStr = title;
        [self.navigationController pushViewController:firstVC animated:YES];
    }
}

@end
