//
//  FirstVC.m
//  TRN_3
//
//  Created by LiQunFei on 2019/7/11.
//  Copyright © 2019 IlreldI. All rights reserved.
//

#import "FirstVC.h"
#import "Macros.h"

/*#import <iAd/iAd.h>
#import <AddressBookUI/ABPeoplePickerNavigationController.h>*/
#import <ContactsUI/ContactsUI.h>

#import <Masonry.h>
#import <SVProgressHUD.h>

@interface FirstVC ()<CNContactPickerDelegate>

//@property (nonatomic, strong) ADBannerView *adView;
@property (nonatomic, strong) UILabel *firstLabel;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.titleStr isEqualToString:iAd]) {
        [self iAdTest];
    }
    else if ([self.titleStr isEqualToString:AddressBookUI]) {
        [self addressBookUITest];
    }
}

#pragma mark - AddressBookUI

- (void)addressBookUITest {
    UIButton *btn1 = [self createMyButton];
    [btn1 setTitle:@"ABPeoplePickerNavigationController" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(test_ABPeoplePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
    }];
    
    UIButton *btn2 = [self createMyButton];
    [btn2 setTitle:@"CNContactPickerViewController" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(test_CNContactPickerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1);
        make.top.equalTo(btn1.mas_bottom).offset(20);
    }];
}

- (void)test_CNContactPickerAction {
    if (k_SystemVersionValue >= 9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
                }
                else
                {
                    [self callAddressBook];
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            [self callAddressBook];
        }
        else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
    else {
        [self showMessageAlert:@"iOS 9以下系统请使用ABPeoplePickerNavigationController"];
    }
}

- (void)callAddressBook {
    CNContactPickerViewController *contactPicker = [CNContactPickerViewController new];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    [self presentViewController: contactPicker animated:YES completion:nil];
}

- (void)test_ABPeoplePicker {
    NSString *message = @"ABPeoplePickerNavigationController在iOS9中已被移除，使用CNContactPickerViewController from ContactsUI.framework代替";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已废弃" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"soga" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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

#pragma mark - factory

- (UIButton *)createMyButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    return btn;
}

- (void)showMessageAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"soga" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

@end
