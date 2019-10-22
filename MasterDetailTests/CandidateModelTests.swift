import XCTest

@testable import MasterDetail

class CandidateModelTests: XCTestCase {

  var sut1: Candidate!
  var sut2: Candidate!
  var sut3: Candidate!

    override func setUp() {
      sut1 = Candidate(name: "Jimmy Pewtress",
                      email: "jimmy@pewtress.com",
                      bio: "I've been building iOS apps since 2010!",
                      test1: 98.0,
                      test2: 99.0,
                      test3: 100.0)

      sut2 = Candidate(name: "Taylor Swift",
                       email: "taylor@swift.com",
                       bio: "I'm better at singing than coding to be honest.",
                       test1: 10.0,
                       test2: 20.0,
                       test3: 30.0)

      sut3 = Candidate(name: "Elvis Presley",
                       email: "elvis@presley.com",
                       bio: "I'm dead so haven't been able to take any of the tests unfortunately.",
                       test1: nil,
                       test2: nil,
                       test3: nil)
    }

    override func tearDown() {
      sut1 = nil
      sut2 = nil
      sut3 = nil
    }

    func testCandidateModel() {
      XCTAssertEqual(sut1.name, "Jimmy Pewtress")
      XCTAssertEqual(sut1.email, "jimmy@pewtress.com")
      XCTAssertEqual(sut1.bio, "I've been building iOS apps since 2010!")
      XCTAssertEqual(sut1.test1, 98.0)
      XCTAssertEqual(sut1.test2, 99.0)
      XCTAssertEqual(sut1.test3, 100.0)
      XCTAssertEqual(sut1.totalScore, 297.0)
      XCTAssertEqual(sut3.totalScore, 0)

      let ascendingArray = [sut1, sut2].sorted(by: <)
      XCTAssertEqual(ascendingArray[0], sut2)

      let descendingArray = [sut1, sut2].sorted(by: >)
      XCTAssertEqual(descendingArray[0], sut1)
    }
}
