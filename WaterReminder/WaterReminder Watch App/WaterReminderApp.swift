//
//  WaterReminderApp.swift
//  WaterReminder Watch App
//
//  Created by Артём on 02/04/2023.
//

import SwiftUI
import UserNotifications


@main
struct WaterReminderApp: App {
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WaterData())
        }
    }
}

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        requestNotificationPermission()
    }
    
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Разрешение на отправку уведомлений получено")
            } else {
                print("Разрешение на отправку уведомлений не получено")
            }
        }
    }
}
