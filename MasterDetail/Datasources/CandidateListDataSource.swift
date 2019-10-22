import Foundation
import UIKit

class CandidateListDatasource: NSObject, UITableViewDataSource {

  private let apiClient: APIClient

  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  var candidates: [Candidate] = []

  func refreshCandidateList(completion: @escaping (String?) -> Void) {
    apiClient.fetchCandidates { (errorMessage, candidates) in
      if errorMessage != nil {
        completion(errorMessage)
      } else if let candidates = candidates {
        self.candidates = candidates.sorted(by: >)
        completion(nil)
      } else {
        completion("No candidates were returned")
      }
    }
  }

  func candidateForIndexPath(_ indexPath: IndexPath) -> Candidate? {
    var candidate: Candidate? = nil

    if indexPath.row < candidates.count {
      candidate = candidates[indexPath.row]
    }

    return candidate
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return candidates.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CandidateCell", for: indexPath)
    let candidateForThisCell = candidates[indexPath.row]
    
    (cell as? CandidateTableViewCell)?.configure(with: candidateForThisCell)
    
    cell.layoutIfNeeded()
    
    return cell
  }
}

