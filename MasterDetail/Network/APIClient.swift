import Foundation

protocol APIClient {

  var baseURL: String { get }

  func fetchCandidates(completion: @escaping (String?, [Candidate]?) -> Void)
}
