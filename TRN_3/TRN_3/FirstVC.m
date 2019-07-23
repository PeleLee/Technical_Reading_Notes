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
#import <EventKitUI/EventKitUI.h>

#import <Masonry/Masonry.h>
#import <Masonry/View+MASAdditions.h>
#import <SVProgressHUD.h>

static NSString *const sogaCalendar = @"Soga的事项日历";

@interface FirstVC ()<CNContactPickerDelegate, EKCalendarChooserDelegate>

//@property (nonatomic, strong) ADBannerView *adView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) EKEventStore *myEventStore;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.titleStr isEqualToString:iAd]) {
        [self iAdTest];
    }
    else if ([self.titleStr isEqualToString:EventKitUI]) {
        // https://my.oschina.net/u/2340880/blog/3066175
        [self eventKitUITest];
    }
    else if ([self.titleStr isEqualToString:AddressBookUI]) {
        [self addressBookUITest];
    }
    else if ([self.titleStr isEqualToString:InputFormat]) {
        [self test_inputFormat];
    }
    else if ([self.titleStr isEqualToString:BOOLOutOfBounds]) {
        [self test_boolOutBounds];
    }
    else if ([self.titleStr isEqualToString:TypeMandatoryConversion]) {
        [self test_typeMandatoryConversion];
    }
    else if ([self.titleStr isEqualToString:CommaOperator]) {
        [self test_commaOperator];
    }
}

#pragma mark - 逗号运算符

- (void)test_commaOperator {
    int a = 2;
    a = (a*3, 5 < 8);
    NSLog(@"a: %d", a);
    int x = (a = 3, a = 4, a = 6, a = 9);
    NSLog(@"b: %d, x: %d", a, x);
}

#pragma mark - 强制类型转换

- (void)test_typeMandatoryConversion {
    NSInteger a = 10;
    NSInteger b = 3;
    
    CGFloat c = a/b;
    CGFloat d = (CGFloat)a/b;
    CGFloat e = (CGFloat)(a/b);
    
    NSLog(@"未强转: %f", c);
    NSLog(@"正确强转: %f", d);
    NSLog(@"错误强转: %f", e);
    
    float f1 = a/b;
    float f2 = (float)a/b;
    float f3 = (float)(a/b);
    NSLog(@"未强转: %g", f1);
    NSLog(@"正确强转: %g", f2);
    NSLog(@"错误强转: %g", f3);
}

#pragma mark - BOOL越界问题

- (void)test_boolOutBounds {
    NSLog(@"可能是操作系统位数不同，实际输出与书中输出不一致。");
    BOOL a = 256;
    NSLog(@"a: %d", a);
//    if (a) {
//        NSLog(@"未越界");
//    }
    BOOL b = 768;
    NSLog(@"b: %d", b);
//    if (b) {
//        NSLog(@"越界");
//    }
}

#pragma mark - InputFormat

- (void)test_inputFormat {
    int a = 32;
    NSLog(@"==%d==", a);
    
    NSLog(@"==%9d==", a);
    
    NSLog(@"==%-9d==", a);
    
    NSLog(@"==%o==", a);
    
    NSLog(@"==%x==", a);
    
    long b = 14;
    NSLog(@"%ld", b);
    
    NSLog(@"%lx", b);
    
    double dl = 5.12;
    NSLog(@"==%e==", dl);
    
    NSLog(@"==%g==", dl);
    
    NSLog(@"==%9f==", dl);
    
    NSLog(@"==%9.4f==", dl);
    
    NSLog(@"==%lf==", dl);
    
    NSLog(@"==%le==", dl);
    
    NSLog(@"==%lg==", dl);
    
    NSLog(@"==%9lf==", dl);
    
    NSLog(@"==%9.4lf==", dl);
}

#pragma mark - Event Kit UI

- (void)eventKitUITest {
    UIButton *btn0 = [self createMyButton];
    [btn0 setTitle:@"获取系统日历的所有EKSource对象" forState:UIControlStateNormal];
    [btn0 addTarget:self action:@selector(getAllEKSourceObject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@120);
    }];
    
    UIButton *btn1 = [self createMyButton];
    [btn1 setTitle:@"获取系统日历中所有EKCalendar对象" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(getAllEKCalendarObject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(btn0.mas_bottom).offset(20);
    }];
    
    UIButton *btn2 = [self createMyButton];
    btn2.backgroundColor = [UIColor yellowColor];
    [btn2 setTitle:@"通过EKSource创建EKCalendar对象,显示在系统日历App中" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(createEKCalendarObject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1);
        make.top.equalTo(btn1.mas_bottom).offset(20);
        make.right.equalTo(@-20);
    }];
    
    UIButton *btn3 = [self createMyButton];
    [btn3 setTitle:@"通过NSPredicate查询所有EKEvent" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(queryEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1);
        make.top.equalTo(btn2.mas_bottom).offset(20);
    }];
    
    UIButton *btn4 = [self createMyButton];
    [btn4 setTitle:@"创建或修改EKEvent" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(changeCalendareEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1);
        make.top.equalTo(btn3.mas_bottom).offset(20);
    }];
    
    UIButton *btn5 = [self createMyButton];
    [btn5 setTitle:@"创建EKReminder对象" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(createEKReminderObject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn0);
        make.top.equalTo(btn4.mas_bottom).offset(20);
    }];
}

- (void)createEKReminderObject {
    EKReminder *reminder = [EKReminder reminderWithEventStore:self.myEventStore];
    reminder.title = sogaCalendar;
    reminder.notes = @"soga soga";
    for (EKCalendar *cal in [self.myEventStore calendarsForEntityType:EKEntityTypeEvent]) {
        if ([cal.title isEqualToString:@"自定义"]) {
            reminder.calendar = cal;
            break;
        }
    }
    NSError *error = nil;
    [self.myEventStore saveReminder:reminder commit:YES error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"需设置iCloud账号"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"EKReminder创建成功"];
    }
}

- (void)changeCalendareEvent {
    EKCalendar *calen = nil;
    for (EKCalendar *cal in [self.myEventStore calendarsForEntityType:EKEntityTypeEvent]) {
        if ([cal.title isEqualToString:sogaCalendar]) {
            calen = cal;
            break;
        }
    }
    EKEvent *event = [EKEvent eventWithEventStore:self.myEventStore];
    event.title = @"从应用创建的事件";
    event.startDate = [NSDate date];
    event.calendar = calen;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneMonthFromNowComponents = [[NSDateComponents alloc] init];
    oneMonthFromNowComponents.hour += 1;
    NSDate *endDate = [calendar dateByAddingComponents:oneMonthFromNowComponents toDate:[NSDate date] options:0];
    event.endDate = endDate;
    event.notes = @"备注";
    [event setAllDay:NO];
    
    NSError *error = nil;
    [self.myEventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"创建EKEvent成功，可在系统日历中查看"];
    }
    NSLog(@"%@", error);
}

- (void)queryEvent {
    for (EKCalendar *cal in [self.myEventStore calendarsForEntityType:EKEntityTypeEvent]) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *oneMonthFromNowComponents = [NSDateComponents new];
        oneMonthFromNowComponents.month = 1;
        NSDate *oneMonthFromNow = [calendar dateByAddingComponents:oneMonthFromNowComponents
                                                            toDate:[NSDate date]
                                                           options:0];
        
        NSPredicate *predicate = [self.myEventStore predicateForEventsWithStartDate:[NSDate date] endDate:oneMonthFromNow calendars:@[cal]];
        
        NSArray *eventArray = [self.myEventStore eventsMatchingPredicate:predicate];
        NSLog(@"%@", eventArray);
    }
}

- (void)createEKCalendarObject {
    EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.myEventStore];
    for (EKSource *source in self.myEventStore.sources) {
        if (source.sourceType == EKSourceTypeLocal) {
            calendar.source = source;
        }
    }
    calendar.title = sogaCalendar;
    calendar.CGColor = [UIColor yellowColor].CGColor;
    NSError *error;
    [self.myEventStore saveCalendar:calendar commit:YES error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"创建成功,可在系统日历中查看"];
    }
}

- (void)getAllEKCalendarObject {
    // 访问权限
    __weak typeof(self) weakSelf = self;
    [self.myEventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"拒绝访问");
        }
        else {
            NSArray *calendars = [weakSelf.myEventStore calendarsForEntityType:EKEntityTypeEvent];
            for (EKCalendar *calendar in calendars) {
                NSLog(@"EKCalendar Object:%@", calendar);
                NSLog(@"EKSource Object:%@", calendar.source);
            }
        }
    }];
    
}

- (void)getAllEKSourceObject {
    [self.myEventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"拒绝访问");
        }
        else {
            for (EKSource *ekSource in self.myEventStore.sources) {
                NSLog(@"%@", ekSource);
            }
        }
    }];
}

- (void)calendarChooserSelectionDidChange:(EKCalendarChooser *)calendarChooser {
    NSLog(@"111");
}

- (void)calendarChooserDidFinish:(EKCalendarChooser *)calendarChooser {
    NSLog(@"222");
}

- (void)calendarChooserDidCancel:(EKCalendarChooser *)calendarChooser {
    NSLog(@"333");
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

- (EKEventStore *)myEventStore {
    if (!_myEventStore) {
        _myEventStore = [EKEventStore new];
    }
    return _myEventStore;
}

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
    [btn.titleLabel setNumberOfLines:0];
    return btn;
}

- (void)showMessageAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"soga" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

@end
