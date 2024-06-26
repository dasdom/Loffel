//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Action: Codable, Identifiable, Hashable {
  let id: UUID
  //  let originId: UUID?
  let name: String
  var spoons: Int = 1
  //  var isHeader: Bool = false
  var actionType: ActionType {
    if spoons > 0 {
      return .sink
    } else {
      return .source
    }
  }

  init(id: UUID = UUID(), name: String, spoons: Int = 1, isHeader: Bool = false) {
    self.id = id
    self.name = name
    self.spoons = spoons
    //    self.isHeader = isHeader
  }

  static func ==(lhs: Action, rhs: Action) -> Bool {
    if lhs.id != rhs.id {
      return false
    }
    return true
  }
}
