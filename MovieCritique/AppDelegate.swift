//
//  AppDelegate.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit
import Unbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    private let apiKey = "0bae87a1c2bc3fd65e17a82fec52d5c7"
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if userDefaults.value(forKey: "movieImageConfig") == nil {
            let urlString = "https://api.themoviedb.org/3/configuration?api_key=\(apiKey)"
            let sharedSession = URLSession.shared
            
            DispatchQueue.global().async {
                if let url = URL(string: urlString) {
                    sharedSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                        if error != nil {
                            print(error.debugDescription)
                        }
                        
                        if let data = data {
                            do {
                                let config: TmdbApiConfiguration = try unbox(data: data)
                                let imageConfig: [String : String] = [
                                    "url": config.images.secure_base_url,
                                    "posterSize": config.images.poster_sizes[3],
                                    "logoSize": config.images.logo_sizes[0]
                                ]
                                
                                self?.userDefaults.set(imageConfig, forKey: "movieImageConfig")
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }).resume()
                }
            }
            
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

