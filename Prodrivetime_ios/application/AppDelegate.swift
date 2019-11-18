//
//  AppDelegate.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var compositionRoot: CompositionRoot?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        compositionRoot = CompositionRoot()
        
        configureFirebase()
        configurePushNotification()
        configureApplicationEntryPoint()
        configureLogging()
        
        return true
    }

    func configureApplicationEntryPoint() {
        
        guard let compositionRoot = compositionRoot else {
            return
        }
        
        let coordinator = compositionRoot.getCoordinator()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        coordinator.onStart()
        
        window?.rootViewController = coordinator.navigationController
    }
    
    func configureLogging() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func configurePushNotification() {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (granted, error) in
            
            if granted == true {
                print("User granted push notification")
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            } else {
                print("User did not grant pn")
            }
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    }
    
}
