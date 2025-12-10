import SwiftUI

struct ThreeBlueLinks: View {
    var body: some View {
        HStack{
            Button {
                print("Переход на страницу почты")
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(red: 0.16, green: 0.19, blue: 0.85))
                    .overlay(
                                Image("mail")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 15),
                                alignment: .leading
                            )
            }
                .padding()
            
            
            Button {
                print("Переход на страницу факультета")
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(red: 0.16, green: 0.19, blue: 0.85))
                    .overlay(
                                Image("faculty")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 15),
                                alignment: .leading
                            )
            }
                .padding()
            
            
            Button {
                print("Переход на страницу физры")
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(red: 0.16, green: 0.19, blue: 0.85))
                    .overlay(
                            Image("sport")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .padding(.leading, 15),
                            alignment: .leading
                        )
            }
                .padding()
            
        }
        .position(CGPoint(x: 197, y: 278))

    }
}
