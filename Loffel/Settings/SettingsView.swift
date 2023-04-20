//  Created by Dominik Hauser on 19.04.23.
//  
//

import SwiftUI

struct SettingsView: View {

  @AppStorage("dailySpoons") private var dailySpoons: Int = 12
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      Form {
        Stepper("Daily spoons: \(dailySpoons)", value: $dailySpoons, in: 1...24)
      }
      .toolbar {
        ToolbarItem {
          Button(action: dismiss.callAsFunction) {
            Text("Done")
          }
        }
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
