## BMXSwitch

An image based replacement for UISwitch that allows to configure each element of the view.

![Screenshot](https://github.com/mbigatti/BMXSwitch/raw/master/screenshot.png)

The switch is composed overlaying few images

![Schema](https://github.com/mbigatti/BMXSwitch/raw/master/schema.png)


## Installation

To use BMXSwitch:

- Copy over the `BMXSwitch` folder to your project folder.
- Make sure that your project includes the QuartzCore.framework.
- `#import "BMXSwitch.h"`

### Example Code

```objective-c
BMXSwitch *switch1 = [[BMXSwitch alloc] initWithFrame: frame];

id appearance = [BMXSwitch appearance];
[appearance setCanvasImage: [UIImage imageNamed: @"canvas"]];
[appearance setMaskImage: [UIImage imageNamed: @"mask"]];
    
[appearance setContentImage: [UIImage imageNamed: @"content-normal"] forState: UIControlStateNormal];
[appearance setContentImage: [UIImage imageNamed: @"content-disabled"] forState: UIControlStateDisabled];
    
[appearance setKnobImage: [UIImage imageNamed: @"knob-normal"] forState: UIControlStateNormal];
[appearance setKnobImage: [UIImage imageNamed: @"knob-high"] forState: UIControlStateHighlighted];
[appearance setKnobImage: [UIImage imageNamed: @"knob-disabled"] forState: UIControlStateDisabled];
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
