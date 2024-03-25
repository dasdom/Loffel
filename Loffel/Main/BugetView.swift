//  Created by Dominik Hauser on 16.04.23.
//  
//


import SwiftUI

struct BudgetView: View {

  @Binding var day: Day
  private let spoonColumns = [
    GridItem(), GridItem(), GridItem(),
    GridItem(), GridItem(), GridItem()
  ]

  var body: some View {
    VStack(spacing: 10) {
      Text("Spoon Budget")
        .font(.headline)
      LazyVGrid(columns: spoonColumns, spacing: 10) {
        ForEach(0..<(day.realAmountOfSpoons - day.carryOverSpoons),
                id: \.self, content: { index in
          if index < day.completedSpoons {
            Image(systemName: "circle.slash")
          } else if index < day.plannedSpoons {
            Image(systemName: "circle")
          } else if index < day.plannedSpoons + day.completedSpoonSources {
            Image(systemName: "circle.slash.fill")
          } else {
            Image(systemName: "circle.fill")
          }
        })
      }
      .accessibilityHidden(true)

      VStack {
        HStack {
          Text("Planned")
          Text(day.plannedString)
            .monospaced()
        }
        HStack {
          Text("Completed")
          Text(day.completedString)
            .monospaced()
        }
      }
      .font(.subheadline)
    }
    .padding()
    .background {
      Color(UIColor.systemGray4)
    }
    .cornerRadius(20)
  }
}

struct BugetView_Previews: PreviewProvider {
  static var previews: some View {
    BudgetView(day: .constant(Day(date: .now, amountOfSpoons: 12)))
  }
}
