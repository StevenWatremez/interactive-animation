//
//  SimpleAnimationView.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class SimpleAnimationView: BasedViewAnimation {
  override func handleTap(recognizer: UITapGestureRecognizer) {
    UIView.animate(withDuration: 2) {
      self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
    }
  }
}
