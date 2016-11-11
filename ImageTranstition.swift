//
//  ImageTranstition.swift
//  week5Lab_tinder
//
//  Created by user on 11/10/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class ImageTranstition: BaseTransition {
    
    
    var originalCardsImageViewFrame: CGRect!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
   
        
        let profileViewController = toViewController as! CardsProfileViewController
        let profileImageView = profileViewController.profilePhotoImage
        originalCardsImageViewFrame = profileImageView!.frame

        
        let cardsViewController = fromViewController as! CardsViewController
        let cardsImageView = cardsViewController.mainPhoto
        
        profileImageView!.frame = (cardsImageView!.frame)

        
        UIView.animate(withDuration: duration, animations: {
            profileImageView!.frame = self.originalCardsImageViewFrame
            
            

            
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let profileViewController = fromViewController as! CardsProfileViewController
        let profileImageView = profileViewController.profilePhotoImage
        originalCardsImageViewFrame = profileImageView!.frame
        
        
        let cardsViewController = toViewController as! CardsViewController
        let cardsImageView = cardsViewController.mainPhoto
        
        
        profileImageView!.frame = self.originalCardsImageViewFrame

        UIView.animate(withDuration: duration, animations: {
            profileImageView!.frame = (cardsImageView!.frame)

            
            
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    

}
