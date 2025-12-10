import Foundation
import SwiftUI

struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let status: String
    let statusColor: Color
}
