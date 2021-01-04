//
//  SignInVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    // MARK: - Outlets.
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- Properties
    var user = UserDefultsManger.shared().getUserDefaults()
    
    // MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions.
    @IBAction func createAccountBtnTapped(_ sender: UIButton) {
        goToSignUpVC()
    }
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        if isVaildData() {
            if isValidEmail(email: emailTextField.text) {
                if isUserDataVaild() {
                    goToProfileVC()
                }
            }
        }
    }
}

// MARK: - Private Methods.
extension SignInVC {
    private func isVaildData() -> Bool {
        guard (emailTextField.text?.trimmed) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Email")
            return false
        }
        guard (passwordTextField.text) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Password")
            return false
        }
        return true
    }
    private func isUserDataVaild() -> Bool {
        guard emailTextField.text == user?.email, passwordTextField.text == user?.password else {
            self.showAlert(title: "Error", message: "Invalid Email & Password")
            return false
        }
        return true
    }
    private func goToProfileVC(){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let profileVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.profileVC ) as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    private func goToSignUpVC(){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.signUpVC ) as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
