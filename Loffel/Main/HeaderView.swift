//  Created by Dominik Hauser on 22.04.23.
//  
//

import SwiftUI

struct HeaderView: View {

  @Binding var settingsIsShown: Bool
  @Binding var day: Day
  @Binding var actionStoreIsShown: Bool
  let dailySpoons: Int

  var body: some View {
    HStack {
      Button {
        settingsIsShown.toggle()
      } label: {
        Image(systemName: "gear")
          .font(.title)
      }
      .accessibilityLabel(Text("Settings"))

      Text(
        day.date.formatted(
          .dateTime.day().month().year()
        )
      )
      .font(.headline)
      .padding(.horizontal)

      Spacer()

      Button(action: { actionStoreIsShown.toggle() }) {
        Image(systemName: "plus")
          .font(.title)
      }
      .accessibilityLabel(Text("Add action"))
      .padding(.trailing, 20)

      Button(action: reset) {
        Image(systemName: "arrow.counterclockwise")
          .font(.title)
      }
      .accessibilityLabel(Text("Reset spoons"))
    }
    .padding(.horizontal)
  }

  func reset() {
    day.reset(dailySpoons: dailySpoons)
  }
}
