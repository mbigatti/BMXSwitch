## BMXSwitch

An image based replacement for UISwitch that allows to configure each element of the view.

![Screenshot](https://github.com/mbigatti/BMXSwitch/raw/master/screenshot.png)

It allows to fully stylize the appearance of the control with your artwork, for example:

![TimerApp](https://github.com/mbigatti/BMXSwitch/raw/master/timerapp.png)

The switch is composed overlaying some images:

![Diagram](https://github.com/mbigatti/BMXSwitch/raw/master/diagram.png)


## Installation

To use BMXSwitch:

- Copy over the `BMXSwitch` folder to your project folder.
- Make sure that your project includes the QuartzCore.framework.
- `#import "BMXSwitch.h"`
- `#import "BMXSwitchLayer.h"`

### Example Code

```objective-c
BMXSwitch *switch1 = [[BMXSwitch alloc] initWithFrame: frame];

[switch1 setCanvasImage: [UIImage imageNamed: @"canvas"]];
[switch1 setMaskImage: [UIImage imageNamed: @"mask"]];
    
[switch1 setKnobImage: [UIImage imageNamed: @"knob-normal"] forState: UIControlStateNormal];
[switch1 setKnobImage: [UIImage imageNamed: @"knob-high"] forState: UIControlStateHighlighted];
[switch1 setKnobImage: [UIImage imageNamed: @"knob-disabled"] forState: UIControlStateDisabled];
    
[switch1 setContentImage: [UIImage imageNamed: @"content-normal"] forState: UIControlStateNormal];
[switch1 setContentImage: [UIImage imageNamed: @"content-disabled"] forState: UIControlStateDisabled];
```

## Notes

- iOS5.0+
- ARC

## Contact

- [Personal website](http://bigatti.it)
- [GitHub](https://github.com/mbigatti)
- [Twitter](https://twitter.com/mbigatti)

## License

### MIT License
Copyright (c) 2013 Massimiliano Bigatti (http://bigatti.it)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
