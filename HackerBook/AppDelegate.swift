//
//  AppDelegate.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        do{
            let booksJson = try loadFromLocalFile(fileName: "books_readable.json")
            
            let library = try decodeBooks(books: booksJson)
            
            let tag = Tag(name: "programming")
            var tags = Set<Tag>()
            tags.insert(tag)
            
            print(tags.count)
            
            let model = Library(books: library, tags: tags)
            
            let uVC = LibraryTableViewController(model: model)
            let uNav = UINavigationController(rootViewController: uVC)
            
            window?.rootViewController = uNav
            
            /*
            let forceSensitives = try decodeCharacters(forceSensitives: forceSensitivesJson)
            
            let model = StarWarsUniverse(regularCharacters: regularCharacters, forceSensitives: forceSensitives)
            
            let uVC = StarWarsUniverseTableViewController(model: model)
            let uNav = UINavigationController(rootViewController: uVC)
            
            let charVC = CharacterViewController(model: try model.character(atIndex: 0, forAffiliation: .galacticEmpire)!)
            
            let cNav = UINavigationController(rootViewController: charVC)
            
            uVC.delegate = charVC
            
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [uNav, cNav]
            
            window?.rootViewController = splitVC
            */
            window?.makeKeyAndVisible()
            
        }catch{
            fatalError("ERROR FATAL")
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

