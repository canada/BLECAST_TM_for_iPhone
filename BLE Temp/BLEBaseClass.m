//
//  BLEBaseClass.m
//  BLESerial_test_iPhone5
//
//  Created by 石井 孝佳 on 2013/11/12.
//  Copyright (c) 2013年 浅草ギ研. All rights reserved.
//
/*
 BLEの管理と通信を行う２つのクラス
 
 BLEBaseクラス     ：スキャン、接続、切断、スキャン情報の表示など
 BLEDeviceクラス   ：接続した周辺機器の実態を保持し、受信と送信を行う
 
 */

#import <Foundation/Foundation.h>
#import "BLEBaseClass.h"

@interface BLEBaseClass() <CBCentralManagerDelegate>
@property (strong)	CBCentralManager*	CentralManager;
//@property (strong)	NSMutableArray*		Devices;
@end

@implementation BLEBaseClass

- (id)init
{
    self = [super init];
    
    _CentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    //	wait for startup
    while ([_CentralManager state] == CBCentralManagerStateUnknown)	{
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    //_Devices = [NSMutableArray array];
    
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
}

- (BOOL)scanDevices:(NSString*)uuid
{
    if ([_CentralManager state] == CBCentralManagerStatePoweredOn)	{
        //	scan start
        [_CentralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @NO}];
        return TRUE;
    }
    return FALSE;
}

- (void)scanStop
{
    if ([_CentralManager state] == CBCentralManagerStatePoweredOn)	{
        [_CentralManager stopScan];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSRange range;
    range.location = 4;
    range.length = 1;
    char* bytes;
    
    NSString* myname   = @"BLECAST_TM";
    NSString* name = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    NSData  * data = [advertisementData objectForKey:CBAdvertisementDataManufacturerDataKey];
    
    NSString* temp;
    
    if(name == NULL) return;
    if(data == NULL) return;
    if(! [myname isEqualToString:name]) return;
    
    bytes = (char *)[data bytes];
    temp = [NSString stringWithFormat:@"%d%@", (int)bytes[4], ((int)bytes[5]) == -128 ? @".5" : @""];

    NSLog(@"name: %@",name);
    NSLog(@"temp:%@", temp);
    
    [self.delegate didUpdateTemp:self tempInfo:temp];
}

@end