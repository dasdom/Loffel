//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Action: Codable, Identifiable, Hashable {
  var id: UUID = UUID()
  let name: String
  var spoons: Int = 1
  var isHeader: Bool = false
}
