//
//  AppDelegate.swift
//  marvel-comics
//
//  Created by Tancrède Chazallet on 11/04/2016.
//
//

import UIKit
import Kingfisher
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private(set) var navigationController: UINavigationController?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		
		UIApplication.sharedApplication().statusBarStyle = .LightContent
		
//		UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.clearColor()], forState: .Normal)
//		UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.clearColor()], forState: .Highlighted)
		
		navigationController = UINavigationController(rootViewController: ComicsViewController())
		navigationController!.navigationBar.barTintColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 0.8)
		navigationController!.navigationBar.tintColor = UIColor.whiteColor()
		navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window!.rootViewController = navigationController!
		window!.makeKeyAndVisible()
		
		// Image Cache
		let cache = KingfisherManager.sharedManager.cache
		cache.clearDiskCache()
		cache.clearMemoryCache()
		
		// Dropbox
		Dropbox.setupWithAppKey(DROPBOX_PUBLIC_KEY)
		
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
		if let authResult = Dropbox.handleRedirectURL(url) {
			switch authResult {
			case .Success:
				print("Success! User is logged into Dropbox.")
				Session.instance.checkForDropboxImages()
			case .Error(_, let description):
				print("Error: \(description)")
			}
		}
		
		return false
	}
}

