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
    @State var taskDetails: String = ""
    
    @State var showBottomSheet: Bool = false
    @State var isChecked: Bool = false
    @State private var offset: CGFloat = 0
    
    @Environment(\.modelContext) var context
    @Query var taskList: [TaskItemModel]
    
    var body: some View {
        ZStack{
            VStack {
                
                HStack{
                    Spacer()
                    Image(systemName: "plus")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30,height: 30)
                        .padding(.trailing,8)
                        .onTapGesture {
                            showBottomSheet = true
                        }
                }

                List{
                    ForEach(taskList){ task in
                        HStack{
                            Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(task.isDone ? .blue : .gray)
                                            .onTapGesture {
                                                isChecked.toggle()
                                                task.isDone = isChecked
                                                try? context.save()
                                            }
                        
                            
                            VStack{
                                Text("Tittle: \(task.tittle)").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 16))
                                Text("Details: \(task.details)").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 14)).padding(.top,2)
                            }
                        }
                        
                    }.onDelete { IndexSet in
                        IndexSet.forEach { index in
                            context.delete(taskList[index])
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .overlay{
                    if taskList.isEmpty{
                        Text("No Task Data Found!")
                    }
                }
            }
        
            
            
            if showBottomSheet{
                // bottom sheet design
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        withAnimation {
                            showBottomSheet = false
                            tasktitle = ""
                            taskDetails = ""
                        }
                    }
                
                VStack{
                    Spacer()
                    VStack{ // bottom sheet view starts
                        VStack{
                            TextField(
                                "Title",
                                text: $tasktitle,
                                onEditingChanged: { changed in
                                    // this event triger when focus is given or taken for the control.
                                },
                                onCommit: {
                                    // this event triger when the user has finished his entry by pressing the Enter key.
                                }
                            )
                            //.textFieldStyle(.roundedBorder)
                            .padding()
                                .border(Color.gray)
                            
                            TextField(
                                "Details",
                                text: $taskDetails,
                                onEditingChanged: { changed in
                                    // this event triger when focus is given or taken for the control.
                                },
                                onCommit: {
                                    // this event triger when the user has finished his entry by pressing the Enter key.
                                }
                            )
                            //.textFieldStyle(.roundedBorder)
                            .padding()
                                .border(Color.gray)
                            
                            Spacer()
                            
                            Button{
                                if tasktitle.isEmpty {
                                    return
                                }
                                
                                if taskDetails.isEmpty {
                                    return
                                }
                                
                                let newTask = TaskItemModel(
                                    tittle: tasktitle,
                                    details: taskDetails,
                                    isDone: false
                                )
                                
                                context.insert(newTask)
                                tasktitle = ""
                                taskDetails = ""
                                
                                showBottomSheet = false
                            }label: {
                                Text("Save")
                                    .frame(width: 200, height: 40)
                                    .font(.system(size: 16,weight: .bold,design: .default))
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(24)
                            }
                        }.padding(16)
                    }
                    .frame(height: 300)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .offset(y: offset)
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                if value.translation.height > 0 {
                                    offset = value.translation.height
                                }
                            }
                            .onEnded{ value in
                                if offset > 150 {
                                    withAnimation {
                                        showBottomSheet = false
                                    }
                                }
                                offset = 0
                                
                            }
                        
                    
                    ).transition(.move(edge: .bottom))
                }.animation(.spring(), value: showBottomSheet)
                
                
                
            }// bottom sheet end
            
        }
    }
}

#Preview {
    ContentView()
}
