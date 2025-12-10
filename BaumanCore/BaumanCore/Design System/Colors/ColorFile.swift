import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

enum AppColor {
    static let black = Color(hex: "#000000")
    static let darkGrey = Color(hex: "#4B4A4A")
    static let lightGrey = Color(hex: "#6A6A6A")
    static let lightlightGrey = Color(hex: "#C4C4C4")
    static let white = Color(hex: "#FFFFFF")
    
    
    static let mainColor = Color(hex: "#2932D9")
}
