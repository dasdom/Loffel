//  Created by Dominik Hauser on 22.04.23.
//  
//

import SwiftUI

struct AllActionsListView: View {

  @Binding var day: Day
  @State var searchText: String = ""
  @State var inputIsShown: Bool = false
  @State var editedAction: Action? = nil
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var actionStore: ActionStore
  var filteredActions: [Action] {
    return actionStore.filter(searchText)
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
        List(filteredActions) { action in
          ActionRowView(action: action, day: $day)
            .foregroundColor(day.plannedActions.contains(action) ?
                             Color(UIColor.secondaryLabel) :
                              Color(UIColor.label))
            .contentShape(Rectangle())
            .onTapGesture {
              if false == day.plannedActions.contains(where: { $0.id == action.id }) {
                day.plannedActions.append(action)
              }
              dismiss()
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
      }
      .sheet(isPresented: $inputIsShown) {
        ActionInputView(editedAction: editedAction,
                        nameFromSearch: searchText,
                        day: $day)
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

  func delete(at offsets: IndexSet) {

  }
}

//struct AllActionsListView_Previews: PreviewProvider {
//  static var previews: some View {
//    AllActionsListView()
//  }
//}
