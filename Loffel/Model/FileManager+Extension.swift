//  Created by Dominik Hauser on 14.04.23.
//  
//

import Foundation

extension FileManager {
  private func actionsURL() -> URL {
    let url = URL.documentsDirectory
    return url.appending(component: "actions.json")
  }

  private func dayURL() -> URL {
    let url = URL.documentsDirectory
    return url.appending(component: "day.json")
  }

  func actions() -> [Action] {
    do {
      let data = try Data(contentsOf: actionsURL())
      return try JSONDecoder().decode([Action].self, from: data)
    } catch {
      print("\(#file), \(#line): \(error)")
      return []
    }
  }

  func safe(actions: [Action]) {
    do {
      let data = try JSONEncoder().encode(actions)
      try data.write(to: actionsURL())
    } catch {
      print("\(#file), \(#line): \(error)")
    }
  }

  func day() -> Day {
    do {
      let data = try Data(contentsOf: dayURL())
      return try JSONDecoder().decode(Day.self, from: data)
    } catch {
      print("\(#file), \(#line): \(error)")
      return Day(date: .now, amountOfSpoons: 12)
    }
  }

  func safe(day: Day) {
    do {
      let data = try JSONEncoder().encode(day)
      try data.write(to: dayURL())
    } catch {
      print("\(#file), \(#line): \(error)")
    }
  }
}
