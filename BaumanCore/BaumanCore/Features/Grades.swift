// Created by Иван Агошков

import SwiftUI

struct GradesView: View {
    @State private var selectedTab: Tab = .current
    
    enum Tab {
        case current
        case session
    }
    
    var body: some View {
        VStack {
            
            // Шапка — остаётся на месте
            HStack {
                Text("Успеваемость")
                    .font(.largeTitle) // как на твоём примере профиля
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.top, 56)
                Spacer()
            }

            
            // Вкладки
            
            // --- Переключатель вкладок ---
            HStack(spacing: 24) { // расстояние между кнопками
                
                gradesTabButton(
                    title: "Текущая",
                    isActive: selectedTab == .current
                ) {
                    selectedTab = .current
                }
                
                gradesTabButton(
                    title: "Сессия",
                    isActive: selectedTab == .session
                ) {
                    selectedTab = .session
                }
            }
            .padding(.top, 10) // чуть ниже шапки
            .padding(.horizontal)
            
            // --- контент вкладки ---
             if selectedTab == .current {
                 ScrollView {
                     VStack(spacing: 12) {
                         SubjectRowView(subjectName: "Биомеханика", progress: "21/100")
                         SubjectRowView(subjectName: "Иностранный язык", progress: "50/100")
                         SubjectRowView(subjectName: "Клиническая терапия и хирургия", progress: "42/100")
                         SubjectRowView(subjectName: "Медицинские информационные системы", progress: "0/100")
                         SubjectRowView(subjectName: "Метрология, стандартизация и технические измерения", progress: "0/100")
                         SubjectRowView(subjectName: "Основы взаимодействия физических полей биообъектами", progress: "14/100")
                         SubjectRowView(subjectName: "Разработка программных Интернет-приложений", progress: "10/100")
                         SubjectRowView(subjectName: "Философия", progress: "60/100")
                         SubjectRowView(subjectName: "Элективный курс по физической культуре и спорту", progress: "36/100")
                         SubjectRowView(subjectName: "Электроника и микропроцессорная техника", progress: "0/100")
                     }
                     .padding(.horizontal)
                     .padding(.top)
                 }
             } else {
                 ScrollView {
                     VStack(spacing: 12) {
                         SessionGradesView()
                     }
                     .padding(.horizontal)
                     .padding(.top)
                 }
             }
             
             Spacer()
         }
     }
     
    
    // MARK: - Кнопки вкладки
    @ViewBuilder
    private func gradesTabButton(title: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isActive ? .white : .black)
                .animation(.easeInOut(duration: 0.1), value: isActive)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    Capsule()
                        .fill(isActive ? Color("GradesBlue") : .white)
                        .animation(nil, value: isActive)
                        .overlay(
                            Capsule()
                                .stroke(Color.black.opacity(isActive ? 0 : 0.5), lineWidth: 1)
                                .animation(nil, value: isActive)
                        )
                )
        }

    }
}

// MARK: - Предметы с выпадением

struct SubjectRowView: View {
    let subjectName: String
    let progress: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
 
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isExpanded.toggle()
                }
            }) {
                HStack(alignment: .center) {
                    // Название предмета
                    Text(subjectName)
                        .font(.title2)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        
                    

                    // Прогресс рядом с текстом
                    Text(progress)
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.5))
                        .padding(.leading, 4)

                    Spacer(minLength: 30) // отступ от стрелки слева

                    // Стрелка справа
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .foregroundColor(.gray)
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .padding(.vertical, 8)
            }
            
            // Выпадающий блок с деталями предмета
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Семинар 1:")
                    Text("Лабораторная:")
                    Text("Контрольная:")
                }
                .padding(.leading)
                .padding(.bottom, 8)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}


// MARK: - Сессия
struct SessionGradesView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Сессия 1: 95/100")
            Text("Сессия 2: 87/100")
            Text("Сессия 3: 100/100")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


// поправить развертывание определенного предмета
// убрать перенос названия предмета послогово (иногда возникает)
