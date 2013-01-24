//
//  BMXSwitchLayer.h
//  BMXSwitch
//
//  Created by Massimiliano Bigatti on 23/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BMXSwitchLayer : CALayer

@property (nonatomic, assign) CGFloat translationX;

@property (nonatomic, readonly, strong) CALayer *contentLayer;
@property (nonatomic, readonly, strong) CALayer *canvasLayer;
@property (nonatomic, readonly, strong) CALayer *knobLayer;
@property (nonatomic, readonly, strong) CALayer *maskLayer;

- (void)updateCanvasImage:(UIImage*)image;
- (void)updateContentImage:(UIImage*)image;
- (void)updateKnobImage:(UIImage*)image;
- (void)updateMaskImage:(UIImage*)image;

@end
