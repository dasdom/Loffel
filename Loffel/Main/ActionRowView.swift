//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionRowView: View {

  let action: Action
  @Binding var day: Day
  var completed: Bool {
    return day.completedActions.contains(action)
  }

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<action.spoons, id: \.self) { _ in
        if completed {
          Image(systemName: "circle.slash")
        } else {
          Image(systemName: "circle")
        }
      }
      Spacer()
      Text(action.name)
    }
    .foregroundColor(completed ?
                     Color(UIColor.secondaryLabel) :
                      Color(UIColor.label))
    .listRowSeparator(.visible)
  }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
      ActionRowView(action: Action(name: "Aufräumen", spoons: 2), day: .constant(Day(date: .now, amountOfSpoons: 12)))
    }
}
