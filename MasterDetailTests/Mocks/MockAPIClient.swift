import Foundation
import UIKit

@testable import MasterDetail

enum MockAPIConfig {
  case happyPath
  case errorMessage
  case noResults
}

class MockAPIClient: APIClient {

  var baseURL: String = "https://www.bbc.com"
  var config: MockAPIConfig = .happyPath

  func fetchCandidates(completion: @escaping (String?, [Candidate]?) -> Void) {
    switch config {
    case .happyPath:
      completion(nil, [
        Candidate(name: "Joe Bloggs",
                  email: "joe@bloggs.com",
                  bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  test1: 10.0,
                  test2: 25.0,
                  test3: 34.0),
        Candidate(name: "Jane Doe",
                  email: "jane@doe.com",
                  bio: "Elementum tempus egestas sed sed. Vel facilisis volutpat est velit egestas dui.",
                  test1: 50.0,
                  test2: 85.0,
                  test3: 94.0)

        ])
    case .errorMessage:
      completion("mockError", nil)
    case .noResults:
      completion(nil, nil)
    }
  }
}
