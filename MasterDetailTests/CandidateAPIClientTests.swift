import XCTest

@testable import MasterDetail

class CandidateAPIClientTests: XCTestCase {

  let validResponseJson = """
                          [
                            {
                            "name": "John Smith",
                            "email": "john@smith.com",
                            "bio": "Hey, my name is John. I am very good at programming.",
                            "test1": 1.0,
                            "test2": 0.0,
                            "test3": 1.0
                            },

                            {
                            "name": "Megan Goldbaum",
                            "email": "megan@shell.com",
                            "bio": "Hey, my name is Megan. I am an excellent iOS developer with more than 10 years of experience in oil industry.",
                            "test1": 100.0,
                            "test2": 20.0,
                            "test3": 1.0
                            },


                            {
                            "name": "Luke Skywalker",
                            "email": "luke@rebellion.com",
                            "bio": "I used the force to solve those challenges. It was fantastic. 112358 is my number.",
                            "test1": 100.0,
                            "test2": 100.0,
                            "test3": 100.0
                            }
                          ]
                          """

  let invalidResponseJson = """
                          [
                            {
                            "xxx": "John Smith",
                            "email": "john@smith.com",
                            "bio": "Hey, my name is John. I am very good at programming.",
                            "test1": 1.0,
                            "test2": 0.0,
                            "test3": 1.0
                            }
                          ]
                          """

  var mockUrlSession: MockURLSession?


  override func setUp() {
    mockUrlSession = MockURLSession()
  }

  override func tearDown() {
    mockUrlSession = nil
  }

  func testApiClientSuccess() {
    mockUrlSession!.data = validResponseJson.data(using: .utf8)

    let sut = CandidateAPIClient(baseURL: "https://www.bbc.com", urlSession: mockUrlSession!)

    sut.fetchCandidates { (errorMessage, candidates) in
      XCTAssertEqual(candidates?.count, 3)
    }
  }

  func testApiClientError() {
    let errorText = "Something's gone horribly wrong"
    let nsError = NSError(domain:"", code: 500, userInfo:[ NSLocalizedDescriptionKey: errorText])
    mockUrlSession!.error = nsError as Error

    let sut = CandidateAPIClient(baseURL: "https://www.bbc.com", urlSession: mockUrlSession!)

    sut.fetchCandidates { (errorMessage, candidates) in
      XCTAssertEqual(errorMessage, errorText)
    }
  }

  func testApiClientMalformedJson() {
    let errorText = "There was a problem decoding the data"

    mockUrlSession!.data = invalidResponseJson.data(using: .utf8)

    let sut = CandidateAPIClient(baseURL: "https://www.bbc.com", urlSession: mockUrlSession!)

    sut.fetchCandidates { (errorMessage, candidates) in
      XCTAssertEqual(errorMessage, errorText)
    }
  }

  func testApiClientNoDataReturned() {
    let errorText = "No data was returned"

    let sut = CandidateAPIClient(baseURL: "https://www.bbc.com", urlSession: mockUrlSession!)

    sut.fetchCandidates { (errorMessage, candidates) in
      XCTAssertEqual(errorMessage, errorText)
    }
  }

  func testApiClientInvalidUrl() {
    let errorText = "Invalid URL"

    let sut = CandidateAPIClient(baseURL: "åéîøü", urlSession: mockUrlSession!)

    sut.fetchCandidates { (errorMessage, candidates) in
      XCTAssertEqual(errorMessage, errorText)
    }
  }
}
