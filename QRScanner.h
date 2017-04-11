//
//  QRScanner.h
//  pixoHealth
//
//  Created by chelsea on 2017/3/31.
//  Copyright © 2017年 iXensor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol QRScannerDelegate
-(void)qrCodeDidScan:(AVMetadataMachineReadableCodeObject *)metadataObj;
@end

@interface QRScanner : NSObject <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, weak) id <QRScannerDelegate> delegate;
-(instancetype)initWithView:(UIView*)previewView;
-(BOOL)startReading;
-(void)stopReading;
@end
