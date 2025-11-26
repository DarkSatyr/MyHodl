//
//  DayChangeTracker.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI
import Combine

@MainActor
final class DayChangeTracker: ObservableObject {
    @Published var currentDay = Date()
    private var isStarted = false
    private var bag = Set<AnyCancellable>()
    
    func start() {
        guard isStarted == false else { return }
        isStarted = true
        Publishers.MergeMany(NotificationCenter.default.publisher(for: .NSCalendarDayChanged),
                             NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification),
                             NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification))
        .map { _ in Date() }
        .assign(to: \.currentDay, on: self)
        .store(in: &bag)
        
        currentDay = Date()
    }
    
    func stop() {
        bag.removeAll()
        isStarted = false
    }
}
