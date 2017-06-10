//
//  InteractiveAnimateView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class InteractiveAnimateView: BasedViewAnimation {
  
  private enum Constants {
    static let duration = 0.3
    static let lowFractionComplete: CGFloat = 0.4
  }
  
  private var animator: UIViewPropertyAnimator!
  private var isReverse: Bool = false
  private var fractionComplete: CGFloat = 0
  
  /// State is to define the way of the animation.
  private enum State {
    case right
    case left
  }
  
  // The note is you need to define the way of your animation — and — reverse the animator if needed.
  // But you need to manage the two previous variables properly if you want to handle the animation corretly.
  override func handlePan(recognizer: UIPanGestureRecognizer) {
    
    switch recognizer.state {
    case .began:
      let state: State = self.isReverse ? .left : .right
      self.animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .linear) {
        // We need to manage state of the animation
        switch state {
        case .right: self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
        case .left: self.control.frame = self.control.frame.offsetBy(dx: -self.guideline.frame.width, dy: 0)
        }
      }
      // launch pause animation to prepare animation workflow but let pan gesture manipule the fraction Complete in .changed
      self.animator.pauseAnimation()
    case .changed:
      let translation = recognizer.translation(in: self.control)
      // calcul the fraction complete along the guideline
      self.fractionComplete = translation.x / self.guideline.frame.width
      // Manage reversability for translation
      self.animator.fractionComplete = self.isReverse ? -self.fractionComplete : self.fractionComplete
    case .ended:
      self.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
      // Manage reverse animation if the fraction complete < 0.25
      if abs(self.fractionComplete) > Constants.lowFractionComplete {
        self.isReverse = !self.isReverse
      } else {
        self.animator.isReversed = !self.animator.isReversed
      }
    case .cancelled, .failed, .possible: self.animator.isReversed = !self.animator.isReversed
    }
  }
}
