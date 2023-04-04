//
//  WaterData.swift
//  WaterReminder Watch App
//
//  Created by Артём on 02/04/2023.
//

import SwiftUI
import Combine
import HealthKit

class WaterData: ObservableObject {
    private var healthStore: HealthStore?
    @Published var dailyGoal: Double = 2000
    @Published var totalWaterForDay: Double = 0
    
    var dailyWaterProgress: Double {
        return min(totalWaterForDay / dailyGoal, 1)
    }

    init() {
        healthStore = HealthStore()
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                if success {
                    healthStore.calculateWaterConsumption { result in
                        DispatchQueue.main.async {
                            self.totalWaterForDay = result
                        }
                    }
                }
            }
        }
    }
    
    func addWater(amount: Double) {
        let waterSample = HKQuantitySample(type: HKObjectType.quantityType(forIdentifier: .dietaryWater)!,
                                           quantity: HKQuantity(unit: .literUnit(with: .milli), doubleValue: amount / 1000),
                                           start: Date(),
                                           end: Date())
        
        healthStore?.addWaterSample(waterSample: waterSample) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.totalWaterForDay += amount
                }
            } else {
                print("Error adding water sample: \(String(describing: error?.localizedDescription))")
            }
        }
    }
}

