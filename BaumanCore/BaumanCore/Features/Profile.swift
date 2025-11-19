import SwiftUI

struct ProfileView: View {
    @State private var student = Student(
        name: "Подобедов Владислав Владимирович",
        faculty: "Факультет ИУ",
        group: "ФН12-71Б",
        studentID: "pvv22f019",
        email: "podobedovvv@stundent.bmstu.ru"
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(student.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                GroupBox("Основное") {
                    VStack(alignment: .leading, spacing: 8) {
                        infoRow("Факультет", student.faculty)
                        infoRow("Группа", student.group)
                        infoRow("Студенческий", student.studentID)
                        infoRow("Email", student.email)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Личный кабинет")
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title).foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
        .font(.subheadline)
    }
}
