//
//  MyFingerprintAuthVC.h
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MyFingerprintAuthVC : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>

{
    IBOutlet UIView *previewView;
    
    __weak IBOutlet UIImageView *FingersDetectedOverlay;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *previewLayer;
    AVCaptureVideoDataOutput *videoDataOutput;
    
    dispatch_queue_t videoDataOutputQueue;
    AVCaptureStillImageOutput *stillImageOutput;
    
    UIView *flashView;
    UIImage *fingersGuide;

}
@end
