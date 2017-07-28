//
//  AppDelegate.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/25.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        application.statusBarStyle = UIStatusBarStyle.lightContent
        let mainVC = MainViewController()
        
        let VC = ViewController()
        let leftVC = LeftViewController()
        let Nav = UINavigationController.init(rootViewController: VC)
        mainVC.addChildViewController(Nav)
        mainVC.view.addSubview(Nav.view)
        mainVC.addChildViewController(leftVC)
        mainVC.view.addSubview(leftVC.view)
        mainVC.leftVC = leftVC
        VC.mainVC = mainVC
        leftVC.view.frame = CGRect.init(x: -250, y: 0, width: 250, height: UIScreen.main.bounds.size.height)

        //let Nav1 = UINavigationController.init(rootViewController: mainVC)
        self.window?.frame = UIScreen.main.bounds
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
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

