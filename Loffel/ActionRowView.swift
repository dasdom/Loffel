//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionRowView: View {

  let action: Action
  @Binding var day: Day

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<action.spoons, id: \.self) { _ in
        if day.completedActions.contains(action) {
          Image(systemName: "circle.slash")
        } else {
          Image(systemName: "circle")
        }
      }
      Spacer()
      Text(action.name)
    }
    .listRowSeparator(.visible)
  }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
      ActionRowView(action: Action(name: "Aufräumen", spoons: 2), day: .constant(Day(date: .now, amountOfSpoons: 12)))
    }
}
