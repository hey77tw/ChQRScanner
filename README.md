# ChQRScanner

```Objective-C
#import "ChQRScanner.h"

@interface yourViewController () <ChQRScannerDelegate>
{
    ChQRScanner * qrScanner;
}
@end

@implementation yourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    qrScanner = [[ChQRScanner alloc] initWithView:qrScannerPreviewView];
    qrScanner.delegate = self;
    
    [qrScanner startReading];
}

#pragma mark - ChQRScannerDelegate

-(void)qrCodeDidScan:(AVMetadataMachineReadableCodeObject *)metadataObj{
    [qrScanner stopReading];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * qrCodeStr = [NSString stringWithFormat:@"%@",metadataObj.stringValue];
        NSLog(@"%@",qrCodeStr);
    });
}

@end

```
