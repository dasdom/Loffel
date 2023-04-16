//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Day: Codable, Equatable {
  var date: Date
  var amountOfSpoons: Int
  var completedActions: [Action] = []
  var plannedActions: [Action] = []

  mutating func reset() {
    date = .now
    completedActions = []
  }
}
