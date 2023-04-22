//  Created by Dominik Hauser on 22.04.23.
//  
//

import SwiftUI

struct AllActionsListView: View {

  @State var allActions: [Action] = []
  @State var selection = Set<UUID>()
  @Environment(\.editMode) var editMode

  var body: some View {
    NavigationView {
      VStack {
        if editMode?.wrappedValue.isEditing == true {
          Button(action: {}) {
            Label("New action", systemImage: "plus")
          }
        }
        List(allActions, selection: $selection) { action in
          ActionRowView(action: action, day: .constant(Day(date: .now, amountOfSpoons: 12)))
        }
        .listStyle(.plain)
      }
      .animation(nil, value: editMode?.wrappedValue)
      .navigationTitle("My spoon sinks")
      .toolbar {
        EditButton()
      }
    }
    .onAppear {
      allActions = FileManager.default.actions()
    }
  }

  func delete(at offsets: IndexSet) {

  }
}

struct AllActionsListView_Previews: PreviewProvider {
  static var previews: some View {
    AllActionsListView()
  }
}
