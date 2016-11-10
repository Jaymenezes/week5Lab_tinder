//
//  GreyViewController.swift
//  week5Lab_tinder
//
//  Created by user on 11/7/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class GreyViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = true
    var fadeTransition: FadeTransition!
    var blackView: UIView!
    var interactiveTransition: UIPercentDrivenInteractiveTransition!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        interactiveTransition = UIPercentDrivenInteractiveTransition()
        
        return interactiveTransition
        
    }

    
    func animationController(forPresented presented: UIViewController!, presenting: UIViewController!, source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("animating transition")

        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        if (isPresenting) {
            
            blackView = UIView(frame: (fromViewController?.view.frame)!)

            blackView.backgroundColor = UIColor.black
            
            blackView.alpha = 0
            containerView.addSubview(blackView)
            containerView.addSubview((toViewController?.view)!)
            toViewController?.view.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.4

                toViewController?.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { (Bool) -> Void in
          transitionContext.completeTransition(true)
        })
        
        } else {
            blackView.alpha = 0
            fromViewController?.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.5, animations: {
                

                fromViewController?.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController?.view.removeFromSuperview()
                self.blackView.removeFromSuperview()


            })

            
        }
    }
    
 
    @IBAction func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        var scale = sender.scale
        var velocity = sender.velocity
        
        
        
        if sender.state == .began {
            performSegue(withIdentifier: "pinchSegue", sender: self)
            
            
        } else if sender.state == .changed {
            interactiveTransition.update(scale / 7)
                
            
            
        } else if sender.state == .ended {
            if velocity > 0 {
            interactiveTransition.finish()
            } else {
                interactiveTransition.cancel()

                
            }

            
        }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     let destinationViewController = segue.destination
     
     
     destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
     
     fadeTransition = FadeTransition()
     
     
     destinationViewController.transitioningDelegate = self
     
     fadeTransition.duration = 1.0
        
     print("fadeIn called")
     }

    

}
