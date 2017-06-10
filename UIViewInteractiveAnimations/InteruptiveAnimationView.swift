//
//  InteruptiveAnimationView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class InteruptiveAnimationView: BasedViewAnimation {
  
  var animator: UIViewPropertyAnimator!
  var progressWhenInterrupted: CGFloat = 0
  
  override func handleTap(recognizer: UITapGestureRecognizer) {
    self.animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
      self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
    }
    self.animator.startAnimation()
  }
  
  override func handlePan(recognizer: UIPanGestureRecognizer) {
    switch recognizer.state {
    case .began:
      self.progressWhenInterrupted = self.animator.fractionComplete
    case .changed:
      let translation = recognizer.translation(in: self.control)
      let fractionComplete = (translation.x / self.guideline.frame.width) + self.progressWhenInterrupted
      print("translation : \(translation)")
      print("fractionComplete : \(fractionComplete)")
      self.animator.fractionComplete = fractionComplete
    case .ended:
      let timing = UICubicTimingParameters(animationCurve: .easeOut)
      self.animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
    case .cancelled, .failed, .possible: self.animator.isReversed = !self.animator.isReversed
    }
  }
}
