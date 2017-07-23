//
//  AppDelegate.swift
//  Two Page PDF Viewer
//
//  Created by Praveen on 7/22/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import PDFKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        if let url = launchOptions?[.url] as? URL {open(url: url)}
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        if let url = launchOptions?[.url] as? URL {open(url: url)}
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        open(url: url)
        return true
    }
    
    func open(url: URL) {
        DataModel.pdfDocument = PDFDocument(url: url)
    }
    
}
