# SVBSoundBars
SVBSoundBars is a `UIView` subclass which displays a custom amount of moving bars which indicate that your app is currently playing some kind of music like in the iOS 7-8 Music.app.
SVBSoundBars is implemented by using `CAShapeLayer`.

![SVBSoundBars Preview][animation]

## Requirements
* iOS 9
* Swift 2.0

## Installation
Clone this repo and copy `SVBSoundBars.swift` into your project

## Getting Started
1. Add `SVBSoundBars` to your view either by adding it in your Storyboard or directly in code
2. Customize `SVBSoundBars` for your needs (see Attributes)
3. Call `startProgressAnimation()` to start the animation

## Attributes
* `numberOfBars`: The number of bars displayed in your `SVBSoundBars` view
* `margin`: the spacing between each bar
* `duration`: the duration for a complete animation cycle (animating the bars from their initial position the their complete state and back to the initial position).
* `barColor`: the fill color of the bars

## License
`SVBSoundbars` is released under an MIT License.

[animation]: Assets/SoundBars.gif
