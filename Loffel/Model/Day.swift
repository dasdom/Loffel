//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Day: Codable, Equatable {
  var date: Date
  var amountOfSpoons: Int
  var carryOverSpoons: Int
  var completedActions: [Action]
  var plannedActions: [Action]
  var spentSpoons: Int {
    return completedActions
      .reduce(0) { partialResult, action in
        return partialResult + action.spoons
      }
  }
  var plannedSpoons: Int {
    return plannedActions
      .reduce(0) { partialResult, action in
        return partialResult + action.spoons
      }
  }
  var availableSpoons: Int {
    return amountOfSpoons - spentSpoons
  }

  init(date: Date = .now,
       amountOfSpoons: Int = 12,
       carryOverSpoons: Int = 0,
       completedActions: [Action] = [],
       plannedActions: [Action] = []) {
    self.date = date
    self.amountOfSpoons = amountOfSpoons
    self.carryOverSpoons = carryOverSpoons
    self.completedActions = completedActions
    self.plannedActions = plannedActions
  }

  mutating func reset(dailySpoons: Int) {
    let carryOverSpoons = spentSpoons - (amountOfSpoons - carryOverSpoons)
    if carryOverSpoons > 0 {
      self.carryOverSpoons = carryOverSpoons
    } else {
      self.carryOverSpoons = 0
    }

    date = .now
    completedActions = []
    amountOfSpoons = dailySpoons
  }
}
