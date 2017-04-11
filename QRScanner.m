//
//  QRScanner.m
//  pixoHealth
//
//  Created by chelsea on 2017/3/31.
//  Copyright © 2017年 iXensor. All rights reserved.
//

#import "QRScanner.h"

@interface QRScanner ()

@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL isReading;

@end

@implementation QRScanner
-(instancetype)initWithView:(UIView*)previewView{
    self = [super init];
    
    self.previewView = previewView;
    
    return self;
}

-(BOOL)startReading{
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if(!deviceInput){
        DebugLog(@"%@",[error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:deviceInput];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_previewView.layer.bounds];
    [_previewView.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    _isReading = YES;
    
    return YES;
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
        
    [_videoPreviewLayer removeFromSuperlayer];
    _isReading = NO;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if(metadataObjects && metadataObjects.count > 0){
        DebugLog(@"MetadataObjects:%@",metadataObjects);
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if([metadataObj.type isEqualToString:AVMetadataObjectTypeQRCode]){
            
            [_delegate qrCodeDidScan:metadataObj];
        }
    }
}


@end
