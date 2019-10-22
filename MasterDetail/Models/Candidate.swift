import Foundation

public struct Candidate: Decodable {
  let name: String
  let email: String
  let bio: String
  let test1: Float?
  let test2: Float?
  let test3: Float?

  var totalScore: Float {
    let test1Score = test1 ?? 0, test2Score = test2 ?? 0, test3Score = test3 ?? 0
    return test1Score + test2Score + test3Score
  }
}

extension Candidate: Comparable {
  public static func < (lhs: Candidate, rhs: Candidate) -> Bool {
    return lhs.totalScore < rhs.totalScore
  }

  public static func > (lhs: Candidate, rhs: Candidate) -> Bool {
    return lhs.totalScore > rhs.totalScore
  }
}
