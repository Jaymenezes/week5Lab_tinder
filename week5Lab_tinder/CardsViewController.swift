//
//  CardsViewController.swift
//  week5Lab_tinder
//
//  Created by user on 11/8/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardInitialCenter: CGPoint!
    var cardOriginalCenter: CGPoint!
    
    
    @IBOutlet weak var mainPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardOriginalCenter = CGPoint(x: mainPhoto.center.x, y: mainPhoto.center.y)
        mainPhoto.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMainPhoto(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        
        let rotation = convertValue(inputValue: CGFloat(translation.x), r1Min: 0, r1Max: 450, r2Min: 0, r2Max: CGFloat(45 * M_PI / 180))
        let negativeRotation = convertValue(inputValue: CGFloat(translation.x), r1Min: 0, r1Max: -450, r2Min: 0, r2Max: CGFloat(-45 * M_PI / 180))
        
        let lowerrotation = convertValue(inputValue: CGFloat(translation.x), r1Min: 0, r1Max: 450, r2Min: 0, r2Max: CGFloat(-45 * M_PI / 180))
        let lowerNegativeRotation = convertValue(inputValue: CGFloat(translation.x), r1Min: 0, r1Max: -450, r2Min: 0, r2Max: CGFloat(45 * M_PI / 180))
        
        //        archiveImageView.alpha = opacity
        
        
        //        mainPhoto.center = translation
        
        
        
        
        if sender.state == .began {
            cardInitialCenter = mainPhoto.center
            
        } else if sender.state == .changed {
            if location.y < 330 {
            if translation.x > 0 {
                mainPhoto.center = CGPoint(x: translation.x + cardInitialCenter.x, y: cardInitialCenter.y)
                mainPhoto.transform = CGAffineTransform(rotationAngle: rotation)
                
            } else if translation.x < 0 {
                mainPhoto.center = CGPoint(x: translation.x + cardInitialCenter.x, y: cardInitialCenter.y)
                mainPhoto.transform = CGAffineTransform(rotationAngle: negativeRotation)
                
            }
            } else if location.y > 330 {
                if translation.x > 0 {
                    mainPhoto.center = CGPoint(x: translation.x + cardInitialCenter.x, y: cardInitialCenter.y)
                    mainPhoto.transform = CGAffineTransform(rotationAngle: lowerrotation)
                    
                } else if translation.x < 0 {
                    mainPhoto.center = CGPoint(x: translation.x + cardInitialCenter.x, y: cardInitialCenter.y)
                    mainPhoto.transform = CGAffineTransform(rotationAngle: lowerNegativeRotation)
                    
                }
                
            }
            
        } else if sender.state == .ended {
            
            // panning from the top of the image
            if location.y < 330 {
                //panning to the right
                //restablishing original values
                if translation.x > 0 && translation.x < 50 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.mainPhoto.center = self.cardOriginalCenter
                        self.mainPhoto.transform = CGAffineTransform.identity
                    })
                    
                    //animating off the screen to the right
                } else if translation.x > 50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.mainPhoto.center = CGPoint(x: translation.x + self.cardInitialCenter.x + 375, y: self.cardInitialCenter.y + 150)
                        self.mainPhoto.transform = CGAffineTransform(rotationAngle: rotation)
                    })
                    
                    //panning to the right
                    //restablishing original values
                } else if translation.x < 0 && translation.x > -50 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.mainPhoto.center = self.cardOriginalCenter
                        self.mainPhoto.transform = CGAffineTransform.identity
                    })
                    
                    
                    //animating off the screen to the left
                } else if translation.x < -50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.mainPhoto.center = CGPoint(x: translation.x + self.cardInitialCenter.x - 375, y: self.cardInitialCenter.y + 150)
                        self.mainPhoto.transform = CGAffineTransform(rotationAngle: negativeRotation)
                    })
                }
                
                //panning from the bottom of the image
            } else if location.y > 330 {
                //panning to the right
                //restablishing original values
                if translation.x > 0 && translation.x < 50 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.mainPhoto.center = self.cardOriginalCenter
                        self.mainPhoto.transform = CGAffineTransform.identity
                    })
                    
                    //animating off the screen to the right
                } else if translation.x > 50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.mainPhoto.center = CGPoint(x: translation.x + self.cardInitialCenter.x + 375, y: self.cardInitialCenter.y - 150)
                        self.mainPhoto.transform = CGAffineTransform(rotationAngle: lowerrotation)
                    })
                    
                    
                    //panning to the right
                    //restablishing original values
                } else if translation.x < 0 && translation.x > -50 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.mainPhoto.center = self.cardOriginalCenter
                        self.mainPhoto.transform = CGAffineTransform.identity
                    })
                    
                    
                    //animating off the screen to the left
                } else if translation.x < -50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.mainPhoto.center = CGPoint(x: translation.x + self.cardInitialCenter.x - 375, y: self.cardInitialCenter.y - 150)
                        self.mainPhoto.transform = CGAffineTransform(rotationAngle: lowerNegativeRotation)
                    })
                }
                
                
                
            }
            
        }
    }
    
    @IBAction func didTapSegue(_ sender: UITapGestureRecognizer) {
        var tappedImageView = sender.view as! UIImageView
        mainPhoto = tappedImageView
        
        performSegue(withIdentifier: "profileSegue", sender: self)
        sender.numberOfTapsRequired = 2
    }
    
    
 

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let profileViewController = segue.destination as! CardsProfileViewController
        profileViewController.image = mainPhoto.image
//        profileViewController.modalPresentationStyle = UIModalPresentationStyle.custom
//        profileViewController.transitioningDelegate = self
     }
    
    
}
