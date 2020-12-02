//
//  SignInVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user = UserDefultsManger.shared.getUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ProfileVC" ) as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToSignUpVC(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SignUpVC" ) as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        goToSignUpVC()
    }

    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if isVaildData() {
            if isValidEmail(email: emailTextField.text) {
                if isUserDataVaild() {
                    goToProfileVC()
                }
            }
        }
    }
}
