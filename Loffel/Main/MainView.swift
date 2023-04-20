//  Created by Dominik Hauser on 13.04.23.
//  
//

import SwiftUI

struct MainView: View {

  @State var day: Day = Day(date: .now, amountOfSpoons: 12)
  @State var allActions: [Action] = []
  @State var inputIsShown: Bool = false
  @State var settingsIsShown: Bool = false
  @AppStorage("dailySpoons") private var dailySpoons: Int = 12

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        VStack(spacing: 20) {
          BudgetView(day: $day)
            .padding(.horizontal)

          ActionsListView(day: $day, allActions: $allActions)
        }
      }
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
      .sheet(isPresented: $settingsIsShown) {
        SettingsView()
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
          Button(action: { inputIsShown.toggle() }) {
            Image(systemName: "plus")
          }
          .accessibilityLabel(Text("Add action"))
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: reset) {
            Image(systemName: "arrow.counterclockwise")
          }
          .accessibilityLabel(Text("Reset spoons"))
        }
      }
      .navigationTitle(
        Text(
          day.date.formatted(
            .dateTime.day().month().year()
          )
        )
      )
    }
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


