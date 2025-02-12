//
//  ContentView.swift
//  ToDo-Swift Data
//
//  Created by Sanjay Kumar on 12/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var tasktitle: String = ""
    @State var taskDetails: String = "Task details"
    
    @Environment(\.modelContext) var context
    @Query var taskList: [TaskItemModel]
    
    var body: some View {
        ZStack{
            VStack {
                TextField(
                    "Title",
                    text: $tasktitle,
                    onEditingChanged: { changed in
                        // this event triger when focus is given or taken for the control.
                    },
                    onCommit: {
                        // this event triger when the user has finished his entry by pressing the Enter key.
                    }
                ).padding()
                    .border(Color.gray)
                
                Button{
                    if tasktitle.isEmpty{
                        return
                    }
                    let newTask = TaskItemModel(
                        tittle: tasktitle,
                        details: taskDetails
                    )
                    
                    context.insert(newTask)
                    tasktitle = ""
                    
                    
                }label: {
                    Text("Save")
                        .frame(width: 200, height: 40)
                        .font(.system(size: 16,weight: .bold,design: .default))
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(24)
                }
                Spacer()
                
                
                
                List{
                    ForEach(taskList){ task in
                        Text("Tittle: \(task.tittle)")
                        
                    }.onDelete { IndexSet in
                        IndexSet.forEach { index in
                            context.delete(taskList[index])
                        }
                    }
                    
                }.overlay{
                    if taskList.isEmpty{
                        Text("No Data")
                    }
                }
            }
            .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
