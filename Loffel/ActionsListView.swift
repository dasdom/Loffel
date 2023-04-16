//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionsListView: View {

  @Binding var day: Day
  @Binding var allActions: [Action]
  var availableActions: [Action] {
    return allActions
      .filter({ false == day.plannedActions.contains($0) })
      .sorted(by: { $0.name < $1.name })
  }

  var body: some View {
    List {
      Section("Planned") {
        ForEach(day.plannedActions) { action in
          ActionRowView(action: action, day: $day)
            .swipeActions {
              Button {
                day.plannedActions.removeAll(where: { $0.id == action.id })
              } label: {
                Text("Unplan")
              }

              Button {
                if let index = day.completedActions.lastIndex(of: action) {
                  day.completedActions.remove(at: index)
                }
              } label: {
                Text("Undo")
              }
            }
            .contentShape(Rectangle())
            .onTapGesture {
              withAnimation {
                day.completedActions.append(action)
              }
            }
        }
        .onMove { from, to in
          day.plannedActions.move(fromOffsets: from, toOffset: to)
        }
      }
      Section("Available") {
        ForEach(availableActions) { action in
          ActionRowView(action: action, day: $day)
            .swipeActions {
              Button {
                day.plannedActions.append(action)
              } label: {
                Text("Plan")
              }

              Button {
                allActions.removeAll(where: { $0.id == action.id })
              } label: {
                Text("Delete")
              }
            }
        }
      }
    }
    .listStyle(.plain)
  }
}

struct ActionsListView_Previews: PreviewProvider {
  static var previews: some View {
    ActionsListView(day: .constant(Day(date: .now, amountOfSpoons: 12)), allActions: .constant( [Action(name: "Aufräumen", spoons: 2)]))
  }
}
