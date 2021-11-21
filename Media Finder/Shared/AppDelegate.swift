//
//  AppDelegate.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootView()
        IQKeyboardManager.shared.enable = true
        setupSQL()
        return true
    }
}

// MARK:- Private Methods
extension AppDelegate {
    private func setNavbar(navigationController: UINavigationController){
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    private func swithToMainState(_ mainStoryboard: UIStoryboard){
        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.mediaListVC) as! MediaListVC
        let navigationController = UINavigationController(rootViewController: rootVC)
        setNavbar(navigationController: navigationController)
        window?.rootViewController = navigationController
    }
    private func swithToAuthState(_ mainStoryboard: UIStoryboard){
        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        let navigationController = UINavigationController(rootViewController: rootVC)
        setNavbar(navigationController: navigationController)
        window?.rootViewController = navigationController
    }
    private func setRootView(){
        let userData = UserDefaults.standard.object(forKey: UserDefaultsKeys.isLogedIn)
        let isLoged = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLogedIn)
        let mainStoryboard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        
        if userData != nil {
            if isLoged {
               swithToMainState(mainStoryboard)
            } else {
               swithToAuthState(mainStoryboard)
            }
        }
    }
    private func setupSQL(){
        SQLiteManger.shared().setDatabaseTable(tableName: SQL.mediaTable)
        SQLiteManger.shared().setDatabaseTable(tableName: SQL.usersTable)
        let isOpenedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isOpenedBefore)
        if !isOpenedBefore {
            SQLiteManger.shared().createUserTable()
            SQLiteManger.shared().createMediaTable()
        }
    }
}
