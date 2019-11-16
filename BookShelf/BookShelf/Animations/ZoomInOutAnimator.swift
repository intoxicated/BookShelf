//
//  ZoomInOutAnimator.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

protocol ZoomInOutAnimatable {
   var targetView: UIView? { get }
}

class ZoomInOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  var transitionDuration: TimeInterval = 0.25
  var isPresenting: Bool = false

  func transitionDuration(using: UIViewControllerContextTransitioning?) -> TimeInterval {
    return self.transitionDuration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView

    guard
      let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to) else {
      transitionContext.completeTransition(false)
      return
    }

    //necessary to know final frame before-hand
    toVC.view.setNeedsLayout()
    toVC.view.layoutIfNeeded()
    
    guard
      let fromTargetView = targetView(in: fromVC),
      let toTargetView = targetView(in: toVC) else {
      transitionContext.completeTransition(false)
      return
    }

    guard
      let fromImage = fromTargetView.caSnapshot() else {
      transitionContext.completeTransition(false)
      return
    }

    let targetImageView = UIImageView(image: fromImage)

    let startFrame = fromTargetView.frameIn(containerView)
    let endFrame = toTargetView.frameIn(containerView)

    targetImageView.frame = startFrame

    fromTargetView.isHidden = true
    toTargetView.isHidden = true

    guard let toView = transitionContext.view(forKey: .to) else {
      transitionContext.completeTransition(false)
      assertionFailure()
      return
    }
    containerView.addSubview(toView)
    containerView.addSubview(targetImageView)
    toView.frame = CGRect(
      origin: toVC.view.frame.origin,
      size: containerView.bounds.size
    )
    toView.alpha = 0

    UIView.animate(
      withDuration: transitionDuration,
      delay: 0,
      options: isPresenting ? .curveEaseIn : .curveEaseOut,
      animations: {
        toView.alpha = 1
        targetImageView.frame = endFrame
      },
      completion: { _ in
        let success = !transitionContext.transitionWasCancelled
        if !success {
          toView.removeFromSuperview()
        }
        fromTargetView.isHidden = false
        toTargetView.isHidden = false
        targetImageView.removeFromSuperview()
        transitionContext.completeTransition(success)
      }
    )
  }
}

extension ZoomInOutAnimator {
  private func targetView(in viewController: UIViewController) -> UIView? {
    if let view = (viewController as? ZoomInOutAnimatable)?.targetView {
      return view
    }
    if let nc = viewController as? UINavigationController, let vc = nc.topViewController,
      let view = (vc as? ZoomInOutAnimatable)?.targetView {
      return view
    }
    return nil
  }
}
