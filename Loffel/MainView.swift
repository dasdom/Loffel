//  Created by Dominik Hauser on 13.04.23.
//  
//

import SwiftUI

struct MainView: View {

  @State var day: Day = Day(date: .now, amountOfSpoons: 12)
  @State var allActions: [Action] = []
  @State var inputIsShown: Bool = false

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        BudgetView(day: $day)

        ActionsListView(day: $day, allActions: $allActions)

        Button(action: {
          inputIsShown.toggle()
        }) {
          Image(systemName: "plus")
            .font(.title)
        }
      }
      .padding()
      .onAppear {
        allActions = FileManager.default.actions()
        day = FileManager.default.day()
        if Calendar.current.isDate(day.date, inSameDayAs: .now) {
          reset()
        }
      }
      .sheet(isPresented: $inputIsShown) {
        ActionInputView(allActions: $allActions)
      }
      .onChange(of: allActions) { newValue in
        FileManager.default.safe(actions: newValue)
      }
      .onChange(of: day) { newValue in
        FileManager.default.safe(day: newValue)
      }
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button(action: reset) {
            Image(systemName: "arrow.counterclockwise")
          }
        }
      }
    }
  }

  func reset() {
    day.reset()
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(allActions: [
      Action(name: "Aufstehen", spoons: 1),
      Action(name: "Arbeit", spoons: 4)
    ])
  }
}


