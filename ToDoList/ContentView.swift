import SwiftUI

struct ContentView: View {
    @State private var tasks: [String] = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
    @State private var newTask: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a new task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(newTask.isEmpty)
                }
                .padding()

                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("To-Do List")
        }
    }

    func addTask() {
        tasks.append(newTask)
        saveTasks()
        newTask = ""
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }

    func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

