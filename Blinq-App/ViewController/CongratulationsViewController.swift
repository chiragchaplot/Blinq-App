//
//  CongratulationsViewController.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation
import UIKit
import Lottie

class CongratulationsViewController: UIViewController {
    lazy var backgroundAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private func showAnimation() {
        view.addSubview(backgroundAnimationView)
        backgroundAnimationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundAnimationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundAnimationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        backgroundAnimationView.animation = Animation.named("confetti")
        backgroundAnimationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: {
            finished in
            
            if finished {
                //Animation Ended
            } else {
                //Animation Stopped
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGround()
        addNavigationBar()
        showAnimation()
    }
    
    private func setUpBackGround() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = []
        gradientLayer.colors = [#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        view.layer.addSublayer(gradientLayer)
    }
    
    func addNavigationBar() {
        self.title = "Invitation Booked"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissStopsNearAddressViewController))
    }
    
    @objc private func dismissStopsNearAddressViewController() {
        dismiss(animated: true, completion: nil)
    }
}
