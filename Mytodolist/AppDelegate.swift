//
//  AppDelegate.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/12/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        do{
            let realm = try Realm()
            
        }catch{
            print("Error initialising Realm,\(error)")
        }
        return true
    }






}

