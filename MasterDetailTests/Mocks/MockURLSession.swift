import Foundation

class MockURLSession: URLSession {
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

  var data: Data?
  var error: Error?

  override func dataTask(with url: URL,
                         completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
    let data = self.data
    let error = self.error

    return MockURLSessionDataTask { completionHandler(data, nil, error)}
  }
}
