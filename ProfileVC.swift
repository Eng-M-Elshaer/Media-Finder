//
//  ProfileVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {
    
    // MARK: - Outlets.
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userAddressOneLabel: UILabel!
    @IBOutlet weak var userAddressTwoLabel: UILabel!
    @IBOutlet weak var userAddressThreeLabel: UILabel!
    
    // MARK: - Variables.
    var user = UserDefultsManger.shared().getUserDefaults()
    
    // MARK: - LifeCyclye Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isLoged")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setUserData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions.
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoged")
        goToSignInVC()
    }
}

// MARK: - Table view data source
extension ProfileVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
}

// MARK: - Private Methods.
extension ProfileVC {
    private func setUserData(){
        userImageView.image = user?.image.getImage()
        userNameLabel.text = user?.name
        userEmailLabel.text = user?.email
        userPhoneLabel.text = user?.phone
        userGenderLabel.text = (user?.gender).map { $0.rawValue }
        userAddressOneLabel.text = user?.addressOne
        userAddressTwoLabel.text = user?.addressTwo
        userAddressThreeLabel.text = user?.addressThree
    }
    private func goToSignInVC(){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.signInVC ) as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
