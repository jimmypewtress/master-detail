import XCTest

@testable import MasterDetail

class CandidateDataSourceTests: XCTestCase {

  func sutWithApiConfig(_ config: MockAPIConfig) -> CandidateListDatasource {
    let apiClient = MockAPIClient()
    apiClient.config = config

    return CandidateListDatasource(apiClient: apiClient)
  }

  func testCandidateListDatasourceHappyPath() {

    let sut = sutWithApiConfig(.happyPath)

    let tableViewController = CandidateListTableViewController(dataSource: sut)
    let tableView = tableViewController.tableView!

    let indexPath = IndexPath(row: 0, section: 0)
    let testCandidate = Candidate(name: "Jane Doe",
                                  email: "jane@doe.com",
                                  bio: "Elementum tempus egestas sed sed. Vel facilisis volutpat est velit egestas dui.",
                                  test1: 50.0,
                                  test2: 85.0,
                                  test3: 94.0)

    sut.refreshCandidateList { (errorMessage) in }

    let candidate1 = sut.candidateForIndexPath(indexPath)

    XCTAssertNotNil(candidate1)
    XCTAssertEqual(candidate1!, testCandidate)

    XCTAssertEqual(sut.numberOfSections(in: tableView), 1)

    XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 0), 2)
    XCTAssertTrue((sut.tableView(tableView, cellForRowAt: indexPath) as Any) is CandidateTableViewCell)
  }

  func testCandidateListDatasourceError() {
    let sut = sutWithApiConfig(.errorMessage)

    sut.refreshCandidateList { (errorMessage) in
      XCTAssertEqual(errorMessage, "mockError")
    }
  }

  func testCandidateListDatasourceNoResults() {
    let sut = sutWithApiConfig(.noResults)

    sut.refreshCandidateList { (errorMessage) in
      XCTAssertEqual(errorMessage, "No candidates were returned")
    }
  }
}
