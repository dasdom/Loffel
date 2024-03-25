//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

enum ActionType: Int {
  case sink
  case source
}

struct ActionInputView: View {

  @State var name: String = ""
  @State var spoons: Int = 1
  @State var type: ActionType = .sink
  var nameFromSearch: String? = nil
  @Binding var day: Day
  @Environment(\.dismiss) private var dismiss
  @FocusState private var focused: Bool
  @EnvironmentObject private var actionStore: ActionStore

  var body: some View {
    Form {
      TextField("Name", text: $name)
        .focused($focused)
      
      Stepper("Spoons: \(spoons)", value: $spoons, in:0...24)

      Picker("Type", selection: $type) {
        Text("Spoon Sink").tag(ActionType.sink)
        Text("Spoon Source").tag(ActionType.source)
      }

      Section {

        Button(action: dismiss.callAsFunction) {
          Text("Cancel")
        }
        .foregroundColor(Color(UIColor.systemRed))

        Button(action: {
          let id = UUID()
          let action = Action(
            id: id,
            name: name,
            spoons: type == .sink ? spoons : -spoons
          )
          actionStore.addOrReplace(action: action)
          day.plannedActions.append(action)
          dismiss()
        }) {
          Text("Save")
            .bold()
        }
      }
    }
    .onAppear {
      focused = true
      if let nameFromSearch = nameFromSearch {
        name = nameFromSearch
      }
    }
  }
}

struct ActionInputView_Previews: PreviewProvider {
  static var previews: some View {
    ActionInputView(day: .constant(Day()))
  }
}
