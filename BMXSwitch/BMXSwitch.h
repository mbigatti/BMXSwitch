//
//  BMSwitch.h
//
//  Created by Massimiliano Bigatti on 10/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMXSwitch : UIControl

@property (nonatomic, retain) UIImage *canvasImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIImage *maskImage UI_APPEARANCE_SELECTOR;

- (UIImage *)contentImageForState:(UIControlState)state  UI_APPEARANCE_SELECTOR;
- (void)setContentImage:(UIImage *)contentImage forState:(UIControlState)state
 UI_APPEARANCE_SELECTOR;

- (UIImage *)knobImageForState:(UIControlState)state  UI_APPEARANCE_SELECTOR;
- (void)setKnobImage:(UIImage *)knobImage forState:(UIControlState)state
UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat offsetLeft UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat knobOffsetX UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat knobOffsetY UI_APPEARANCE_SELECTOR;

@property (nonatomic, getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (void)toggleAnimated:(BOOL)animated;

@end
