//
//  SVBSoundBars.swift
//  SVBSoundBars
//
//  Created by Sven Bacia on 10/07/15.
//  Copyright © 2015 Sven Bacia. All rights reserved.
//

import UIKit

class SVBSoundBars: UIView {
  
  // MARK: -
  
  private struct Bar {
    let initialHeight: CGFloat
    let shape: CAShapeLayer
    
    init(color: UIColor, initialHeight: CGFloat) {
      self.shape           = CAShapeLayer()
      self.shape.fillColor = color.CGColor
      self.initialHeight   = initialHeight
    }
  }
  
  // MARK: - Variables
  
  private let numberOfBars = 3
  private var bars         = [Bar]()
  private let margin       = CGFloat(1.0)
  private let duration     = 1.0
  
  private let progressAnimation: CAKeyframeAnimation = {
    let progressAnimation = CAKeyframeAnimation(keyPath: "path")
    progressAnimation.keyTimes    = [0, 0.5, 1]
    progressAnimation.additive    = true
    progressAnimation.repeatCount = HUGE
    return progressAnimation
  }()
  
  /// Bar fill color
  @IBInspectable var barColor: UIColor = UIColor.greenColor() {
    didSet {
      for bar in bars {
        bar.shape.fillColor = barColor.CGColor
      }
    }
  }
  
  /// starts / stops the animation
  var animating: Bool = false {
    didSet {
      if animating {
        startProgressAnimation()
      } else {
        stopProgressAnimation()
      }
    }
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: - Setup
  
  private func setup() {
    for _ in 0..<numberOfBars {
      let bar = Bar(color: barColor, initialHeight: CGFloat(arc4random_uniform(50)) / 100.0)
      layer.addSublayer(bar.shape)
      bars.append(bar)
    }
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    for i in 0..<numberOfBars {
      let shape   = bars[i].shape
      shape.frame = completeRectForBarAtIndex(i)
      shape.path  = barPathForRect(initialRectForBarAtIndex(i, initialHeight: bars[i].initialHeight)).CGPath
      
      if animating {
        addProgressAnimationForBarAtIndex(i)
      }
    }
  }
  
  // MARK: - Helper
  
  /// Adds `progressAnimation` to all `bars` which starts the animation.
  private func startProgressAnimation() {
    for i in 0..<bars.count {
      addProgressAnimationForBarAtIndex(i)
    }
  }
  
  /// Adds `progressAnimation` to a specific bar.
  /// - Parameter index: The index of the bar where the animation should be added to.
  private func addProgressAnimationForBarAtIndex(index: Int) {
    let bar = bars[index]
    
    progressAnimation.duration = CFTimeInterval(CGFloat(1.0) - bar.initialHeight) * duration
    progressAnimation.values   = [
      barPathForRect(initialRectForBarAtIndex(index, initialHeight: bar.initialHeight)).CGPath,
      barPathForRect(completeRectForBarAtIndex(index)).CGPath,
      barPathForRect(initialRectForBarAtIndex(index, initialHeight: bar.initialHeight)).CGPath
    ]
    
    bar.shape.addAnimation(progressAnimation, forKey: "progress")
  }
  
  /// Remove `progressAnimation` from all `bars`
  private func stopProgressAnimation() {
    for bar in bars {
      bar.shape.removeAllAnimations()
    }
  }
  
  /// Returns the intial frame for a specific bar with an initial height.
  /// - Parameter index: Index of the bar
  /// - Parameter initialHeight: Initial height of the bar
  /// - Returns: The inital `CGRect`
  private func initialRectForBarAtIndex(index: Int, initialHeight: CGFloat) -> CGRect {
    
    let height = CGRectGetHeight(frame)
    let width  = (CGRectGetWidth(frame) - 2 * margin) / 3.0
    
    return CGRect(x: CGFloat(index) * (width + margin), y: height - height * initialHeight, width: width, height: height * initialHeight)
  }
  
  /// Returns the complete frame for a specific bar.
  /// - Parameter index: The index of the bar
  /// - Returns: The frame of the bar
  private func completeRectForBarAtIndex(index: Int) -> CGRect {
    
    let height = CGRectGetHeight(frame)
    let width  = (CGRectGetWidth(frame) - 2 * margin) / 3.0
    
    return CGRect(x: CGFloat(index) * (width + margin), y: 0, width: width, height: height)
  }
  
  /// Returns a `UIBezierPath` with rounded corners.
  /// - Parameter rect: The rect for the path
  /// - Returns: `UIBezierPath` with rounded corners
  private func barPathForRect(rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: rect.origin.y), size: rect.size), byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii: CGSize(width: 1.0, height: 1.0))
    return path
  }
  
}
