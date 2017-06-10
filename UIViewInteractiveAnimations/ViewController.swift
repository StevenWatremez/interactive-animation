//
//  ViewController.swift
//  UIViewInteractiveAnimations
//
//  Created by Steven_WATREMEZ on 10/06/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private var control: UIView!
  @IBOutlet private var guideline: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupSubviews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //    self.setupAnimations()
  }
  
  private func setupSubviews() {
    self.control.layer.cornerRadius = 30
  }
  
  // UIView based animation
  @IBAction private func handleTap(recognizer: UITapGestureRecognizer) {
    
  }
  //  private func setupAnimations() {
  //    UIView.animate(withDuration: 5) {
  //      self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
  //    }
  //  }
  
  // UIViewPropertyAnimator
  // Custom timing
  //  private func setupAnimations() {
  //    let controlPoint1 = CGPoint(x: 0.75, y: 0.1)
  //    let controlPoint2 = CGPoint(x: 0.9, y: 0.25)
  //    let animator = UIViewPropertyAnimator(duration: 2.5, controlPoint1: controlPoint1, controlPoint2: controlPoint2) {
  //      self.control.frame = self.control.frame.offsetBy(dx: self.guideline.frame.width, dy: 0)
  //    }
  //    animator.startAnimation()
  //  }
  
  // UIViewPropertyAnimator
  // Interactive
  var runningAnimators = [UIViewPropertyAnimator]()
  @IBAction private func handlePan(recognizer: UIPanGestureRecognizer) {
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
  
  // UIViewPropertyAnimator
  // Interruptible
  //  private func setupAnimations() {
  //
  //  }
  
  // UIViewPropertyAnimator
  // Responsive
  //  private func setupAnimations() {
  //
  //  }
  
  // UIViewPropertyAnimator
  // Reversible
  private func animateOrReverseRunningTransition(duration: TimeInterval) {
    if runningAnimators.isEmpty {
      self.animateTransitionIfNeeded(duration: duration)
    } else {
      for animator in runningAnimators {
        animator.isReversed = !animator.isReversed
      }
    }
  }
  
  
  private func animateTransitionIfNeeded(duration: TimeInterval) {
    
  }
}

protocol Animate {
  var control: UIView! { get }
  var guideline: UIView! { get }
  var runningAnimators: [UIViewPropertyAnimator] { get set }
  func handleTap(recognizer: UITapGestureRecognizer)
  func handlePan(recognizer: UIPanGestureRecognizer)
}

final class BasedViewAnimation: UIView, Animate {
  
  @IBOutlet var control: UIView!
  @IBOutlet var guideline: UIView!
  
  var runningAnimators: [UIViewPropertyAnimator] = []
  
  @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
    <#code#>
  }
  
  @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
    <#code#>
  }
}
