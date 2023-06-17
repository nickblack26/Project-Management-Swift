//
//  HomeViewModel.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    let manager = CoreDataManager.shared

    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var todaysTasks: [TaskEntity] = []
    
    init() {
        fetchCurrentWeek()
        fetchTasks()
    }
    
    func updateDate(date: Date) {
        self.currentDay = date
        self.fetchTasks()
    }
    
    func fetchTasks() {
        let tasksRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        let calendar = Calendar.current
        let day = calendar.dateInterval(of: .day, for: self.currentDay)
    
        let dayStart = day!.start
        let dayEnd = day!.end
        
        tasksRequest.predicate = NSPredicate(format: "(due >= %@) AND (due <= %@) AND (complete = %@)", dayStart as NSDate, dayEnd as NSDate, NSNumber(value: false))
        
        do {
            todaysTasks = try manager.context.fetch(tasksRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
