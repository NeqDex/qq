//
//  HealthStore.swift
//  WaterReminder Watch App
//
//  Created by Артём on 03/04/2023.
//

import Foundation
import HealthKit

class HealthStore {
    var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let healthStore = healthStore else {
            completion(false)
            return
        }

        let typesToShare: Set = [HKObjectType.quantityType(forIdentifier: .dietaryWater)!]
        let typesToRead: Set = [HKObjectType.quantityType(forIdentifier: .dietaryWater)!]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            if let error = error {
                print("Error requesting HealthKit authorization: \(error.localizedDescription)")
            }
            completion(success)
        }
    }

    func calculateWaterConsumption(completion: @escaping (Double) -> Void) {
        guard let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater),
              let healthStore = healthStore else {
            completion(0)
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: waterType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            if let error = error {
                print("Error fetching water samples: \(error.localizedDescription)")
                completion(0)
                return
            }

            let totalWater = samples?.reduce(0) { sum, sample -> Double in
                if let quantitySample = sample as? HKQuantitySample {
                    return sum + quantitySample.quantity.doubleValue(for: .literUnit(with: .milli))
                } else {
                    return sum
                }
            } ?? 0

            completion(totalWater)
        }

        healthStore.execute(query)
    }

    func addWaterSample(waterSample: HKQuantitySample, completion: @escaping (Bool, Error?) -> Void) {
        guard let healthStore = healthStore else {
            completion(false, nil)
            return
        }
        healthStore.save(waterSample) { success, error in
            completion(success, error)
        }
    }
}
