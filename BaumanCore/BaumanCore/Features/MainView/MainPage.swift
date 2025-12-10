import SwiftUI

struct MainPage: View {
    var body: some View {
        ZStack {
            ImageCarousel()
                .position(x: 197, y: 110)
            
            HeaderView()
            
            ThreeBlueLinks()
            
            QRView()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Text("Привет, Влад!")
                    .font(.SFPro(38, weight: .semibold))
                    .padding(.leading)
                    .padding(.bottom, 15)
                
                Text("Сегодня пятница, 10 неделя")
                    .font(.SFPro(20))
                    .padding(.leading)
                
                Text("7 ноября")
                    .font(.SFPro(20))
                    .padding(.leading)
                    .foregroundColor(AppColor.lightGrey)
                    .padding(.bottom, 3)
                
                Text("3 пары")
                    .font(.SFPro(15))
                    .foregroundColor(AppColor.lightGrey)
                    .padding(.leading)
            }
            .padding(.leading, 17)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 240)
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return BottomBarView(selectedTab: 1)
            .environmentObject(appState)
    }
}
