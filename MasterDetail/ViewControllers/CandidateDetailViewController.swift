import Foundation
import UIKit

class CandidateDetailViewController: UIViewController {

  private let candidate: Candidate

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 15
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.boldSystemFont(ofSize: 28)
    label.text = candidate.name
    label.numberOfLines = 0
    return label
  }()

  private lazy var emailLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Email: \(candidate.email)"
    label.numberOfLines = 0
    return label
  }()

  private lazy var bioLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Bio: \(candidate.bio)"
    label.numberOfLines = 0
    return label
  }()

  private lazy var test1Label: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Test 1 Score: \(candidate.test1 ?? 0)"
    label.numberOfLines = 0
    return label
  }()

  private lazy var test2Label: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Test 2 Score: \(candidate.test2 ?? 0)"
    label.numberOfLines = 0
    return label
  }()

  private lazy var test3Label: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Test 3 Score: \(candidate.test3 ?? 0)"
    label.numberOfLines = 0
    return label
  }()

  // MARK: - Init

  init(candidate: Candidate) {
    self.candidate = candidate

    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor.white

    setUpStackView()
    view.addSubview(stackView)

    setUpConstraints()

    title = candidate.name
  }

  // MARK: - UI Setup

  private func setUpStackView() {
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(emailLabel)
    stackView.addArrangedSubview(bioLabel)
    stackView.addArrangedSubview(test1Label)
    stackView.addArrangedSubview(test2Label)
    stackView.addArrangedSubview(test3Label)
  }

  private func setUpConstraints() {
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
}
