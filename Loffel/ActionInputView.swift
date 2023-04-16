//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionInputView: View {

  @State var name: String = ""
  @State var spoons: Int = 1
  @Binding var allActions: [Action]
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    Form {
      TextField("Name", text: $name)

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
            let action = Action(name: name, spoons: spoons)
            allActions.append(action)
            dismiss.callAsFunction()
          }) {
            Text("Save")
          }
        }
      }
    }
  }
}

struct ActionInputView_Previews: PreviewProvider {
  static var previews: some View {
    ActionInputView(allActions: .constant([]))
  }
}
