//
//  ContentView.swift
//  Bookworm
//
//  Created by Francisco Manuel Gallegos Luque on 11/02/2025.
//

import SwiftData
import SwiftUI

//struct PushButton: View {
//    let title: String
//    @Binding var isOn: Bool
//    
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.4)]
//    
//    var body: some View {
//        Button(title) {
//            isOn.toggle()
//        }
//        .padding()
//        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
//            .foregroundStyle(.white)
//            .clipShape(.capsule)
//            .shadow(radius: isOn ? 0 : 5)
//    }
//}
//
//struct ContentView: View {
//    @State private var rememberMe = false
//    
//    var body: some View {
//        VStack {
//            PushButton(title: "Remember me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
//}

//struct ContentView: View {
//    @AppStorage("notes") private var notes = ""
//    
////    var body: some View {
////        NavigationStack {
////            TextEditor(text: $notes)
////                .navigationTitle("Notes")
////                .padding()
////        }
////    }
//    
//    var body: some View {
//        NavigationStack {
//            TextField("Enter your text", text: $notes, axis: .vertical)
//                .textFieldStyle(.roundedBorder)
//                .navigationTitle("Notes")
//                .padding()
//        }
//    }
//}

//struct ContentView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query var students: [Student]
//    
//    var body: some View {
//        NavigationStack {
//            List(students) { student in
//                Text(student.name)
//            }
//            .navigationTitle("Classroom")
//            .toolbar {
//                    Button("Add") {
//                        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                        let chosenFirstName = firstNames.randomElement()!
//                        let chosenLastName = lastNames.randomElement()!
//
//                        let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
//                        modelContext.insert(student)
//                    }
//                }
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
