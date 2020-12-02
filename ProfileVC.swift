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

    var users:[Data]!
    var email = UserDefultsManger.shared().email
    var user:User!
    
    // MARK: - LifeCyclye Funtions.

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SQLiteManger.shared().setDatabaseTable(tableName: SQL.usersTable)
        user = SQLiteManger.shared().getUserFromDB(email: email)
        setUserData()
    }
    
    // MARK: - VC Funtions.

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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    // MARK: - Button Functions.

    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        UserDefultsManger.shared().isLogedIn = false
        goToSignInVC()
    }
    
}
