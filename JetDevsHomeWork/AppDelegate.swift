//
//  AppDelegate.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		window = UIWindow(frame: screenFrame)
		window?.rootViewController = BaseTabBarController()

		window?.makeKeyAndVisible()
		return true
	}
}

