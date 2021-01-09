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
        signInTapped()
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
    private func isUserDataVaild(user: User) -> Bool {
        guard emailTextField.text == user.email, passwordTextField.text == user.password else {
            self.showAlert(title: "Error", message: "Invalid Email & Password")
            return false
        }
        return true
    }
    private func goToMediaVC(){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let mediaListVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.mediaListVC ) as! MediaListVC
        self.navigationController?.pushViewController(mediaListVC, animated: true)
    }
    private func goToSignUpVC(){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.signUpVC ) as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    private func signInTapped(){
        if isVaildData() {
            if isValidEmail(email: emailTextField.text) && isValidPassword(testStr: passwordTextField.text){
                let user = SQLiteManger.shared().getUserFromDB(email: emailTextField.text!)
                if isUserDataVaild(user: user!) {
                    UserDefultsManger.shared().email = emailTextField.text!
                    goToMediaVC()
                }
            }
        }
    }
}
