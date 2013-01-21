//
//  BMSwitch.m
//
//  Created by Massimiliano Bigatti on 10/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import "BMXSwitch.h"
#import <QuartzCore/QuartzCore.h>

@implementation BMXSwitch {
    CALayer *_topLayer;
    CALayer *_contentLayer;
    CALayer *_knobLayer;
    CALayer *_mask;
    
    CGFloat _dragThreshold;
    CGSize _knobImageSize;
    CGSize _contentImageSize;
    
    NSMutableDictionary *_knobImages;
    NSMutableDictionary *_contentImages;
}


#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initState];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder: decoder];
    if (self) {
        [self initState];
    }
    return self;
}

- (void)initState
{
    _knobImages = [[NSMutableDictionary alloc] initWithCapacity: 3];
    _contentImages = [[NSMutableDictionary alloc] initWithCapacity: 3];
    
    self.backgroundColor = [UIColor clearColor];
    
    //
    //
    //
    _contentLayer = [CALayer layer];
    _contentLayer.contentsScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer: _contentLayer];
    
    //
    //
    //
    _topLayer = [CALayer layer];
    _topLayer.contentsScale = [[UIScreen mainScreen] scale];
    _topLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer: _topLayer];
    
    //
    //
    //
    _mask = [CALayer layer];
    _mask.contentsScale = [[UIScreen mainScreen] scale];
    
    //
    //
    //
    _knobLayer = [CALayer layer];
    _knobLayer.contentsScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer: _knobLayer];
    
    {
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(viewTapped:)];
        
        [self addGestureRecognizer: gr];
    }
    
    {
        UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(viewPanned:)];
        
        [self addGestureRecognizer: gr];
    }
}


#pragma mark - Gesture Recognizer callbacks

- (void)viewTapped:(UITapGestureRecognizer*)gr
{
    self.highlighted = NO;
    
    [self refreshContentImage];
    [self refreshKnobImage];
    
    [self toggleAnimated: YES];
    
    [self sendActionsForControlEvents: UIControlEventValueChanged];
}

- (void)viewPanned:(UIPanGestureRecognizer*)gr
{
    CGPoint p = [gr translationInView: self];
    
    if (gr.state == UIGestureRecognizerStateBegan ||
        gr.state == UIGestureRecognizerStateChanged) {
        
        [CATransaction begin];
        [CATransaction setDisableActions: YES];
        
        if (_on) {
            CGFloat xx = _canvasImage.size.width - _knobImageSize.width - _knobOffsetX * 2;
            
            if (p.x < 0 && p.x >= -xx) {
                CGFloat x = _canvasImage.size.width - _knobImageSize.width - _knobOffsetX * 2 + p.x;
                
                _contentLayer.transform = CATransform3DMakeTranslation(x, 0, 0);
                _knobLayer.transform = _contentLayer.transform;
            }
            
        } else {
            CGFloat xx = _canvasImage.size.width - _knobOffsetX * 2 - _knobImageSize.width;
            
            if (p.x > 0 && p.x <= xx) {
                CGFloat x = p.x;
                
                _contentLayer.transform = CATransform3DMakeTranslation(x, 0, 0);
                _knobLayer.transform = _contentLayer.transform;
            }
        }
        
        [CATransaction commit];
    }
    
    if (gr.state == UIGestureRecognizerStateCancelled ||
        gr.state == UIGestureRecognizerStateEnded) {

        if (abs(p.x) < _dragThreshold) {
            [self setOn: _on animated: YES];
            
        } else {
            [self setOn: !_on animated: YES];
        }
        
        self.highlighted = NO;
        [self refreshContentImage];
        [self refreshKnobImage];
        
        [self sendActionsForControlEvents: UIControlEventValueChanged];
    }
}


#pragma mark - Properties

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled: enabled];
    
    [self refreshContentImage];
    [self refreshKnobImage];
}

- (void)setCanvasImage:(UIImage *)canvasImage
{
    _canvasImage = canvasImage;
    _topLayer.contents = (__bridge id)(_canvasImage.CGImage);
}

- (void)setMaskImage:(UIImage *)maskImage
{
    _maskImage = maskImage;
    _mask.contents = (__bridge id)(_maskImage.CGImage);
    self.layer.mask = _mask;
}

- (UIImage *)contentImageForState:(UIControlState)state
{
    NSNumber *key = [NSNumber numberWithInteger: state];
    return [_contentImages objectForKey: key];    
}

- (void)setContentImage:(UIImage *)contentImage forState:(UIControlState)state
{
    NSNumber *key = [NSNumber numberWithInteger: state];
    if (contentImage != nil) {
        [_contentImages setObject: contentImage forKey: key];
    } else {
        [_contentImages removeObjectForKey: key];
    }
    
    _contentImageSize = contentImage.size;
    
    [self refreshContentImage];
    [self repositionLayers];
}

- (UIImage *)knobImageForState:(UIControlState)state
{
    NSNumber *key = [NSNumber numberWithInteger: state];
    return [_knobImages objectForKey: key];
}

- (void)setKnobImage:(UIImage *)knobImage forState:(UIControlState)state
{
    NSNumber *key = [NSNumber numberWithInteger: state];
    if (knobImage != nil) {
        [_knobImages setObject: knobImage forKey: key];
    } else {
        [_knobImages removeObjectForKey: key];
    }
    
    _knobImageSize = knobImage.size;
    [self refreshKnobImage];
    [self repositionLayers];
}

- (void)setKnobOffsetX:(CGFloat)knobOffsetX
{
    _knobOffsetX = knobOffsetX;
    [self repositionLayers];
}

- (void)setKnobOffsetY:(CGFloat)knobOffsetY
{
    _knobOffsetY = knobOffsetY;
    [self repositionLayers];
}


#pragma mark - Public Interface

- (void)toggleAnimated:(BOOL)animated
{
    [self setOn: !_on animated: animated];
}

- (void)setOn:(BOOL)on
{
    [self setOn: on animated: NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    _on = on;
    
    if (on) {
        CGFloat x = _canvasImage.size.width - _knobImageSize.width - _knobOffsetX * 2;
        
        _contentLayer.transform = CATransform3DMakeTranslation(x, 0, 0);
        _knobLayer.transform = _contentLayer.transform;
        
    } else {
        _contentLayer.transform = CATransform3DIdentity;
        _knobLayer.transform = CATransform3DIdentity;
        
    }
}


#pragma mark - Privates

- (void)refreshKnobImage
{
    NSNumber *key;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    
    if (self.enabled) {
        if (self.highlighted) {
            key = [NSNumber numberWithInteger: UIControlStateHighlighted];
            
            if ([_knobImages objectForKey:key] == nil) {
                key = [NSNumber numberWithInteger: UIControlStateNormal];
            }
        } else {
            key = [NSNumber numberWithInteger: UIControlStateNormal];
        }
    } else {
        key = [NSNumber numberWithInteger: UIControlStateDisabled];
    }
    
    UIImage *image = [_knobImages objectForKey: key];
    _knobLayer.contents = (__bridge id)(image.CGImage);
    
    [CATransaction commit];
}

- (void)refreshContentImage
{
    NSNumber *key;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    
    if (self.enabled) {
        if (self.highlighted) {
            key = [NSNumber numberWithInteger: UIControlStateHighlighted];
            
            if ([_contentImages objectForKey:key] == nil) {
                key = [NSNumber numberWithInteger: UIControlStateNormal];
            }
        } else {
            key = [NSNumber numberWithInteger: UIControlStateNormal];
        }
    } else {
        key = [NSNumber numberWithInteger: UIControlStateDisabled];
    }
    
    UIImage *image = [_contentImages objectForKey: key];
    _contentLayer.contents = (__bridge id)(image.CGImage);
    
    [CATransaction commit];
}

- (void)repositionLayers
{
    {
        CGFloat w = _contentImageSize.width;
        CGFloat h = _contentImageSize.height;
        CGFloat x = (_knobImageSize.width + _knobOffsetX * 2) / 2 - w / 2;
        CGFloat y = (_canvasImage.size.height - h) / 2;
        
        _contentLayer.frame = CGRectMake(x, y, w, h);
    }
    
    _mask.frame = CGRectMake(0, 0, _maskImage.size.width, _maskImage.size.height);

    {
        _knobLayer.frame = CGRectMake(_knobOffsetX, _knobOffsetY, _knobImageSize.width, _knobImageSize.height);
    }
    
    _dragThreshold = (_canvasImage.size.width / 2) * 1 / 3;
}


#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL result = [super beginTrackingWithTouch: touch withEvent: event];
    
    self.highlighted = YES;
    
    [self refreshContentImage];
    [self refreshKnobImage];
    
    return result;
}

@end
