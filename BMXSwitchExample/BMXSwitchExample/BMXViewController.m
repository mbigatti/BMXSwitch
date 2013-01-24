//
//  BMXViewController.m
//  BMXSwitchExample
//
//  Created by Massimiliano Bigatti on 11/01/13.
//  Copyright (c) 2013 Massimiliano Bigatti. All rights reserved.
//

#import "BMXViewController.h"
#import "BMXSwitch.h"

@interface BMXViewController ()

@end

@implementation BMXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_switch1 setCanvasImage: [UIImage imageNamed: @"canvas"]];
    [_switch1 setMaskImage: [UIImage imageNamed: @"mask"]];
    
    [_switch1 setKnobImage: [UIImage imageNamed: @"knob-normal"] forState: UIControlStateNormal];
    [_switch1 setKnobImage: [UIImage imageNamed: @"knob-high"] forState: UIControlStateHighlighted];
    [_switch1 setKnobImage: [UIImage imageNamed: @"knob-disabled"] forState: UIControlStateDisabled];
    
    [_switch1 setContentImage: [UIImage imageNamed: @"content-normal"] forState: UIControlStateNormal];
    [_switch1 setContentImage: [UIImage imageNamed: @"content-disabled"] forState: UIControlStateDisabled];
    
    [self valueChanged: nil];
//    _switch1.on = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(BMXSwitch *)sender
{
    _label.text = [NSString stringWithFormat: @"The switch is %@", (_switch1.on ? @"ON" : @"OFF") ];
}

- (IBAction)buttonTouched:(UIButton *)sender
{
    _switch1.enabled = !_switch1.enabled;
    NSString *title = _switch1.enabled ? @"Disable" : @"Enable";
    [sender setTitle: title forState: UIControlStateNormal];
}

@end
