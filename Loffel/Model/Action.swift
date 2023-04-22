//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Action: Codable, Identifiable, Hashable {
  let id: UUID
  let name: String
  var spoons: Int = 1
  var isHeader: Bool = false

  init(id: UUID = UUID(), name: String, spoons: Int = 1, isHeader: Bool = false) {
    self.id = id
    self.name = name
    self.spoons = spoons
    self.isHeader = isHeader
  }
}
