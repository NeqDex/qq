//
//  WaterProgressView.swift
//  WaterReminder Watch App
//
//  Created by Артём on 02/04/2023.
//

import SwiftUI

struct WaterProgressView: View {
    @EnvironmentObject var waterData: WaterData
    let lineWidth: CGFloat = 25
    
    var body: some View {
        VStack {
            Text("Прогресс")
                .font(.largeTitle)
                .padding()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0, to: CGFloat(waterData.dailyWaterProgress))
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeInOut(duration: 1.0), value: waterData.totalWaterForDay)
                
                VStack {
                    Text("\(Int((waterData.totalWaterForDay / waterData.dailyGoal) * 100))%")
                        .font(.system(size: 60))
                        .bold()
                    Text("\(Int(waterData.totalWaterForDay)) мл из \(Int(waterData.dailyGoal)) мл")
                        .font(.headline)
                }
            }
        }
    }
}

struct WaterProgressView_Previews: PreviewProvider {
    static var previews: some View {
        WaterProgressView().environmentObject(WaterData())
    }
}



