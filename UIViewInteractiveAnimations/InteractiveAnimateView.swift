//
//  InteractiveAnimateView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class InteractiveAnimateView: BasedViewAnimation {
  
  override func handlePan(recognizer: UIPanGestureRecognizer) {
    switch recognizer.state {
    case .began:
      let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut, animations: {
        self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
      })
      animator.pauseAnimation()
      runningAnimators.append(animator)
    case .changed:
      let translation = recognizer.translation(in: self.control)
      for animator in self.runningAnimators {
        animator.fractionComplete = translation.x / 100
      }
    case .ended:
      for animator in self.runningAnimators {
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
      }
    case .possible: break
    case .cancelled: break
    case .failed: break
    }
  }
}
