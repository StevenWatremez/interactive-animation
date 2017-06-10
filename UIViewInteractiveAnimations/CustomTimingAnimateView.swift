//
//  CustomTimingAnimateView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class CustomTimingAnimateView: BasedViewAnimation {
  override func handleTap(recognizer: UITapGestureRecognizer) {
    let controlPoint1 = CGPoint(x: 0.75, y: 0.1)
    let controlPoint2 = CGPoint(x: 0.9, y: 0.25)
    let animator = UIViewPropertyAnimator(duration: 2, controlPoint1: controlPoint1, controlPoint2: controlPoint2) {
      self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
    }
    animator.startAnimation()
  }
}
