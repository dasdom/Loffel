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
  var completedSpoons: Int {
    return completedActions
      .filter({ $0.spoons > 0})
      .reduce(0) { partialResult, action in
        return partialResult + action.spoons
      }
  }
  var completedSpoonSources: Int {
    return completedActions
      .filter({ $0.spoons < 0})
      .reduce(0) { partialResult, action in
        return partialResult - action.spoons
      }
  }
  var plannedSpoons: Int {
    return plannedActions
      .filter({ $0.spoons > 0})
      .reduce(0) { partialResult, action in
        return partialResult + action.spoons
      }
  }
  var plannedSpoonSources: Int {
    return plannedActions
      .filter({ $0.spoons < 0})
      .reduce(0) { partialResult, action in
        return partialResult - action.spoons
      }
  }
  var availableSpoons: Int {
    return realAmountOfSpoons - completedSpoons
  }
  var plannedString: String {
    var string = "\(plannedSpoons)"
    if carryOverSpoons > 0 {
      string.append("-\(carryOverSpoons)")
    }
    string.append("/\(realAmountOfSpoons)")
    return string
  }
  var completedString: String {
    var string = "\(completedSpoons)"
    if carryOverSpoons > 0 {
      string.append("-\(carryOverSpoons)")
    }
    string.append("/\(realAmountOfSpoons)")
    return string
  }
  var realAmountOfSpoons: Int {
    return amountOfSpoons + plannedSpoonSources
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
    let carryOverSpoons = completedSpoons - (amountOfSpoons - carryOverSpoons)
    if carryOverSpoons > 0 {
      self.carryOverSpoons = carryOverSpoons
    } else {
      self.carryOverSpoons = 0
    }

    date = .now
    completedActions = []
    amountOfSpoons = dailySpoons
  }

  mutating func plan(action: Action) {
    if (false == plannedActions.contains(where: { $0.id == action.id })) {
      plannedActions.append(action)
    }
  }

  mutating func unplan(action: Action) {
    plannedActions.removeAll(where: { $0.id == action.id })
  }
}
