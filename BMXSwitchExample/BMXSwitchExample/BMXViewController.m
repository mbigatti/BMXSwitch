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

    id appearance = [BMXSwitch appearance];
    [appearance setCanvasImage: [UIImage imageNamed: @"canvas"]];
    [appearance setMaskImage: [UIImage imageNamed: @"mask"]];
    
    [appearance setContentImage: [UIImage imageNamed: @"content-normal"] forState: UIControlStateNormal];
    [appearance setContentImage: [UIImage imageNamed: @"content-disabled"] forState: UIControlStateDisabled];
    
    [appearance setKnobImage: [UIImage imageNamed: @"knob-normal"] forState: UIControlStateNormal];
    [appearance setKnobImage: [UIImage imageNamed: @"knob-high"] forState: UIControlStateHighlighted];
    [appearance setKnobImage: [UIImage imageNamed: @"knob-disabled"] forState: UIControlStateDisabled];
    
    [self valueChanged: nil];
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
