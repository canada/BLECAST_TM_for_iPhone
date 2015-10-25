//
//  ViewController.m
//  BLE Temp
//
//  Created by Canada, Masakatz on 2015/10/24.
//  Copyright © 2015年 Canada, Masakatz. All rights reserved.
//

#import "ViewController.h"
#import "BLEBaseClass.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <BLEBaseClassDelegate>
@property (strong)		BLEBaseClass*	BaseClass;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _TempText.text = @"--";
    
    UIUserNotificationType types = UIUserNotificationTypeBadge;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    //	BLEBaseClassの初期化
    _BaseClass = [[BLEBaseClass alloc] init];
    _BaseClass.delegate = self;
    //	周りのBLEデバイスからのadvertise情報のスキャンを開始する
    [_BaseClass scanDevices:nil];

}

- (void)didUpdateTemp:(BLEBaseClass *)blebase tempInfo:(NSString *)temp
{
    // write to badge
    NSInteger inttemp = [temp integerValue];
    [UIApplication sharedApplication].applicationIconBadgeNumber = (long)inttemp > 0 ? inttemp : 0;

    _TempText.text = temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
