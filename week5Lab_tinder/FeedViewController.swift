//
//  FeedViewController.swift
//  week5Lab_tinder
//
//  Created by user on 11/7/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = true
    
    var selectedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        var tappedImageView = sender.view as! UIImageView
        selectedImageView = tappedImageView
        
        
        performSegue(withIdentifier: "detailSegue", sender: self)
        
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
        
        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        if (isPresenting) {
            var detailViewController = toViewController as! DetailViewController
            
            var movingImage = UIImageView(frame: selectedImageView.frame)
            movingImage.contentMode = selectedImageView.contentMode
            movingImage.clipsToBounds = selectedImageView.clipsToBounds
            movingImage.image = selectedImageView.image
            selectedImageView.isHidden = true
            
            var window = UIApplication.shared.keyWindow
            window?.addSubview(movingImage)
            detailViewController.imageView.isHidden = true
            
            containerView.addSubview((toViewController?.view)!)
            toViewController?.view.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, animations: {
                toViewController?.view.alpha = 1
                movingImage.frame = detailViewController.imageView.frame
                movingImage.contentMode = detailViewController.imageView.contentMode
            }, completion: { (Bool) -> Void in
                transitionContext.completeTransition(true)
                movingImage.removeFromSuperview()
                detailViewController.imageView.isHidden = false
            })
            
        } else {
            var detailViewController = fromViewController as! DetailViewController
            var movingImage = UIImageView(frame: detailViewController.imageView.frame)
            movingImage.contentMode = detailViewController.imageView.contentMode
            movingImage.clipsToBounds = detailViewController.imageView.clipsToBounds
            movingImage.image = detailViewController.imageView.image
            
            
            selectedImageView.isHidden = true
            
            
            
            fromViewController?.view.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                fromViewController?.view.alpha = 0
                fromViewController?.view.removeFromSuperview()

                movingImage.frame = self.selectedImageView.frame
                movingImage.contentMode = self.selectedImageView.contentMode
                var window = UIApplication.shared.keyWindow
                window?.addSubview(movingImage)
                
                
                
                
            }, completion: { (Bool) -> Void in
                transitionContext.completeTransition(true)
                movingImage.removeFromSuperview()
                
                self.selectedImageView.isHidden = false
                
                
                
                
                
            })
            
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailViewController
        destinationViewController.image = selectedImageView.image
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        destinationViewController.transitioningDelegate = self
        
    }
    
}
