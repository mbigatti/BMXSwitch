//
//  BMXViewController.h
//  BMXSwitchExample
//
//  Created by Massimiliano Bigatti on 11/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMXSwitch;

@interface BMXViewController : UIViewController

@property (weak, nonatomic) IBOutlet BMXSwitch *switch1;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)valueChanged:(BMXSwitch *)sender;
- (IBAction)buttonTouched:(UIButton *)sender;

@end
