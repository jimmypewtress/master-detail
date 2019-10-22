import Foundation

class CandidateAPIClient: APIClient {

  var baseURL: String

  let urlSession: URLSession
  var listDataTask: URLSessionDataTask?

  init(baseURL: String, urlSession: URLSession = URLSession(configuration: .ephemeral)) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func fetchCandidates(completion: @escaping (String?, [Candidate]?) -> Void) {
    listDataTask?.cancel()

    if let candidatesUrl = URL(string: "\(baseURL)raw/56tv0pgs") {

      listDataTask = urlSession.dataTask(with: candidatesUrl) { data, response, error in
        defer { self.listDataTask = nil }

        if let error = error {
          completion(error.localizedDescription, nil)
        } else if let data = data {
          do {
            let candidatesResponse = try JSONDecoder().decode([Candidate].self, from: data)
            completion(nil, candidatesResponse)
          } catch {
            completion("There was a problem decoding the data", nil)
          }
        } else {
          completion("No data was returned", nil)
        }
      }

      listDataTask?.resume()
    } else {
      completion("Invalid URL", nil)
    }
  }
}
