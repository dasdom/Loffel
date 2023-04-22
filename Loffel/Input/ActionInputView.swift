//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionInputView: View {

  @State var name: String = ""
  @State var spoons: Int = 1
  @Binding var allActions: [Action]
  var editedAction: Action? = nil
  @Environment(\.dismiss) private var dismiss
  @FocusState private var focused: Bool

  var body: some View {
    Form {
      TextField("Name", text: $name)
        .focused($focused)
      
      Stepper("Spoons: \(spoons)", value: $spoons)

      Section {

        HStack {
          Button(action: dismiss.callAsFunction) {
            Text("Cancel")
          }
          .foregroundColor(Color(UIColor.systemRed))
          .bold()

          Spacer()

          Button(action: {
            let id = editedAction?.id ?? UUID()
            let action = Action(id: id, name: name, spoons: spoons)
            if let index = allActions.firstIndex(where: { $0.id == id }) {
              allActions[index] = action
            } else {
              allActions.append(action)
            }
            dismiss()
          }) {
            Text("Save")
          }
        }
      }
    }
    .onAppear {
      focused = true
      if let editedAction = editedAction {
        name = editedAction.name
        spoons = editedAction.spoons
      }
    }
  }
}

struct ActionInputView_Previews: PreviewProvider {
  static var previews: some View {
    ActionInputView(allActions: .constant([]))
  }
}
