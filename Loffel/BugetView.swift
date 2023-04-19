//  Created by Dominik Hauser on 16.04.23.
//  
//


import SwiftUI

struct BudgetView: View {

  @Binding var day: Day
  private let spoonColumns = [GridItem(), GridItem(), GridItem(),
                              GridItem(), GridItem(), GridItem()]
  var spentSpoons: Int {
    return day.completedActions.reduce(0) { partialResult, action in
      return partialResult + action.spoons
    }
  }

  var body: some View {
    VStack(spacing: 10) {
      Text("Spoon Buget")
        .font(.headline)
      LazyVGrid(columns: spoonColumns, spacing: 20) {
        ForEach(0..<day.amountOfSpoons, id: \.self, content: { index in
          if index < spentSpoons {
            Image(systemName: "circle.slash")
              .font(.title)
          } else {
            Image(systemName: "circle.fill")
              .font(.title)
          }
        })
      }

      HStack {
        Button(action: { day.amountOfSpoons -= 1 }) {
          Image(systemName: "minus")
        }

        Spacer()

        Text("\(day.amountOfSpoons - spentSpoons) / \(day.amountOfSpoons)")

        Spacer()

        Button(action: { day.amountOfSpoons += 1 }) {
          Image(systemName: "plus")
        }
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
