//  Created by Dominik Hauser on 13.04.23.
//  
//

import Foundation

struct Action: Codable, Identifiable, Hashable {
  let name: String
  let spoons: Int
  var id: String {
    return name
  }
}
