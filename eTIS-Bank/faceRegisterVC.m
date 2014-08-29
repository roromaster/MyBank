//
//  faceRegisterVC.m
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "faceRegisterVC.h"
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface faceRegisterVC ()
{


}
@end

@implementation faceRegisterVC

NSMutableArray *progressionImages;

NSArray *StepInformation;

NSTimer *animationLoop;

NSArray *images_name;

int current_step =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    current_step =0;
      images_name= @[@"face-10%.png",
                              @"face-20%.png",
                              @"face-30%.png",
                              @"face-40%.png",
                              @"face-50%.png",
                              @"face-60%.png",
                              @"face-70%.png",
                              @"face-80%.png",
                              @"face-90%.png",
                              @"face-100%.png",
                     @"face-100%.png"
                              ];
    
    StepInformation = [[NSArray alloc] initWithObjects:
                       @"Place your Face in front of the Camera",
                       @"Face Detected ... Don't move",
                       @"Computing your face reference",
                       @"Securing your face reference",
                       @"Validation of your registration",
                       @"Done", nil];
    
    
    _registerProgressionImage.image =[UIImage imageNamed:[images_name objectAtIndex:0]];

    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login Background.png"]];
    
    [background sizeToFit];
    [background setFrame:self.view.frame];
    [background setBounds:self.view.bounds];
    
    [self.view addSubview:background];
    
    background.layer.zPosition = -1;
    
    NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
    
    _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];

    
    [self setupAVCapture];
    _faceDetected = FALSE;
    _faceOverlay.hidden = FALSE;
    _faceOverlay.alpha = 0.3;
    self->_scanningBar.alpha = 0;
    _scanningLineInitialPosition = CGPointMake(self->_scanningBar.center.x, self->_scanningBar.center.y);
    
    
    
    NSLog(@"view Face didload");

    animationLoop =   [NSTimer scheduledTimerWithTimeInterval:2
                                                                target:self
                                                              selector:@selector(manageRegisterStep)
                                                              userInfo:nil
                                                               repeats:YES];
    

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) manageRegisterStep
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionMoveIn;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_informationLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    
    _informationLabel.text = StepInformation[current_step];
    _informationLabel.textColor = [UIColor whiteColor];
    
    
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 1.0;
    animation2.type = kCATransitionFade;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];


    [_registerProgressionImage.layer addAnimation:animation2 forKey: @"ProgressionFace"];
    _registerProgressionImage.image = [UIImage imageNamed:[images_name objectAtIndex:current_step*2]];
    
    current_step++;
    
    if (current_step == [StepInformation count])
        [animationLoop invalidate];
        
    
}


- (void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    NSLog(@"ViewDidAppear");
    self->_scanningBar.alpha = 0;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

     [animationLoop invalidate];
    
    
}



- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    // got an image
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    CIImage *ciImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer options:(__bridge NSDictionary *)attachments];
    if (attachments)
        CFRelease(attachments);
    NSDictionary *imageOptions = nil;
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    int exifOrientation;
    
    enum {
        PHOTOS_EXIF_0ROW_TOP_0COL_LEFT			= 1, //   1  =  0th row is at the top, and 0th column is on the left (THE DEFAULT).
        PHOTOS_EXIF_0ROW_TOP_0COL_RIGHT			= 2, //   2  =  0th row is at the top, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT      = 3, //   3  =  0th row is at the bottom, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_LEFT       = 4, //   4  =  0th row is at the bottom, and 0th column is on the left.
        PHOTOS_EXIF_0ROW_LEFT_0COL_TOP          = 5, //   5  =  0th row is on the left, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP         = 6, //   6  =  0th row is on the right, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_BOTTOM      = 7, //   7  =  0th row is on the right, and 0th column is the bottom.
        PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM       = 8  //   8  =  0th row is on the left, and 0th column is the bottom.
    };
    
    switch (curDeviceOrientation) {
        case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM;
            break;
        case UIDeviceOrientationLandscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
            break;
        case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
            break;
        case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
        default:
            exifOrientation = PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP;
            break;
    }
    
    imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:exifOrientation] forKey:CIDetectorImageOrientation];
    NSArray *features = [_faceDetector featuresInImage:ciImage options:imageOptions];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self IsFaceDetected:features];
    });
}


-(void) viewWillLayoutSubviews

{
    
}

-(void) IsFaceDetected: (NSArray *) features
{
    
    if ([features count])
    {
        NSLog(@"FaceDetected");
        if (!_faceDetected)
        {
            NSLog(@"FaceDetected Animation");
            
            [UIView beginAnimations:@"FaceDetected" context:nil];
            [UIView setAnimationBeginsFromCurrentState:TRUE];
            [UIView setAnimationDuration:1.0];
            
            _faceOverlay.alpha = 0.4;
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            
            [_faceOverlay.layer addAnimation:transition forKey:nil];
            [_faceOverlay setImage:[UIImage imageNamed: @"FaceOverlayDetected.png"]];
            [UIView commitAnimations];
            
            self->_scanningBar.alpha = 1;
            self->_scanningBar.center = _scanningLineInitialPosition;
            
            [UIView animateWithDuration:3.0f
                                  delay:0.0f
             
                                options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionAllowAnimatedContent
             
                             animations:^ {
                                 
                                 self->_scanningBar.alpha = 0.3;
                                 self->_scanningBar.center= CGPointMake(_scanningBar.center.x, _scanningBar.center.y + 250);
                             }
                             completion:^(BOOL finished) {
                                 
                                 if (finished)
                                     self->_scanningBar.alpha = 0;
                                 
                             }
             ];
            
            _faceDetected = TRUE;
        }
    }
    else
    {
        NSLog(@"FaceNotDetected");
        if (_faceDetected)
        {
            NSLog(@"FaceUnDetected Animation");
            [UIView beginAnimations:@"FaceUnDetected" context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationBeginsFromCurrentState:TRUE];
            _faceOverlay.alpha = 0.3;
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            
            [_faceOverlay.layer addAnimation:transition forKey:nil];
            [_faceOverlay setImage:[UIImage imageNamed: @"FaceOverlay.png"]];
            
            [UIView commitAnimations];
            _faceDetected = FALSE;
            self->_scanningBar.alpha = 0;
            
            
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(AVCaptureDevice *)frontFacingCameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            captureDevice = device;
            break;
        }
    }
    
    //  couldn't find one on the front, so just get the default video device.
    if ( ! captureDevice)
    {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}


- (void)setupAVCapture
{
    NSError *error = nil;
    
    _session = [AVCaptureSession new];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [_session setSessionPreset:AVCaptureSessionPreset1280x720];
    else
        [_session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    // Select a video device, make an input
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    
    
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if( error != nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Failed with error %d", (int)[error code]]
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ( [_session canAddInput:deviceInput] )
        [_session addInput:deviceInput];
    
    // Make a video data output
    _videoDataOutput = [AVCaptureVideoDataOutput new];
    
    // we want BGRA, both CoreGraphics and OpenGL work well with 'BGRA'
    NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
                                       [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    [_videoDataOutput setVideoSettings:rgbOutputSettings];
    [_videoDataOutput setAlwaysDiscardsLateVideoFrames:YES]; // discard if the data output queue is blocked (as we process the still image)
    
    // create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured
    // a serial dispatch queue must be used to guarantee that video frames will be delivered in order
    // see the header doc for setSampleBufferDelegate:queue: for more information
    _videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueueFace", DISPATCH_QUEUE_SERIAL);
    [_videoDataOutput setSampleBufferDelegate:self queue:_videoDataOutputQueue];
    
    if ( [_session canAddOutput:_videoDataOutput] )
        [_session addOutput:_videoDataOutput];
    [[_videoDataOutput connectionWithMediaType:AVMediaTypeVideo] setEnabled:YES];
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [self->_previewView layer];
    [rootLayer setMasksToBounds:YES];
    [_previewLayer setFrame:[rootLayer bounds]];
    [rootLayer addSublayer:_previewLayer];
    [_session startRunning];
    
}

- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
        direction:(int)direction
{
    
    //    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    scale.fromValue = @0.75; // Your from value (not obvious from the question)
    //    scale.toValue = @2.0;
    //    scale.duration = 2;
    //    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //
    
    CAKeyframeAnimation * flipToBackAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    flipToBackAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    flipToBackAnimation.removedOnCompletion = YES;
    flipToBackAnimation.duration = inDuration; /* Usually 0.5 */
    flipToBackAnimation.values = [NSArray arrayWithObjects:
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.5 * M_PI, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0, 1, 0)],
                                  nil];
    
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -1.0f / 2000;
    
    inLayer.sublayerTransform = perspectiveTransform;
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.duration = inDuration; /* Usually 0.5 */
    scaleAnimation.values = [NSArray arrayWithObjects:
                             [NSValue valueWithCATransform3D:CATransform3DIdentity],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(.95, .95, .95)],
                             [NSValue valueWithCATransform3D:CATransform3DIdentity],
                             nil];
    
    
    
    inLayer.transform = [[flipToBackAnimation.values lastObject] CATransform3DValue];
    [inLayer addAnimation:flipToBackAnimation forKey:kCATransition];
}



@end
