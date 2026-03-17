//import Firebase
//import FirebaseDatabase
//import FirebaseAuth
//
//class FirebaseService {
//
//    func fetchStudent(completion: @escaping (Student?) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("Ошибка: пользователь не залогинен")
//            completion(nil)
//            return
//        }
//
//        let ref = Database.database().reference()
//        ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
//
//            guard let value = snapshot.value as? [String: Any] else {
//                print("Ошибка: не удалось получить словарь из snapshot")
//                completion(nil)
//                return
//            }
//
//            let name = value["name"] as? String ?? ""
//            let faculty = value["faculty"] as? String ?? ""
//            let group = value["group"] as? String ?? ""
//            let studentID = value["studentID"] as? String ?? ""
//            let email = value["email"] as? String ?? ""
//
//            var subjects: [SubjectData] = []
//            if let subjectsDict = value["subjects"] as? [String: Any] {
//                for (_, subjectData) in subjectsDict {
//                    if let subjectDict = subjectData as? [String: Any] {
//                        let name = subjectDict["name"] as? String ?? ""
//                        let progress = subjectDict["progress"] as? String ?? "0/100"
//                        var lessons: [Lesson] = []
//                        if let lessonsDict = subjectDict["lessons"] as? [String: Any] {
//                            for (_, lessonData) in lessonsDict {
//                                if let lessonDict = lessonData as? [String: Any] {
//                                    let lesson = Lesson(
//                                        id: UUID().uuidString,
//                                        title: lessonDict["title"] as? String ?? "",
//                                        date: lessonDict["date"] as? String ?? "",
//                                        status: lessonDict["status"] as? String ?? ""
//                                    )
//                                    lessons.append(lesson)
//                                }
//                            }
//                        }
//                        subjects.append(SubjectData(id: UUID().uuidString, name: name, progress: progress, lessons: lessons))
//                    }
//                }
//            }
//
//            var semesters: [Semester] = []
//            if let semestersDict = value["semesters"] as? [String: Any] {
//                for (_, semesterData) in semestersDict {
//                    if let semesterDict = semesterData as? [String: Any] {
//                        let title = semesterDict["title"] as? String ?? ""
//                        var semesterSubjects: [SemesterSubject] = []
//                        if let subjectsDict = semesterDict["subjects"] as? [String: Any] {
//                            for (_, subjectData) in subjectsDict {
//                                if let subDict = subjectData as? [String: Any] {
//                                    let name = subDict["name"] as? String ?? ""
//                                    let grade = subDict["grade"] as? String ?? ""
//                                    semesterSubjects.append(SemesterSubject(id: UUID().uuidString, name: name, grade: grade))
//                                }
//                            }
//                        }
//                        semesters.append(Semester(id: UUID().uuidString, title: title, subjects: semesterSubjects))
//                    }
//                }
//            }
//
//            let student = Student(
//                name: name,
//                faculty: faculty,
//                group: group,
//                studentID: studentID,
//                email: email,
//                subjects: subjects,
//                semesters: semesters
//            )
//
//            completion(student)
//        }
//    }
//}
//
//
//
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirebaseService {
    
    func fetchStudent(completion: @escaping (Student?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("❌ Пользователь не авторизован")
            completion(nil)
            return
        }
        
        print("🔥 Firestore: Запрос для UID = \(uid)")
        
        let db = Firestore.firestore()
        
        // В Firestore данные хранятся: collection("users") → document(uid)
        db.collection("users").document(uid).getDocument { snapshot, error in
            
            if let error = error {
                print("❌ Ошибка Firestore: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                print("❌ Документ не найден в коллекции 'users'")
                print("💡 Проверьте в Firebase Console: Firestore → users → \(uid)")
                completion(nil)
                return
            }
            
            guard let data = snapshot.data() else {
                print("❌ Не удалось получить данные из документа")
                completion(nil)
                return
            }
            
            print("✅ Документ получен! Данные: \(data)")
            
            let name = data["name"] as? String ?? ""
            let faculty = data["faculty"] as? String ?? ""
            let group = data["group"] as? String ?? ""
            let studentID = data["studentID"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            
            print("✅ Извлечено имя: '\(name)'")
            
            // --- Обработка Subjects ---
            var subjects: [SubjectData] = []
            if let subjectsData = data["subjects"] as? [[String: Any]] {
                for subjectDict in subjectsData {
                    let name = subjectDict["name"] as? String ?? ""
                    let progress = subjectDict["progress"] as? String ?? "0/100"
                    var lessons: [Lesson] = []
                    
                    if let lessonsArray = subjectDict["lessons"] as? [[String: Any]] {
                        for lessonDict in lessonsArray {
                            let lesson = Lesson(
                                id: UUID().uuidString,
                                title: lessonDict["title"] as? String ?? "",
                                date: lessonDict["date"] as? String ?? "",
                                status: lessonDict["status"] as? String ?? ""
                            )
                            lessons.append(lesson)
                        }
                    }
                    subjects.append(SubjectData(id: UUID().uuidString, name: name, progress: progress, lessons: lessons))
                }
            }
            
            // --- Обработка Semesters ---
            var semesters: [Semester] = []
            if let semestersData = data["semesters"] as? [[String: Any]] {
                for semesterDict in semestersData {
                    let title = semesterDict["title"] as? String ?? ""
                    var semesterSubjects: [SemesterSubject] = []
                    
                    if let subjectsArray = semesterDict["subjects"] as? [[String: Any]] {
                        for subDict in subjectsArray {
                            let name = subDict["name"] as? String ?? ""
                            let grade = subDict["grade"] as? String ?? ""
                            semesterSubjects.append(SemesterSubject(id: UUID().uuidString, name: name, grade: grade))
                        }
                    }
                    semesters.append(Semester(id: UUID().uuidString, title: title, subjects: semesterSubjects))
                }
            }
            
            let student = Student(
                name: name,
                faculty: faculty,
                group: group,
                studentID: studentID,
                email: email,
                subjects: subjects,
                semesters: semesters
            )
            
            print("✅ Student создан успешно: \(student.name)")
            completion(student)
        }
    }
}
