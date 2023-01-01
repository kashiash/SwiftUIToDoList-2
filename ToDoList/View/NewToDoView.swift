

import SwiftUI

struct NewToDoView: View {
    @Environment(\.managedObjectContext) var context
    
    @Binding var isShow: Bool
    
    @State var name: String
    @State var when: When
    @State var priority: Priority
    @State var isEditing = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add a new task")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                        
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                
                TextField("Enter the task description", text: $name, onEditingChanged: { (editingChanged) in
                    
                    self.isEditing = editingChanged
                    
                })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                
                HStack{
                    Text("When")
                    Text(self.when.name)
                    Image(systemName: self.when.imageName()).foregroundColor(self.when.color())
                }  .font(.system(.subheadline, design: .rounded))
                    .padding(.bottom)
                HStack {
                    VStack{
                        
                        Image(systemName: "clock.badge.questionmark")
                        Text("Later")
                        
                    }
                    .font(.system(.headline, design: .rounded))
                    
                    .padding(10)
                    .background(when == .later ? Color.blue : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.when = .later
                    }
                    VStack{
                        Image(systemName: "calendar.badge.exclamationmark")
                        Text("Today")
                        
                    }
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(when == .today ? Color.green : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.when = .today
                    }
                    
                    VStack{
                        Image(systemName: "clock.badge.exclamationmark")
                        Text("Asap")
                        
                    }
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(when == .asap ? Color.orange : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.when = .asap
                    }
                    VStack{
                        Image(systemName: "alarm.waves.left.and.right")
                        Text("Now")

                    }
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(when == .now ? Color.red : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.when = .now
                    }
                    VStack{
                        Image(systemName:"clock.badge" )
                        Text("Date")
  
                    }
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(when == .date ? Color.teal : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.when = .date
                    }
                }
                .padding(.bottom, 30)
                
                
                Text("Priority")
                    .font(.system(.subheadline, design: .rounded))
                    .padding(.bottom)
                
                HStack {
                    Text("High")
                        .font(.system(.headline, design: .rounded))
                        .padding(10)
                        .background(priority == .high ? Color.red : Color(.systemGray4))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onTapGesture {
                            self.priority = .high
                        }
                    
                    Text("Normal")
                        .font(.system(.headline, design: .rounded))
                        .padding(10)
                        .background(priority == .normal ? Color.orange : Color(.systemGray4))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onTapGesture {
                            self.priority = .normal
                        }
                    
                    Text("Low")
                        .font(.system(.headline, design: .rounded))
                        .padding(10)
                        .background(priority == .low ? Color.green : Color(.systemGray4))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onTapGesture {
                            self.priority = .low
                        }
                }
                .padding(.bottom, 30)
                
                // Save button for adding the todo item
                Button(action: {
                    
                    if self.name.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    self.isShow = false
                    self.addTask(name: self.name ,when: self.when , priority: self.priority)
                    
                }) {
                    Text("Save")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addTask(name: String,when: When, priority: Priority, isComplete: Bool = false) {
        
        let task = ToDoItem(context: context)
        task.id = UUID()
        task.name = name
        task.when = when
        task.priority = priority
        task.isComplete = isComplete
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}


struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewToDoView(isShow: .constant(true), name: "", when: .later, priority: .normal)
    }
}


