//  Created by Dominik Hauser on 22.04.23.
//  
//

import Foundation

class ActionStore: ObservableObject {
  @Published var day: Day = Day(date: .now, amountOfSpoons: 12)
  @Published var allActions: [Action] = []
}
