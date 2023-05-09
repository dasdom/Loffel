//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionInputView: View {

  @State var name: String = ""
  @State var spoons: Int = 1
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

      Section {

        Button(action: dismiss.callAsFunction) {
          Text("Cancel")
        }
        .foregroundColor(Color(UIColor.systemRed))

        Button(action: {
          let id = UUID()
          let action = Action(id: id, name: name, spoons: spoons)
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
