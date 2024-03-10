//
//  AppDelegate.swift
//  macControl
//
//  Created by Alejandro Garcia on 25/8/23.
//


import Foundation
import SwiftUI
import os

class AppDelegate: NSObject, NSApplicationDelegate {
    @AppStorage("hasShownMoveToApplicationsAlert") private var hasShownMoveToApplicationsAlert = false
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "uno.kayros.macControl", category: "app")
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        if !hasShownMoveToApplicationsAlert && !AppDelegate.insideAppsFolder {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                NSApp.activate(ignoringOtherApps: true)
                self.showAlertOnFirstLaunch()
                self.hasShownMoveToApplicationsAlert = true
            }
        }
        
        logger.notice("Application DidFinishLaunching")
    }

    func applicationWillTerminate(_ notification: Notification) {
        //WhiskyApp.killBottles()
        //TODO: action on terminat
        logger.notice("Application will terminate")
    }

    private static var appUrl: URL? {
        Bundle.main.resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
    }

    private static var expectedUrl = URL(fileURLWithPath: "/Applications/macControl.app")

    private static var insideAppsFolder: Bool {
        if let url = appUrl {
            return url.path.contains("Xcode") || url.path.contains(expectedUrl.path)
        }
        return false
    }

    private func showAlertOnFirstLaunch() {
        logger.notice("macControl alert on first launch")
        
        let alert = NSAlert()
        alert.messageText = String(localized: "It is recommended to move the app to the Applications folder")
        alert.informativeText = String(localized: "Move App")
        alert.addButton(withTitle: String(localized: "Move"))
        alert.addButton(withTitle: String(localized: "Don't Move"))

        let response = alert.runModal()

        if response == .alertFirstButtonReturn {
            let appURL = Bundle.main.bundleURL

            do {
                _ = try FileManager.default.replaceItemAt(AppDelegate.expectedUrl, withItemAt: appURL)
                NSWorkspace.shared.open(AppDelegate.expectedUrl)
            } catch {
                print("Failed to move the app: \(error)")
            }
        }
    }
}

