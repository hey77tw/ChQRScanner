# QRScanner

```Objective-C
#import "QRScanner.h"

@interface yourViewController () <QRScannerDelegate>
{
    QRScanner * qrScanner;
}
@end

@implementation yourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    qrScanner = [[QRScanner alloc] initWithView:qrScannerPreviewView];
    qrScanner.delegate = self;
    
    [qrScanner startReading];
}

#pragma mark - QRScannerDelegate

-(void)qrCodeDidScan:(AVMetadataMachineReadableCodeObject *)metadataObj{
    [qrScanner stopReading];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * qrCodeStr = [NSString stringWithFormat:@"%@",metadataObj.stringValue];
        NSLog(@"%@",qrCodeStr);
    });
}

@end

```
