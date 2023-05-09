//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionRowView: View {

  let action: Action
  let completed: Bool
  let shownAsInactive: Bool

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
    .listRowSeparator(.visible)
    .foregroundColor(shownAsInactive ?
                     Color(UIColor.secondaryLabel) :
                      Color(UIColor.label))
  }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
      ActionRowView(action: Action(name: "Get up"), completed: true, shownAsInactive: false)
    }
}
