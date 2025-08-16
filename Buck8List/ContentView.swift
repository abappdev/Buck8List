//
//  ContentView.swift
//  Buck8List
//
//  Created by Abhishek Bhalerao on 16/08/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]

    @State private var isAlertShowing = false
    @State private var title: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    HStack {
                        Text("\(wish.title)")
                            .font(.title2)
                            .fontWeight(.light)
                            .padding(.vertical, 4)

                        Spacer()

                        if wish.isDone {
                            Image(
                                systemName:
                                    "checkmark.seal.fill"
                            )
                            .foregroundStyle(Color.indigo)
                        }
                    }
                    .swipeActions(
                        edge: .trailing,
                        content: {
                            Button(
                                action: {
                                    modelContext.delete(wish)
                                },
                                label: {
                                    HStack {
                                        Image(systemName: "delete.right.fill")
                                        Text("Remove")
                                    }
                                }
                            )
                            .tint(.red)
                        }
                    )
                    .swipeActions(
                        edge: .trailing,
                        content: {
                            Button(
                                action: {
                                    wish.isDone.toggle()
                                },
                                label: {
                                    HStack {
                                        Image(
                                            systemName:
                                                !wish.isDone
                                                ? "checkmark.seal.fill"
                                                : "flag.pattern.checkered"
                                        )
                                        Text(
                                            "\(!wish.isDone ? "Mark Done" : "Not Done")"
                                        )
                                    }
                                }
                            )
                            .tint(!wish.isDone ? .indigo : .orange)
                        }
                    )
                }
            }
            .navigationTitle("Bucket List")
            .toolbar(content: {
                ToolbarItem(
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: {
                                isAlertShowing = true
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                )

                if !wishes.isEmpty {
                    ToolbarItem(
                        placement: .bottomBar,

                    ) {
                        Text(
                            "You have \(wishes.count) item\(wishes.count==1 ? "" : "s") in your bucket list."
                        )
                        .foregroundStyle(.secondary)
                        .disabled(true)
                    }

                }

            }).alert(
                "Create a new bucket list item",
                isPresented: $isAlertShowing,
                actions: {
                    TextField("Add a new item", text: $title)

                    Button("Add") {
                        if !title.isEmpty {
                            modelContext.insert(
                                Wish(title: title, isDone: false)
                            )
                            title = ""
                            isAlertShowing = false
                        }
                    }
                }
            )
            .overlay(content: {
                if wishes.isEmpty {
                    ContentUnavailableView(
                        "My Bucket List",
                        systemImage: "heart.fill",
                        description: Text("Add your bucket list items here.")
                    )
                }
            })
        }
    }
}

#Preview("BucketList") {
    let container = try! ModelContainer(
        for: Wish.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    container.mainContext.insert(Wish(title: "Buy an iPhone", isDone: true))

    return ContentView().modelContainer(
        container
    )
}

#Preview("EmptyList") {
    ContentView().modelContainer(for: Wish.self, inMemory: true)
}
