//
//  PECropViewController.m
//  PhotoCropEditor
//
//  Created by kishikawa katsumi on 2013/05/19.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import "PECropViewController.h"
#import "PECropView.h"

@interface PECropViewController ()

@property (nonatomic) PECropView *cropView;

@end

@implementation PECropViewController
@synthesize rotationEnabled = _rotationEnabled;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    self.rotationEnabled = NO;
}

- (void)loadView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.backgroundColor = [UIColor whiteColor];
    self.view = contentView;
    
    self.cropView = [[PECropView alloc] initWithFrame:contentView.bounds];
    [contentView addSubview:self.cropView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cropView.image = self.image;
    self.cropView.rotationGestureRecognizer.enabled = _rotationEnabled;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.cropAspectRatio != 0) {
        self.cropAspectRatio = self.cropAspectRatio;
    }
    if (!CGRectEqualToRect(self.cropRect, CGRectZero)) {
        self.cropRect = self.cropRect;
    }
    if (!CGRectEqualToRect(self.imageCropRect, CGRectZero)) {
        self.imageCropRect = self.imageCropRect;
    }
    
    self.keepingCropAspectRatio = self.keepingCropAspectRatio;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.cropView.image = image;
}

- (void)setKeepingCropAspectRatio:(BOOL)keepingCropAspectRatio
{
    _keepingCropAspectRatio = keepingCropAspectRatio;
    self.cropView.keepingCropAspectRatio = self.keepingCropAspectRatio;
}

- (void)setCropAspectRatio:(CGFloat)cropAspectRatio
{
    _cropAspectRatio = cropAspectRatio;
    self.cropView.cropAspectRatio = self.cropAspectRatio;
}

- (void)setCropRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    _imageCropRect = CGRectZero;
    
    CGRect cropViewCropRect = self.cropView.cropRect;
    cropViewCropRect.origin.x += cropRect.origin.x;
    cropViewCropRect.origin.y += cropRect.origin.y;
    
    CGSize size = CGSizeMake(fminf(CGRectGetMaxX(cropViewCropRect) - CGRectGetMinX(cropViewCropRect), CGRectGetWidth(cropRect)),
                             fminf(CGRectGetMaxY(cropViewCropRect) - CGRectGetMinY(cropViewCropRect), CGRectGetHeight(cropRect)));
    cropViewCropRect.size = size;
    self.cropView.cropRect = cropViewCropRect;
}

- (void)setImageCropRect:(CGRect)imageCropRect
{
    _imageCropRect = imageCropRect;
    _cropRect = CGRectZero;
    
    self.cropView.imageCropRect = imageCropRect;
}

- (BOOL)isRotationEnabled
{
    return _rotationEnabled;
}

- (void)setRotationEnabled:(BOOL)rotationEnabled
{
    _rotationEnabled = rotationEnabled;
    self.cropView.rotationGestureRecognizer.enabled = _rotationEnabled;
}

- (void)setCanResizeCropArea:(BOOL)canResizeCropArea
{
    _canResizeCropArea = canResizeCropArea;
    self.cropView.canResizeCropArea = canResizeCropArea;
}

- (CGAffineTransform)rotationTransform
{
    return self.cropView.rotation;
}

- (CGRect)zoomedCropRect
{
    return self.cropView.zoomedCropRect;
}

- (void)resetCropRect
{
    [self.cropView resetCropRect];
}

- (void)resetCropRectAnimated:(BOOL)animated
{
    [self.cropView resetCropRectAnimated:animated];
}

- (UIImage *)croppedImage
{
    return self.cropView.croppedImage;
}

@end
