//
//  BMXSwitchLayer.m
//  BMXSwitch
//
//  Created by Massimiliano Bigatti on 23/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import "BMXSwitchLayer.h"

@implementation BMXSwitchLayer

+ (id)layer
{
    return [[BMXSwitchLayer alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        _contentLayer = [CALayer layer];
        [self addSublayer: _contentLayer];
        
        _canvasLayer = [CALayer layer];
        [self addSublayer: _canvasLayer];
        
        _knobLayer = [CALayer layer];
        [self addSublayer: _knobLayer];
        
        for (CALayer *layer in self.sublayers) {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
        
        _maskLayer = [CALayer layer];
        _maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    }
    return self;
}

#pragma mark - Properties

- (void)setTranslationX:(CGFloat)translationX
{
    _translationX = translationX;
    
    if (translationX != 0) {
        _contentLayer.transform = CATransform3DMakeTranslation(translationX, 0, 0);
        _knobLayer.transform = _contentLayer.transform;
        
    } else {
        _contentLayer.transform = CATransform3DIdentity;
        _knobLayer.transform = CATransform3DIdentity;
        
    }
}

#pragma mark - Privates

- (void)updateCanvasImage:(UIImage*)image
{
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    _canvasLayer.contents = (__bridge id)(image.CGImage);
    [CATransaction commit];
}

- (void)updateContentImage:(UIImage*)image
{
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    _contentLayer.contents = (__bridge id)(image.CGImage);
    [CATransaction commit];
}

- (void)updateKnobImage:(UIImage*)image
{
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    _knobLayer.contents = (__bridge id)(image.CGImage);
    [CATransaction commit];
}

- (void)updateMaskImage:(UIImage*)image
{
    _maskLayer.contents = (__bridge id)(image.CGImage);
    _maskLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.mask = _maskLayer;
}

@end
