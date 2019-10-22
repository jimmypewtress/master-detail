import UIKit

protocol CandidateTableViewCell: class {
  func configure(with candidate: Candidate)
}

class CandidateTableViewCellImplementation: UITableViewCell {

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = 5
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(stackView)
    setUpConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpConstraints() {
    stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}

extension CandidateTableViewCellImplementation: CandidateTableViewCell {
  
  func configure(with candidate: Candidate) {
    stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})

    let topSpacer = UIView(frame: .zero)
    topSpacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
    stackView.addArrangedSubview(topSpacer)

    let nameLabel = UILabel(frame: .zero)
    nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
    nameLabel.text = candidate.name
    nameLabel.numberOfLines = 0
    stackView.addArrangedSubview(nameLabel)

    let emailLabel = UILabel(frame: .zero)
    emailLabel.font = UIFont.systemFont(ofSize: 17)
    emailLabel.text = candidate.email
    emailLabel.numberOfLines = 0
    stackView.addArrangedSubview(emailLabel)

    let scoreLabel = UILabel(frame: .zero)
    scoreLabel.font = UIFont.systemFont(ofSize: 15)
    scoreLabel.text = "Score: \(candidate.totalScore) points"
    stackView.addArrangedSubview(scoreLabel)

    let bottomSpacer = UIView(frame: .zero)
    bottomSpacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
    stackView.addArrangedSubview(bottomSpacer)
  }
}
