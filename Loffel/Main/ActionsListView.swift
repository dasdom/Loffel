//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionsListView: View {

  @Binding var day: Day
  @Binding var allActions: [Action]
  var plannedActions: [Action] {
    allActions.filter({ day.plannedActions.contains($0) })
  }
  var unplannedActions: [Action] {
    return allActions
      .filter({ false == day.plannedActions.contains($0) })
      .sorted(by: { $0.name < $1.name })
  }
  @State var sortedActions: [Action] = []

  var body: some View {
    List {
      ForEach(sortedActions) { action in
        if action.isHeader {
          VStack {
            Spacer()

            Text(action.name)
              .font(.subheadline)
              .foregroundColor(.gray)
              .bold()

            Divider()
          }
          .moveDisabled(action.name == "Planned")
          .listRowSeparator(.hidden)
        } else {
          ActionRowView(action: action, day: $day)
            .contentShape(Rectangle())
            .onTapGesture {
              withAnimation {
                if day.completedActions.contains(where: { $0.id == action.id }) {
                  day.completedActions.removeAll(where: { $0.id == action.id })
                } else {
                  day.completedActions.append(action)
                }
              }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
              Button {
                if day.plannedActions.contains(action) {
                  day.plannedActions.removeAll(where: { $0.id == action.id })
                } else {
                  day.plannedActions.append(action)
                }
                updateSortedActions()
              } label: {
                if day.plannedActions.contains(action) {
                  Text("Unplan")
                } else {
                  Text("Plan")
                }
              }
              .tint(Color.accentColor)
            })
            .swipeActions {
              Button(role: .destructive) {
                allActions.removeAll(where: { $0.id == action.id })
              } label: {
                Text("Delete")
              }
            }
        }
      }
      .onMove { from, to in
        sortedActions.move(fromOffsets: from, toOffset: to)
      }
    }
    .listStyle(.plain)
    .onChange(of: allActions) { newValue in
      updateSortedActions()
    }
    .onChange(of: sortedActions) { newValue in
      day.plannedActions = sortedActions.prefix(while: { $0.name != "Unplanned" })
    }
  }

  func updateSortedActions() {
    sortedActions = [Action(name: "Planned", isHeader: true)] +
    plannedActions +
    [Action(name: "Unplanned", isHeader: true)] +
    unplannedActions
  }
}

struct ActionsListView_Previews: PreviewProvider {
  static var previews: some View {
    ActionsListView(
      day: .constant(
        Day(date: .now,
            amountOfSpoons: 12)),
      allActions: .constant(
        [
          Action(name: "Aufräumen", spoons: 2)
        ]
      )
    )
  }
}
