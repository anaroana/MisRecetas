//
//  ReviewViewController.swift
//  MisRecetas
//
//  Created by Ana Rocha on 15/12/17.
//  Copyright © 2017 Kite. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backGroundImageView: UIImageView!
    
    @IBOutlet var ratingStackView: UIStackView!
    
    var ratingSelected: String?
    
    @IBOutlet var firstButton: UIButton!
    
    @IBOutlet var secondButton: UIButton!
    
    @IBOutlet var thirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //crear un efecto encima de la imagen, como un vidrio
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backGroundImageView.addSubview(blurEffectView)
        
        
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform(translationX: 0.0, y: 500.0)
        //let rotation = CGAffineTransform(rotationAngle: 360 * CGFloat.pi/180)
        firstButton.transform = scale.concatenating(translation) //combinar escalado con traslacion
        secondButton.transform = scale.concatenating(translation)
        thirdButton.transform = scale.concatenating(translation)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
        UIView.animate(withDuration: 5, delay: 0.0, options: [], animations: {
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let rotate = CGAffineTransform(rotationAngle: 350 * CGFloat.pi/180)
            self.ratingStackView.transform = rotate//scale.concatenating(rotate)
            //self.ratingStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
           
        }, completion: nil)
        */

        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.firstButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (succes) in
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                    animations: {
                        self.secondButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: { (succes) in
                        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                            animations: {
                                self.thirdButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                            }, completion: nil)
                    })
            })
 
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
            case 1:
                ratingSelected = "dislike"
            case 2:
                ratingSelected = "good"
            case 3:
                ratingSelected = "great"
            default:
                break
        }
        //forzar un segue hacia atras
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
