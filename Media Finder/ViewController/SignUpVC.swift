//
//  SignUpVC.swift
//  Media Finder
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
    
    // MARK: - Properties
    var user: User!
    var gender: Gender = .female
    let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle Mehtods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    // MARK: - Actions.
    @IBAction func userGenderSwitchChanged(_ sender: UISwitch) {
        userGenderChanged(sender)
    }
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        addressTapped(sender)
    }
    @IBAction func userImageBtnTapped(_ sender: UIButton) {
        userImageTapped()
    }
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        signUpTapped()
    }
}

// MARK: - Image Picker Extension.
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        setDelailLocation(delailsAddress: delailsAddress, tag: tag)
    }
}

// MARK: - Table view data source
extension SignUpVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

// MARK: - Private Methods.
extension SignUpVC {
    private func goToSignInVC(){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    private func isVaildData() -> Bool {
        guard userImageView.image != UIImage(named: Images.user) else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.choosePhoto)
            return false
        }
        guard (userEmailTextField.text?.trimmed) != "" else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.enterEmail)
            return false
        }
        guard (userPasswordTextField.text) != "" else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.enterPassword)
            return false
        }
        guard (userPhoneTextField.text?.trimmed) != "" else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.enterPhone)
            return false
        }
        guard (userAddressOneTextField.text?.trimmed) != "" else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.enterAddress)
            return false
        }
        return true
    }
    private func isValidRegax() -> Bool {
        guard isValidEmail(email: userEmailTextField.text?.trimmed) else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.vaildEmail)
            return false
        }
        guard isValidPassword(testStr: userPasswordTextField.text) else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.vaildPassword)
            return false
        }
        guard isValidPhone(number: userPhoneTextField.text?.trimmed) else {
            self.showAlert(title: AlertTitle.sorry, message: AlertMessage.vaildPhone)
            return false
        }
        return true
    }
    private func getUser() -> User {
        user = User(image: CodableImage(withImage: userImageView.image!), name: userNameTextField.text,
                    email: userEmailTextField.text,
                    phone: userPhoneTextField.text, password: userPasswordTextField.text, gender: gender,
                    addressOne: userAddressOneTextField.text, addressTwo: userAddressTwoTextField.text,
                    addressThree: userAddressThreeTextField.text)
        return user
    }
    private func signUpTapped(){
        if isVaildData() {
            if isValidRegax() {
                if let user = CoderManger.shared().encodUser(user: getUser()) {
                    SQLiteManger.shared().insertInUserTable(user: user)
                }
                goToSignInVC()
            }
        }
    }
    private func addressTapped(_ sender: UIButton){
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let mapVC = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.mapVC) as! MapVC
        mapVC.delegate = self
        mapVC.tag = sender.tag
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    private func userImageTapped(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    private func userGenderChanged(_ sender: UISwitch){
        if sender.isOn {
            gender = .female
        } else {
            gender = .male
        }
    }
    private func setDelailLocation(delailsAddress: String, tag: Int){
        switch tag {
        case 1:
            userAddressOneTextField.text = delailsAddress
        case 2:
            userAddressTwoTextField.text = delailsAddress
        default:
            userAddressThreeTextField.text = delailsAddress
        }
    }
    private func setup(){
        imagePicker.delegate = self
        userImageView.image = UIImage(named: Images.user)
    }
}
