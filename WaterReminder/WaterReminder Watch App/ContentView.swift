import SwiftUI

struct ContentView: View {
    @EnvironmentObject var waterData: WaterData
    @State private var waterAmount: Double = 0

    var body: some View {
        TabView {
            WaterProgressView()
                .tabItem {
                    Image(systemName: "drop.fill")
                    Text("Главная")
                }
            WaterInputView(waterAmount: $waterAmount)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Добавить")
                }
            ReminderSettingsView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Напоминания")
                }
        }
        .environmentObject(waterData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WaterData())
    }
}
