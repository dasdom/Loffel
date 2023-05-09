//  Created by Dominik Hauser on 22.04.23.
//  
//

import SwiftUI

struct ActionStoreView: View {
  
  @Binding var day: Day
  @State var searchText: String = ""
  @State var inputIsShown: Bool = false
  @State var editedAction: Action? = nil
  @State private var settingsDetent = PresentationDetent.medium
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var actionStore: ActionStore
  var filteredActions: [Action] {
    return actionStore.filter(searchText)
  }
  var filteredPlannedActions: [Action] {
    return filteredActions.filter({ day.plannedActions.contains($0) })
  }
  var filteredUnplannedActions: [Action] {
    return filteredActions.filter({ false == day.plannedActions.contains($0) })
  }

  var body: some View {
    NavigationView {
      VStack {
        if filteredActions.isEmpty {
          Button(action: {
            inputIsShown.toggle()
          }) {
            Label("New action", systemImage: "plus")
          }
        }
        List {
          Section("Unplanned") {
            ForEach(filteredUnplannedActions) { action in
              ActionRowView(
                action: action,
                completed: day.completedActions.contains(action),
                shownAsInactive: day.plannedActions.contains(action)
              )
              .contentShape(Rectangle())
              .onTapGesture {
                withAnimation {
                  day.plan(action: action)
                }
                dismiss()
              }
              .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                  actionStore.remove(action: action)
                } label: {
                  Text("Delete")
                }

                Button {
                  editedAction = action
                } label: {
                  Text("Edit")
                }
              }
            }
          }

          Section("Planned") {
            ForEach(filteredPlannedActions) { action in
              ActionRowView(
                action: action,
                completed: day.completedActions.contains(action),
                shownAsInactive: day.plannedActions.contains(action)
              )
              .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                  withAnimation {
                    day.unplan(action: action)
                  }
                } label: {
                  Text("Unplan")
                }

                Button {
                  editedAction = action
                } label: {
                  Text("Edit")
                }
              }
            }
          }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
      }
      .sheet(isPresented: $inputIsShown) {
        ActionInputView(nameFromSearch: searchText,
                        day: $day)
        .presentationDetents(
          [.medium, .large],
          selection: $settingsDetent
        )
      }
      .sheet(item: $editedAction) { action in
        DailyActionEditView(editedAction: action, day: $day)
      }
      .navigationTitle("My spoon sinks")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            inputIsShown.toggle()
          }) {
            Label("New action", systemImage: "plus")
          }
        }
      }
    }
  }
}

//struct AllActionsListView_Previews: PreviewProvider {
//  static var previews: some View {
//    AllActionsListView()
//  }
//}
