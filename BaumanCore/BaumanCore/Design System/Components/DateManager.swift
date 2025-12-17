import Foundation
import SwiftUI

final class ScheduleDateManager: ObservableObject {
    @Published var currentWeek: Int = 1
    @Published var currentDayIndex: Int = 1
    @Published var isEvenWeek: Bool = false
    @Published var currentWeekStartDate: Date = Date()
    @Published var animateDayButtons: Bool = false
    
    private let calendar = Calendar.current
    
    init() {
        updateRealDate()
        calculateWeekStartDate()
    }
    
    private func calculateWeekStartDate() {
        let calendar = Calendar.current
        let today = Date()

        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        guard let monday = calendar.date(from: components) else {
            return
        }

        let weeksFromCurrent = currentWeek - getCurrentAcademicWeek()
        if let adjustedMonday = calendar.date(byAdding: .weekOfYear, value: weeksFromCurrent, to: monday) {
            currentWeekStartDate = adjustedMonday
        }
    }
    
    private func getCurrentAcademicWeek() -> Int {
        let calendar = Calendar.current
        let today = Date()

        let year = calendar.component(.year, from: today)
        
        var septemberComponents = DateComponents()
        septemberComponents.year = year
        septemberComponents.month = 9
        septemberComponents.day = 1
        
        guard let firstSeptember = calendar.date(from: septemberComponents) else {
            return 1
        }

        let actualFirstSeptember: Date
        if today < firstSeptember {
            var pastYearComponents = septemberComponents
            pastYearComponents.year = year - 1
            actualFirstSeptember = calendar.date(from: pastYearComponents) ?? firstSeptember
        } else {
            actualFirstSeptember = firstSeptember
        }

        let weekDifference = calendar.dateComponents([.weekOfYear],
                                                    from: actualFirstSeptember,
                                                    to: today).weekOfYear ?? 0

        return max(1, weekDifference + 1)
    }
    
    func getDateForDay(dayIndex: Int) -> Date? {
        let dayOffset = dayIndex // ПН = 0, ВТ = 1 и т.д.
        return calendar.date(byAdding: .day, value: dayOffset, to: currentWeekStartDate)
    }
    
    func getDayNumberForDay(dayIndex: Int) -> String {
        guard let date = getDateForDay(dayIndex: dayIndex) else { return "" }
        let dayNumber = calendar.component(.day, from: date)
        return "\(dayNumber)"
    }
    
    func updateRealDate() {
        let today = Date()

        let weekday = calendar.component(.weekday, from: today)

        currentDayIndex = weekday == 1 ? 6 : weekday - 1
        

        currentWeek = getCurrentAcademicWeek()
        
        isEvenWeek = currentWeek % 2 == 0
        calculateWeekStartDate()
    }
    
    func nextWeek() {
        withAnimation(.easeInOut(duration: 0.3)) {
            animateDayButtons = true
        }
        
        
        if currentWeek < 18 {
            currentWeek += 1
        }
        isEvenWeek = currentWeek % 2 == 0
        calculateWeekStartDate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.animateDayButtons = false
            }
        }
    }
    
    func prevWeek() {
        withAnimation(.easeInOut(duration: 0.3)) {
            animateDayButtons = true
        }
        
        currentWeek -= 1
        if currentWeek < 1 { currentWeek = 1 }
        isEvenWeek = currentWeek % 2 == 0
        calculateWeekStartDate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.animateDayButtons = false
            }
        }
    }
    
    var weekTitle: String {
        "\(currentWeek) неделя, \(isEvenWeek ? "знаменатель" : "числитель")"
    }
}
