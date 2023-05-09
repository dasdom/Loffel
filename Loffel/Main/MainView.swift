//  Created by Dominik Hauser on 13.04.23.
//  
//

import SwiftUI

struct MainView: View {

  @State var day: Day = Day(date: .now, amountOfSpoons: 12)
  @State var inputIsShown: Bool = false
  @State var settingsIsShown: Bool = false
  @State var actionStoreIsShown: Bool = false
  @State var editedAction: Action? = nil
  @State private var settingsDetent = PresentationDetent.medium
  @AppStorage("dailySpoons") private var dailySpoons: Int = 12
  @StateObject private var actionStore: ActionStore = ActionStore()

  var body: some View {
    NavigationView {
      ActionsListView(day: $day, actionStoreIsShown: $actionStoreIsShown, onStartEditing: { action in
        editedAction = action
        inputIsShown = true
      })
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            settingsIsShown.toggle()
          } label: {
            Image(systemName: "gear")
          }
          .accessibilityLabel(Text("Settings"))
        }

        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: reset) {
            Image(systemName: "arrow.counterclockwise")
          }
          .accessibilityLabel(Text("Reset spoons"))
        }
      }
    }
    .onAppear {
      day = FileManager.default.day()
      if false == Calendar.current.isDate(day.date, inSameDayAs: .now) {
        reset()
      }
    }
    .sheet(item: $editedAction, content: { action in
      DailyActionEditView(editedAction: action, day: $day)
    })
    .sheet(isPresented: $settingsIsShown) {
      SettingsView()
    }
    .sheet(isPresented: $actionStoreIsShown) {
      ActionStoreView(day: $day)
        .presentationDetents(
          [.medium, .large],
          selection: $settingsDetent
        )
    }
    .onChange(of: day) { newValue in
      FileManager.default.save(day: newValue)
    }
    .onChange(of: dailySpoons) { newValue in
      day.amountOfSpoons = dailySpoons
    }
    .environmentObject(actionStore)
  }

  func reset() {
    day.reset(dailySpoons: dailySpoons)
  }
}

//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView(allActions: [
//      Action(name: "Aufstehen", spoons: 1),
//      Action(name: "Arbeit", spoons: 4)
//    ])
//  }
//}
