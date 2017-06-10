//
//  BasedViewAnimation.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import Reusable
class BasedViewAnimation: UIView, NibOwnerLoadable {
  
  var runningAnimators: [UIViewPropertyAnimator] = []
  
  @IBOutlet var control: UIView!
  @IBOutlet var guideline: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.loadNibContent()
    self.commonInit()
  }
  
  @IBAction func handleTap(recognizer: UITapGestureRecognizer) {}
  
  
  @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {}
  
  private func commonInit() {
    self.control.layer.cornerRadius = 30
  }
}
