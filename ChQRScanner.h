/*
 Created by Chelsea Huang on 2017/3/31.
 https://github.com/ch126
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ChQRScannerDelegate
-(void)qrCodeDidScan:(AVMetadataMachineReadableCodeObject *)metadataObj;
@end

@interface ChQRScanner : NSObject <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, weak) id <ChQRScannerDelegate> delegate;
-(instancetype)initWithView:(UIView*)previewView;
-(BOOL)startReading;
-(void)stopReading;
@end
