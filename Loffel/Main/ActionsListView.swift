//  Created by Dominik Hauser on 16.04.23.
//  
//

import SwiftUI

struct ActionsListView: View {

  @Binding var day: Day
  @Binding var actionStoreIsShown: Bool
  var onStartEditing: ((Action) -> Void)?

  var body: some View {
    List {

      BudgetView(day: $day)

      HStack {
        Text("Actions")
          .font(.subheadline)

        Spacer()

        Button {
          actionStoreIsShown = true
        } label: {
          Image(systemName: "tray.full")
            .foregroundColor(.accentColor)
        }
      }

      ForEach(day.plannedActions) { action in
        ActionRowView(
          action: action,
          completed: day.completedActions.contains(action),
          shownAsInactive: day.completedActions.contains(action))
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
        .swipeActions(edge: .trailing) {
          if false == day.completedActions.contains(action) {
            Button(role: .destructive) {
              day.unplan(action: action)
            } label: {
              Text("Unplan")
            }
          }

          Button {
            onStartEditing?(action)
          } label: {
            Text("Edit")
          }
        }
      }
      .onMove { from, to in
        day.plannedActions.move(fromOffsets: from, toOffset: to)
      }
      //      .onDelete { indexSet in
      //        day.plannedActions.remove(atOffsets: indexSet)
      //      }
    }
    .listStyle(.plain)
  }
}

struct ActionsListView_Previews: PreviewProvider {
  static var previews: some View {
    ActionsListView(
      day: .constant(Day(plannedActions: [
        Action(name: "Get up")
      ])
      ),
      actionStoreIsShown: .constant(false))
  }
}
