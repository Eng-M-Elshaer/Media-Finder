//
//  AppDelegate.swift
//  Authentication Module
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
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK:- Private Method
extension AppDelegate {
    private func setNavbar(navigationController:UINavigationController){
        /// UIImage.init(named: "transparent.png")
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
    }
    private func swithToMainState(_ mainStoryboard: UIStoryboard){
        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.profileVC) as! ProfileVC
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
        
        let userData = UserDefaults.standard.object(forKey: UserDefaultsKeys.user)
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
}
