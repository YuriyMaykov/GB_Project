//
//  AppDelegate.swift
//  Vk_Maykov
//
//  Created by Юрий on 15/09/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        
        do {
            let realm = try Realm()
            let settings = realm.objects(UserSettings.self).first
            if settings != nil {
                
                let cacheTocen = settings?.token
                let cacheUserId = settings?.id
                
                if (cacheTocen != "" && cacheUserId != 0) {

                    Session.shared.token = settings?.token ?? ""
                    Session.shared.userId = String(settings?.id ?? 0)
                    
                    window = UIWindow(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let mainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen")
                    window?.rootViewController = mainScreen
                }
            }
        } catch {
            print(error)
        }
        
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

