import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Добро пожаловать!")
                .font(.SFPro(33, weight: .semibold))
                .foregroundColor(AppColor.mainColor)
            Spacer()
            
            NavigationLink {
                LoginView()
            } label: {
                Text("Продолжить")
                    .font(.SFPro(18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(AppColor.mainColor)
                    .cornerRadius(13)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
