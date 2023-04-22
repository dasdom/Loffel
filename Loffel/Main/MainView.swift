//  Created by Dominik Hauser on 13.04.23.
//  
//

import SwiftUI

struct MainView: View {

  @State var day: Day = Day(date: .now, amountOfSpoons: 12)
  @State var allActions: [Action] = []
  @State var inputIsShown: Bool = false
  @State var settingsIsShown: Bool = false
  @State var actionStoreIsShown: Bool = false
  @State private var settingsDetent = PresentationDetent.medium
  @State var editedAction: Action? = nil
  @AppStorage("dailySpoons") private var dailySpoons: Int = 12

  var body: some View {
//    NavigationView {

      VStack(spacing: 20) {
        HeaderView(settingsIsShown: $settingsIsShown,
                   day: $day,
                   actionStoreIsShown: $actionStoreIsShown,
                   dailySpoons: dailySpoons)

        BudgetView(day: $day)
          .padding(.horizontal)

        ActionsListView(day: $day, allActions: $allActions, onStartEditing: { action in
          editedAction = action
          inputIsShown = true
        })
      }
      .onAppear {
        allActions = FileManager.default.actions()
        day = FileManager.default.day()
        if Calendar.current.isDate(day.date, inSameDayAs: .now) {
          reset()
        }
      }
      .sheet(isPresented: $inputIsShown) {
        ActionInputView(allActions: $allActions, editedAction: editedAction)
      }
      .sheet(isPresented: $settingsIsShown) {
        SettingsView()
      }
      .sheet(isPresented: $actionStoreIsShown) {
        AllActionsListView()
          .presentationDetents(
            [.medium, .large],
            selection: $settingsDetent
          )
      }
      .onChange(of: allActions) { newValue in
        FileManager.default.safe(actions: newValue)
      }
      .onChange(of: day) { newValue in
        FileManager.default.safe(day: newValue)
      }
      .onChange(of: dailySpoons) { newValue in
        day.amountOfSpoons = dailySpoons
      }
      .navigationBarTitleDisplayMode(.inline)
//      .toolbar {
//        ToolbarItem(placement: .navigationBarLeading) {
//          Button {
//            settingsIsShown.toggle()
//          } label: {
//            Image(systemName: "gear")
//          }
//          .accessibilityLabel(Text("Settings"))
//        }
//
//        ToolbarItem(placement: .navigationBarTrailing) {
//          Button(action: { actionStoreIsShown.toggle() }) {
//            Image(systemName: "plus")
//          }
//          .accessibilityLabel(Text("Add action"))
//        }
//        ToolbarItem(placement: .navigationBarTrailing) {
//          Button(action: reset) {
//            Image(systemName: "arrow.counterclockwise")
//          }
//          .accessibilityLabel(Text("Reset spoons"))
//        }
//      }
//    }
  }

  func reset() {
    day.reset(dailySpoons: dailySpoons)
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
