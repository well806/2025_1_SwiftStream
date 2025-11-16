import SwiftUI

struct ProfileView: View {
    private let student = Student(
        name: "Подобедов Владислав Владимирович",
        faculty: "Факультет Фундаментальные науки",
        group: "ФН12-71Б",
        studentID: "pvv22f019",
        email: "podobedovvv@student.bmstu.ru")
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(student.name)
                    .font(.headline)
                
                Text("Факультет: \(student.faculty)")
                Text("Группа: \(student.group)")
                Text("Идентификатор студента: \(student.studentID)")
                Text("Электронная почта: \(student.email)")
            }
            .padding()
        }
        .navigationTitle(Text("Профиль"))
    }
}
