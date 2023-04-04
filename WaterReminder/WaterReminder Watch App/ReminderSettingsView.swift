//
//  ReminderSettingsView.swift
//  WaterReminder Watch App
//
//  Created by Артём on 03/04/2023.
//

import SwiftUI

struct ReminderSettingsView: View {
    var body: some View {
        VStack {
            Text("Настройки напоминаний")
                .font(.largeTitle)
                .padding()

            // Здесь можно добавить пользовательский интерфейс для настройки напоминаний
            Text("Настройка напоминаний еще не реализована")
                .font(.headline)
                .padding()
            
            Spacer()
        }
    }
}

struct ReminderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderSettingsView()
    }
}
