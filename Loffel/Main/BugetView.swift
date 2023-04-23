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
        ForEach(0..<(day.amountOfSpoons - day.carryOverSpoons),
                id: \.self, content: { index in
          if index < day.spentSpoons {
            Image(systemName: "circle.slash")
//              .font(.title)
          } else if index < day.plannedSpoons {
            Image(systemName: "circle")
          } else {
            Image(systemName: "circle.fill")
//              .font(.title)
          }
        })
      }
      .accessibilityHidden(true)

      HStack {
//        Button(action: {
//          if day.amountOfSpoons >= 1 {
//            day.amountOfSpoons -= 1
//          }
//        }) {
//          Image(systemName: "minus")
//        }
//
//        Spacer()

        if day.carryOverSpoons > 0 {
          Text("(\(day.availableSpoons) - \(day.carryOverSpoons)) / \(day.amountOfSpoons)")
        } else {
          Text("\(day.availableSpoons) / \(day.amountOfSpoons)")
        }

//        Spacer()
//
//        Button(action: { day.amountOfSpoons += 1 }) {
//          Image(systemName: "plus")
//        }
      }
      .padding([.horizontal])
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
