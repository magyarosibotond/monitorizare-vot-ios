//  Created by Code4Romania

import Foundation
import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CoreData.containerName = "s"
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        // preload the reachability manager
        _ = ReachabilityManager.shared
        
        configureAppearance()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        #if DEBUG
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        #endif
        
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
        if ReachabilityManager.shared.isReachable {
            RemoteSyncer.shared.syncUnsyncedData { error in
                print("Tried to sync any unsynced data. Error? \(error?.localizedDescription ?? "None")")
            }
        } else {
            print("Would sync any unsynced data, but we're not online")
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        CoreData.saveContext()
    }
}

// MARK: - Appearance

extension AppDelegate {
    fileprivate func configureAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.navigationBarTint
    }
}
