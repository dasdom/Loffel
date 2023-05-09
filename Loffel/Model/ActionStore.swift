//  Created by Dominik Hauser on 23.04.23.
//  
//

import Foundation
import Combine

class ActionStore: ObservableObject {
  @Published var allActions: [Action] = []
  private var allActionsPublisherToken: AnyCancellable?

  init() {
    allActions = FileManager.default.actions()

    allActionsPublisherToken = $allActions
      .sink { actions in
        FileManager.default.save(actions: actions)
      }
  }

  func filter(_ searchText: String) -> [Action] {
    if searchText.isEmpty {
      return allActions
    } else {
      return allActions.filter({ $0.name.contains(searchText) })
    }
  }

  func addOrReplace(action: Action) {
    if let index = allActions.firstIndex(where: { $0.id == action.id }) {
      allActions[index] = action
    } else {
      allActions.append(action)
    }
    FileManager.default.save(actions: allActions)
  }

  func remove(action: Action) {
    allActions.removeAll(where: { $0.id == action.id })
    FileManager.default.save(actions: allActions)
  }
}
