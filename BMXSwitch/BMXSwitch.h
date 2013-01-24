//
//  BMSwitch.h
//  BMSwitch
//
//  Created by Massimiliano Bigatti on 10/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMXSwitch : UIControl

@property (nonatomic, retain) UIImage *canvasImage;
@property (nonatomic, retain) UIImage *maskImage;

- (UIImage *)contentImageForState:(UIControlState)state;
- (void)setContentImage:(UIImage *)contentImage forState:(UIControlState)state;

- (UIImage *)knobImageForState:(UIControlState)state;
- (void)setKnobImage:(UIImage *)knobImage forState:(UIControlState)state;

@property (nonatomic, assign) CGFloat knobOffsetX;
@property (nonatomic, assign) CGFloat knobOffsetY;

@property (nonatomic, getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (void)toggleAnimated:(BOOL)animated;

@end
