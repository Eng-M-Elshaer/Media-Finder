//
//  SignUpVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

class SignUpVC: UITableViewController {
    
    // MARK: - Outlets.

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    @IBOutlet weak var userGenderSwitch: UISwitch!
    @IBOutlet weak var userAddressOneTextField: UITextField!
    @IBOutlet weak var userAddressTwoTextField: UITextField!
    @IBOutlet weak var userAddressThreeTextField: UITextField!
    
    // MARK: - Variables.

    var user:User!
    var gender:Gender = .female
    let imagePicker = UIImagePickerController()
    
    // MARK: - LifeCycle Functions.

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        SQLiteManger.shared().setDatabaseTable(tableName: SQL.usersTable)
        SQLiteManger.shared().createUserTable()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    // MARK: - VC Functions.

    private func goToSignInVC(){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func isVaildData() -> Bool {
        guard (userEmailTextField.text?.trimmed) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Email")
            return false
        }
        guard userImageView.image != UIImage(named: "user") else {
            self.showAlert(title: "Error", message: "Please Choose Photo")
            return false
        }
        guard (userPasswordTextField.text) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Password")
            return false
        }
        guard (userPhoneTextField.text?.trimmed) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Phone")
            return false
        }
        guard (userAddressOneTextField.text?.trimmed) != "" else {
            self.showAlert(title: "Error", message: "Please Enter Address")
            return false
        }
        return true
    }
    
    private func isValidRegax() -> Bool {
        guard isValidEmail(email: userEmailTextField.text?.trimmed) else {
            self.showAlert(title: "Error", message: "Enter Vaild Email")
            return false
        }
        guard isValidPassword(testStr: userPasswordTextField.text) else {
            self.showAlert(title: "Error", message: "Password need to be: \n at least one uppercase \n at least one digit \n at least one lowercase \n 8 characters total")
            return false
        }
        return true
    }
    
    // MARK: - Button Functions.

    @IBAction func userGenderSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            gender = .female
        } else {
            gender = .male
        }
    }
    
    @IBAction func addressBtnPressed(_ sender: UIButton) {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.mapVC) as! MapVC
        vc.delegate = self
        vc.tag = sender.tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func userImageBtnPressed(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if isVaildData() {
            if isValidRegax() {
                user = User(image: CodableImage(withImage: userImageView.image!), name: userNameTextField.text,
                            email: userEmailTextField.text,
                            phone: userPhoneTextField.text, password: userPasswordTextField.text, gender: gender,
                            addressOne: userAddressOneTextField.text, addressTwo: userAddressTwoTextField.text,
                            addressThree: userAddressThreeTextField.text)
                UserDefultsManger.shared().email = userEmailTextField.text!
                let userData = Coder.encodUser(user: user)
                SQLiteManger.shared().insertInUserTable(user: userData!)
                goToSignInVC()
            }
        }
    }
}

// MARK: - Image Picker Extension.

extension SignUpVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.contentMode = .scaleAspectFit
            userImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - MapCenterDelegate Extension.

extension SignUpVC: MapDelegate {
    func setDelailLocationInAddress(delailsAddress: String, tag: Int) {
        switch tag {
        case 1:
            userAddressOneTextField.text = delailsAddress
        case 2:
            userAddressTwoTextField.text = delailsAddress
        case 3:
            userAddressThreeTextField.text = delailsAddress
        default:
            print("Error In Tags")
        }
    }
}
