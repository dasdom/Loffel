//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI
@_exported import HotSwiftUI

struct ActionRowView: View {

  let action: Action
  let completed: Bool
  let shownAsInactive: Bool

  var body: some View {
    HStack(spacing: 0) {
      let absoluteSpoons = abs(action.spoons)
      ForEach(0..<absoluteSpoons, id: \.self) { _ in
        Image(systemName: imageName(for: action, completed: completed))
      }
      Spacer()
      Text(action.name).font(.title)
    }
    .listRowSeparator(.visible)
    .foregroundColor(shownAsInactive ?
                     Color(UIColor.secondaryLabel) :
                      Color(UIColor.label))
    .eraseToAnyView()
  }

  func imageName(for action: Action, completed: Bool) -> String {
    var imageName = "circle"
    if completed {
      imageName.append(".slash")
    }
    if action.actionType == .source {
      imageName.append(".fill")
    }
    return imageName
  }

  @ObserveInjection var redraw
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
      ActionRowView(action: Action(name: "Get up"), completed: true, shownAsInactive: false)
    }
}
