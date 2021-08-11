//
//  ViewController.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    lazy var backgroundAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    lazy var fullNameTextField : CustomTextField  = {
        var fullNameTextField = CustomTextField()
        fullNameTextField.placeholder = "Please Enter Full Name"
        fullNameTextField.keyboardType = .default
        return fullNameTextField
    }()
    
    lazy var emailAddress : CustomTextField  = {
        var emailAddress = CustomTextField()
        emailAddress.placeholder = "Please Enter Email"
        emailAddress.keyboardType = .emailAddress
        return emailAddress
    }()
    
    lazy var confirmEmailAddress : CustomTextField  = {
        var confirmEmailAddress = CustomTextField()
        confirmEmailAddress.placeholder = "Please Confirm Email"
        confirmEmailAddress.keyboardType = .emailAddress
        return confirmEmailAddress
    }()
    
    lazy var resetButton: CustomButton = {
        var resetButton = CustomButton("Reset")
        resetButton.addTarget(self, action: #selector(resetEverything), for: .touchUpInside)
        return resetButton
    }()
    
    lazy var submitButton: CustomButton = {
        var submitButton = CustomButton("Submit")
        submitButton.addTarget(self, action: #selector(submitDetails), for: .touchUpInside)
        submitButton.isEnabled = false
        return submitButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGround()
        setUpAddElements()
        setUpLayoutOnStart()
    }
    
    @objc
    private func submitDetails(){
        print("Submit Button Pressed")
        backgroundAnimationView.stop()
    }
    
    @objc
    private func resetEverything(){
        print("Reset Button Pressed")
        reset()
        backgroundAnimationView.stop()
    }
    
    private func playBackgroundAnimation() {
        let animation = Animation.named("spacial-broccoli")
        backgroundAnimationView.animation = animation
        backgroundAnimationView.play(fromProgress: 0, toProgress: 1, loopMode: .repeat(2.0), completion: {
            finished in
            
            if finished {
                print("Animation Ended")
            } else  {
                print("Animated Stopped")
            }
        })
    }

    func setUpLayoutOnStart() {
        
        fullNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        fullNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        fullNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        fullNameTextField.becomeFirstResponder()
        fullNameTextField.delegate = self
        
        emailAddress.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 40).isActive = true
        emailAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emailAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        emailAddress.delegate = self
        
        confirmEmailAddress.topAnchor.constraint(equalTo: emailAddress.bottomAnchor, constant: 40).isActive = true
        confirmEmailAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        confirmEmailAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        confirmEmailAddress.returnKeyType = .done
        confirmEmailAddress.delegate = self
        
        resetButton.topAnchor.constraint(equalTo: confirmEmailAddress.bottomAnchor, constant: 40).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: confirmEmailAddress.bottomAnchor, constant: 40).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
    }
    
    private func setUpBackGround() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor, UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setUpAddElements() {
        view.addSubview(fullNameTextField)
        view.addSubview(emailAddress)
        view.addSubview(confirmEmailAddress)
        view.addSubview(submitButton)
        view.addSubview(resetButton)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == fullNameTextField) {
            fullNameTextField.resignFirstResponder()
            emailAddress.becomeFirstResponder()
        } else if (textField == emailAddress) {
            emailAddress.resignFirstResponder()
            confirmEmailAddress.becomeFirstResponder()
        } else {
            confirmEmailAddress.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == confirmEmailAddress) {
            if (confirmEmailAddress.text == emailAddress.text && fullNameTextField.text!.count > 0) {
                submitButton.isEnabled = true
            }
        }
    }
    
    func reset() {
        fullNameTextField.text = ""
        emailAddress.text = ""
        confirmEmailAddress.text = ""
        submitButton.isEnabled = false  
    }
}
