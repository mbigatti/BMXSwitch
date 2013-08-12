//
//  BMSwitch.m
//  BMSwitch
//
//  Created by Massimiliano Bigatti on 10/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import "BMXSwitch.h"
#import "BMXSwitchLayer.h"
#import <QuartzCore/QuartzCore.h>

#define BMXLAYER ((BMXSwitchLayer*)self.layer)

@interface BMXSwitch()

@end


@implementation BMXSwitch {
    CGFloat _dragThreshold;
    CGSize _knobImageSize;
    
    NSMutableDictionary *_knobImages;
    NSMutableDictionary *_contentImages;
}


#pragma mark - Init

+ (Class)layerClass
{
    return [BMXSwitchLayer class];
}

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
    
    {
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(viewTapped:)];
        
        [self addGestureRecognizer: gr];
    }
    
    {
        UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(viewPanned:)];
        
        [self addGestureRecognizer: gr];
    }
}

- (void)didMoveToWindow
{
    BMXLAYER.contentsScale = [UIScreen mainScreen].scale;
}


#pragma mark - Gesture Recognizer callbacks

- (void)viewTapped:(UITapGestureRecognizer*)gr
{
    if (gr.state == UIGestureRecognizerStateRecognized) {
        self.highlighted = NO;
        
        [self toggleAnimated: YES];
        [self sendActionsForControlEvents: UIControlEventValueChanged];
    }
}

- (void)viewPanned:(UIPanGestureRecognizer*)gr
{
    CGPoint p = [gr translationInView: self];
    
    if (gr.state == UIGestureRecognizerStateBegan ||
        gr.state == UIGestureRecognizerStateChanged) {
        
        [CATransaction begin];
        [CATransaction setDisableActions: YES];
        
        if (_on) {
            CGFloat xx = _canvasImage.size.width - _knobImageSize.width - self.knobOffsetX * 2;
            
            if (p.x < 0 && p.x >= -xx) {
                CGFloat x = _canvasImage.size.width - _knobImageSize.width - self.knobOffsetX * 2 + p.x;
                
                BMXLAYER.translationX = x;
            }
            
        } else {
            CGFloat xx = _canvasImage.size.width - self.knobOffsetX * 2 - _knobImageSize.width;
            
            if (p.x > 0 && p.x <= xx) {
                CGFloat x = p.x;
                
                BMXLAYER.translationX = x;
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

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted: highlighted];
    
    [self refreshContentImage];
    [self refreshKnobImage];
}

- (void)setCanvasImage:(UIImage *)canvasImage
{
    _canvasImage = canvasImage;

    [BMXLAYER updateCanvasImage: canvasImage];
    
    BMXLAYER.canvasLayer.frame = CGRectMake(0, 0, canvasImage.size.width, canvasImage.size.height);
    
    _dragThreshold = (_canvasImage.size.width / 2) * 1 / 3;
}

- (void)setMaskImage:(UIImage *)maskImage
{
    _maskImage = maskImage;
    [BMXLAYER updateMaskImage: maskImage];
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
    
    [self refreshContentImage];
    [self updateContentFrame];
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
    
    [self refreshSwitchState];
    [self refreshKnobImage];
    [self updateKnobFrame];
    [self updateContentFrame];
}

- (void)setKnobOffsetX:(CGFloat)knobOffsetX
{
    _knobOffsetX = knobOffsetX;
    
    [self refreshSwitchState];
    [self updateKnobFrame];
}

- (void)setKnobOffsetY:(CGFloat)knobOffsetY
{
    _knobOffsetY = knobOffsetY;
    [self refreshSwitchState];
    [self updateKnobFrame];
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
    [self refreshSwitchState];
}


#pragma mark - Privates

- (void)refreshSwitchState
{
    [self refreshKnobImage];

    if (_on) {
        CGFloat x = self.frame.size.width - _knobImageSize.width - self.knobOffsetX * 2;
        
        BMXLAYER.translationX = x;
        
    } else {
        BMXLAYER.translationX = 0;
        
    }
}

- (void)updateKnobFrame
{
    UIImage *image = [self knobImageForState: UIControlStateNormal];
    
    BMXLAYER.knobLayer.frame = CGRectMake(self.knobOffsetX, self.knobOffsetY, image.size.width, image.size.height);
}

- (void)updateContentFrame
{
    UIImage *image = [self contentImageForState: UIControlStateNormal];
    
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    CGFloat x = (_knobImageSize.width + self.knobOffsetX * 2) / 2 - w / 2;
    CGFloat y = (_canvasImage.size.height - h) / 2;
    
    BMXLAYER.contentLayer.frame = CGRectMake(x, y, w, h);
}

- (void)refreshKnobImage
{
    NSNumber *key;
    
    if (self.enabled) {
        if (self.highlighted) {
            key = [NSNumber numberWithInteger: UIControlStateHighlighted];
            
            if ([_knobImages objectForKey:key] == nil) {
                key = [NSNumber numberWithInteger: UIControlStateNormal];
            }
        } else {
            if ([self isOn]) {
                key = [NSNumber numberWithInteger: UIControlStateSelected];
            } else {
                key = [NSNumber numberWithInteger: UIControlStateNormal];
            }
        }
    } else {
        key = [NSNumber numberWithInteger: UIControlStateDisabled];
    }
    
    UIImage *image = [_knobImages objectForKey: key];
    [BMXLAYER updateKnobImage: image];
}

- (void)refreshContentImage
{
    NSNumber *key;
    
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
    [BMXLAYER updateContentImage: image];
}


#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL result = [super beginTrackingWithTouch: touch withEvent: event];
    
    self.highlighted = YES;
    
    return result;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    BOOL high = self.highlighted;
    [super cancelTrackingWithEvent: event];
    self.highlighted = high;
}

@end
