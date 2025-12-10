import SwiftUI

struct QRView: View {
    var body: some View {
        HStack {
            Button {
                print("Пропуск")
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 360, height: 51)
                        .foregroundColor(AppColor.mainColor)
                    Text("Пропуск")
                        .foregroundColor(AppColor.white)
                        .font(.system(size: 16))
                }
            }
            .padding()
        }
        .position(CGPoint(x: 197, y: 617.5))
    }
}
