//
//  BLEBaseClass.h
//  BLESerial_test_iPhone5
//
//  Created by 石井 孝佳 on 2013/11/12.
//  Copyright (c) 2013年 浅草ギ研. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class BLEBaseClass;

@protocol BLEBaseClassDelegate
- (void)didUpdateTemp:(BLEBaseClass*)blebase tempInfo:(NSString *)temp;
@end


@interface BLEBaseClass : NSObject
- (id)init;
- (BOOL)scanDevices:(NSString*)uuid;
- (void)scanStop;
@property (strong)		id<BLEBaseClassDelegate>	delegate;
@end
