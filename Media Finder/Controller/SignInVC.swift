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
    
    // MARK: - Variables.

    var user: User!
    let email = UserDefultsManger.shared().email
    
    // MARK: - LifeCycle Functions.

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        SQLiteManger.shared().setDatabaseTable(tableName: SQL.usersTable)
//        users = SQLiteManger.shared().getUsersFromDB()
        user = SQLiteManger.shared().getUserFromDB(email: email)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - VC Functions.

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
           guard emailTextField.text == user.email, passwordTextField.text == user.password else {
               self.showAlert(title: "Error", message: "Invalid Email & Password")
               return false
           }
           return true
    }
    
    private func goToMediaListVC(){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.mediaListVC ) as! MediaListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToSignUpVC(){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.signUpVC ) as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Functions.

    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        goToSignUpVC()
    }

    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if isVaildData() {
            if isValidEmail(email: emailTextField.text) {
                if isUserDataVaild() {
                    goToMediaListVC()
                }
            }
        }
    }
}
