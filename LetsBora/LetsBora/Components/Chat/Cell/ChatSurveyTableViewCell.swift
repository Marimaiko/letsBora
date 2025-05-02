//
//  ChatSurveyTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/05/25.
//

import UIKit

class ChatSurveyTableViewCell: UITableViewCell {
    
    static let identifier = "ChatSurveyTableViewCell"
    
    struct cellLayout {
        static let marginHorizontal: CGFloat = 16
        static let marginVertical: CGFloat = 8
    }
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.borderWidth = 0.5
        
        return view
    }()
    
    let titleLabel = ReusableLabel(
        labelType: .h5
    )
    let subtitleLabel = ReusableLabel(
        labelType: .captionRegular,
        colorStyle: .tertiary
    )
    let winProgressSurvey = ChatProgressSurveyView()
    let loseProgressSurvey = ChatProgressSurveyView()
    let participantsLabel = ReusableLabel(
        labelType: .captionRegular,
        colorStyle: .tertiary
    )
    let deadlineLabel = ReusableLabel(
        labelType: .captionRegular,
        colorStyle: .tertiary
    )
    lazy var dateLabel = ReusableLabel(
        labelType: .caption,
        colorStyle: .tertiary
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGray6
        setupView()
        
    }
    func setupCell(with chat: Chat){
        
        titleLabel.text = chat.text
        subtitleLabel.text = chat.desciption ?? ""
        dateLabel.text = chat.date ?? ""
        
        guard let survey = chat.survey else { return }
        
        
        winProgressSurvey.setup(title: survey[0].title, vote: survey[0].votes, isActiveWin: true)
        loseProgressSurvey.setup(title: survey[1].title, vote: survey[1].votes, isActiveWin: false)
        
        participantsLabel.text = "12 participantes votaram"
        deadlineLabel.text = "Encerra em 7 dias"
        
    }
}
extension ChatSurveyTableViewCell: ViewCode  {
    func setHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(winProgressSurvey)
        containerView.addSubview(loseProgressSurvey)
        containerView.addSubview(participantsLabel)
        containerView.addSubview(deadlineLabel)
    }
    
    func setConstraints() {
        containerView
            .top(
                anchor: contentView.topAnchor,
                constant: cellLayout.marginVertical
            )
            .bottom(
                anchor: contentView.bottomAnchor,
                constant: -cellLayout.marginVertical
            )
            .leading(
                anchor: contentView.leadingAnchor,
                constant: cellLayout.marginHorizontal
            )
            .trailing(
                anchor: contentView.trailingAnchor,
                constant: -cellLayout.marginHorizontal
            )
            .height(anchor: titleLabel.heightAnchor,
                    constant: (
                        8 * cellLayout.marginVertical) + 10 * ChatProgressSurveyView.viewLayout.height
            )
        
        titleLabel
            .top (
                anchor: containerView.topAnchor,
                constant: cellLayout.marginVertical / 2
            )
            .leading(
                anchor: containerView.leadingAnchor, constant: cellLayout.marginHorizontal / 2)
        
        dateLabel
            .top (
                anchor: containerView.topAnchor,
                constant: cellLayout.marginVertical / 2
            )
            .trailing(
                anchor: containerView.trailingAnchor,
                constant: -cellLayout.marginHorizontal / 2
            )
        
        subtitleLabel
            .top(
                anchor: titleLabel.bottomAnchor,
                constant: cellLayout.marginVertical / 2
            )
            .leading(
                anchor: containerView.leadingAnchor,
                constant: cellLayout.marginHorizontal / 2)
        winProgressSurvey
            .top(
                anchor: subtitleLabel.bottomAnchor,
                constant: cellLayout.marginVertical
            )
            .leading(
                anchor: containerView.leadingAnchor,
                constant: cellLayout.marginHorizontal / 2
            )
            .trailing(
                anchor: containerView.trailingAnchor,
                constant: -cellLayout.marginHorizontal / 2
            )
        
        
        loseProgressSurvey
            .top(
                anchor: winProgressSurvey.bottomAnchor,
                constant: cellLayout.marginVertical
            )
            .leading(
                anchor: containerView.leadingAnchor,
                constant: cellLayout.marginHorizontal / 2
            )
            .trailing(
                anchor: containerView.trailingAnchor,
                constant: -cellLayout.marginHorizontal / 2
            )
        participantsLabel
            .top(anchor: loseProgressSurvey.bottomAnchor,
                 constant: cellLayout.marginVertical
            )
            .leading(
                anchor: containerView.leadingAnchor,
                constant: cellLayout.marginHorizontal / 2
            )
        
        deadlineLabel
            .top(anchor: loseProgressSurvey.bottomAnchor,
                 constant: cellLayout.marginVertical
            )
            .trailing(anchor: containerView.trailingAnchor,
            constant: -cellLayout.marginHorizontal / 2
            )
        
    }
    
    
}
@available(iOS 17.0, *)
#Preview("ChatSurveyCell", traits: .sizeThatFitsLayout) {
    let cell = ChatSurveyTableViewCell()
    cell.setupCell(with: MockData.chat7)
    return cell
    
}
// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    ChatViewController()
})

