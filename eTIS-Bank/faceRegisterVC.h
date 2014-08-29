//
//  faceRegisterVC.h
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface faceRegisterVC : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *registerProgressionImage;
@property (weak, nonatomic) IBOutlet UIImageView *faceOverlay;
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIImageView *scanningBar;


@property (weak, nonatomic) IBOutlet UILabel *informationLabel;


@property AVCaptureSession *session;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property AVCaptureVideoDataOutput *videoDataOutput;

@property dispatch_queue_t videoDataOutputQueue;
@property  AVCaptureStillImageOutput *stillImageOutput;

@property CGPoint scanningLineInitialPosition;
@property UIView *flashView;
@property UIImage *faceGuide;

@property CIDetector *faceDetector;
@property BOOL faceDetected;




@end
