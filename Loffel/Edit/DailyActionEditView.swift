//  Created by Dominik Hauser on 23.04.23.
//  
//

import SwiftUI

struct DailyActionEditView: View {

  @State var name: String = ""
  @State var spoons: Int = 1
  var editedAction: Action
  @Binding var day: Day
  @FocusState private var focused: Bool
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var actionStore: ActionStore

  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)
          .focused($focused)

        Stepper("Spoons: \(spoons)", value: $spoons, in:0...24)

        Text("This will only change the action of the day. The corresponding action your pool of actions won't be changed.")
          .font(.footnote)

        Section {
          Button(action: {
            let id = editedAction.id
            let action = Action(id: id, name: name, spoons: spoons)
            actionStore.addOrReplace(action: action)
            dismiss()
          }) {
            Text("Save")
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: dismiss.callAsFunction) {
            Label("Cancel", systemImage: "x.circle")
          }
        }
      }
    }
    .onAppear {
      focused = true
      name = editedAction.name
      spoons = editedAction.spoons
    }
  }
}

struct DailyActionEditView_Previews: PreviewProvider {
  static var previews: some View {
    DailyActionEditView(
      editedAction: Action(name: "Breakfast"),
      day: .constant(Day())
    )
  }
}
