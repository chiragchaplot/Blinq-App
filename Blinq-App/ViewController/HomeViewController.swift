//
//  ViewController.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    var homeVM = HomeViewModel()
    
    lazy var backgroundAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.tag = 100
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
    
    lazy var cancelButton: CustomButton = {
        var button = CustomButton("Cancel Invite")
        button.addTarget(self, action: #selector(cancelInvite), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGround()
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "inviteRequested") {
            setUpFilled()
        } else {
            setUpEmpty()
        }
        
    }
    
    @objc
    private func submitDetails(){
        print("Submit Button Pressed")
        showAnimation()
        let param = ["name":fullNameTextField.text, "email":emailAddress.text]
        homeVM.submitInvitation(param: param as [String : Any], completion: {
            (result, error) in
//            self.stopAnimation()
            if let _ = error {
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    let alert = UIAlertController(title: "Error", message: defaults.value(forKey: "error") as! String, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if let _ = result  {
                DispatchQueue.main.async {
                    self.setUpUserDefault()
                    let rootVC = CongratulationsViewController()
                    let navVC = UINavigationController(rootViewController: rootVC)
                    navVC.modalPresentationStyle = .popover
                    self.present(navVC,animated: true,completion: {
                        self.changeView()
                    })
                    
                }
            }
        })
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
        fullNameTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
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
    
    private func showAnimation() {
        view.addSubview(backgroundAnimationView)
        backgroundAnimationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundAnimationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundAnimationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundAnimationView.animation = Animation.named("spacial-broccoli")
        backgroundAnimationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    private func stopAnimation() {
        backgroundAnimationView.stop()
        backgroundAnimationView.removeFromSuperview()
    }
    
    func setUpUserDefault() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "inviteRequested")
        defaults.setValue(fullNameTextField.text, forKey: "fullName")
        defaults.setValue(emailAddress.text, forKey: "email")
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
            if (confirmEmailAddress.text?.uppercased() == emailAddress.text?.uppercased() && fullNameTextField.text!.count > 3 ) {
                guard let emailCheck = emailAddress.text else { return }
                if isValidEmail(email: emailCheck) {
                    submitButton.isEnabled = true
                }
            }
        }
    }
    
    func reset() {
        fullNameTextField.text = ""
        emailAddress.text = ""
        confirmEmailAddress.text = ""
        submitButton.isEnabled = false  
    }
    
    func setUpEmpty() {
        setUpAddElements()
        setUpLayoutOnStart()
        enableTextFields()
    }
    
    func enableTextFields() {
        fullNameTextField.text = ""
        fullNameTextField.isEnabled = true
        
        emailAddress.text = ""
        emailAddress.isEnabled = true
        
        confirmEmailAddress.text = ""
        confirmEmailAddress.isEnabled = true
    }
}

// MARK: - Layout When User Registered
extension HomeViewController {
    
    
    private func changeView() {
        removeElements()
        setUpFilled()
    }
    
    private func setUpFilled() {
        addNewElements()
        disableTextFields()
        setUpLayout_Filled()
    }
    
    private func removeElements() {
        backgroundAnimationView.removeFromSuperview()
        resetButton.removeFromSuperview()
        submitButton.removeFromSuperview()
        confirmEmailAddress.removeFromSuperview()
        fullNameTextField.removeFromSuperview()
        emailAddress.removeFromSuperview()
    }
    
    private func disableTextFields() {
        emailAddress.isEnabled = false
        fullNameTextField.isEnabled = false
    }
    
    private func addNewElements() {
        view.addSubview(fullNameTextField)
        view.addSubview(emailAddress)
        view.addSubview(cancelButton)
    }
    
    private func setUpLayout_Filled() {
        let defaults = UserDefaults.standard
        fullNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        fullNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        fullNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        fullNameTextField.text = defaults.string(forKey: "fullName")
        
        
        emailAddress.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 40).isActive = true
        emailAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emailAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        emailAddress.text = defaults.string(forKey: "email")

        
        
        cancelButton.topAnchor.constraint(equalTo: emailAddress.bottomAnchor, constant: 40).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        cancelButton.backgroundColor = .black
    }
    
    @objc private func cancelInvite() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "inviteRequested")
        removeRegisteredScreen()
        showByeByeScreen()
        
    }
    
    func removeRegisteredScreen() {
        fullNameTextField.removeFromSuperview()
        emailAddress.removeFromSuperview()
        cancelButton.removeFromSuperview()
    }
    
    func showByeByeScreen() {
        let rootVC = RegistrationCancelledViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .popover
        self.present(navVC,animated: true,completion: {
            self.removeRegisteredScreen()
            self.setUpEmpty()
        })
    }
}
