//
//  MyFaceAuthViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 13/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MyFaceAuthViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>
{
    IBOutlet UIView *previewView;
    
    __weak IBOutlet UIImageView *FaceDetectedOverlay;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *previewLayer;
    AVCaptureVideoDataOutput *videoDataOutput;

    dispatch_queue_t videoDataOutputQueue;
    AVCaptureStillImageOutput *stillImageOutput;
    
    __weak IBOutlet UIImageView *ScanningLine;
    CGPoint scanningLineInitialPosition;
    UIView *flashView;
    UIImage *faceGuide;
    
    CIDetector *faceDetector;
    BOOL faceDetected;
    
}

@end
