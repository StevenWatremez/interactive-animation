//
//  MulitpleAnimationView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 11/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class MultipleAnimateView: BasedViewAnimation {
  
  private enum Constants {
    static let duration = 0.5
    static let lowFractionComplete: CGFloat = 0.4
    static let dampingRatio: CGFloat = 1
    static let numberOfRotation = 3
  }
  
  // Tracks all running animators
  private var runningAnimators = [UIViewPropertyAnimator]()
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
    case .began: self.panBegan()
    case .changed: self.panChanged(recognizer: recognizer)
    case .ended: self.continueInteractiveTransition(cancel: true)
    case .cancelled, .failed, .possible: self.reverseAnimation()
    }
  }
  
  // Perform all animations with animators if not already running
  private func animateTransitionIfNeeded(state: State, duration: TimeInterval) {
    let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: Constants.dampingRatio) {
      switch state {
      case .right: self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
      case .left: self.control.frame = self.control.frame.offsetBy(dx: -self.guideline.frame.width, dy: 0)
      }
    }
    frameAnimator.pauseAnimation()
    self.runningAnimators.append(frameAnimator)
    
    let rotationAnimator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeInOut) {
      for _ in 0...Constants.numberOfRotation {
        let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.control.transform = self.control.transform.concatenating(rotation)
      }
    }
    rotationAnimator.pauseAnimation()
    self.runningAnimators.append(rotationAnimator)
  }
  
  private func panBegan() {
    let state: State = self.isReverse ? .left : .right
    self.startInteractiveTransition(state: state, duration: Constants.duration)
  }
  
  private func panChanged(recognizer: UIPanGestureRecognizer) {
    let translation = recognizer.translation(in: self.control)
    // calcul the fraction complete along the guideline
    self.fractionComplete = translation.x / self.guideline.frame.width
    // Manage reversability for translation
    self.updateInteractiveTransition(fractionComplete: self.fractionComplete)
  }
  
  // Starts transition if necessary and pauses on pan .begin
  private func startInteractiveTransition(state: State, duration: TimeInterval) {
    if self.runningAnimators.isEmpty {
      self.animateTransitionIfNeeded(state: state, duration: duration)
    }
  }
  
  // Scrubs transition on pan .changed
  private func updateInteractiveTransition(fractionComplete: CGFloat) {
    for animator in self.runningAnimators {
      animator.fractionComplete = self.isReverse ? -self.fractionComplete : self.fractionComplete
    }
  }
  
  // Continues or reverse transition on pan .ended
  private func continueInteractiveTransition(cancel: Bool) {
    
    // Manage reverse animation if the fraction complete < 0.25
    if abs(self.fractionComplete) > Constants.lowFractionComplete {
      for animator in runningAnimators {
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
      }
      self.isReverse = !self.isReverse
    } else {
      for animator in runningAnimators {
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        animator.isReversed = !animator.isReversed
      }
    }
    // remove all when animation ended
    self.runningAnimators.removeAll()
  }
  
  private func reverseAnimation() {
    for animator in self.runningAnimators {
      animator.isReversed = !animator.isReversed
    }
  }
}
