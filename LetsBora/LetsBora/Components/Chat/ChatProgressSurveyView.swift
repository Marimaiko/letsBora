//
//  ChatProgressSurveyView.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/05/25.
//

import UIKit

class ChatProgressSurveyView: UIView {
    struct viewLayout{
        static let height: CGFloat = 12
        static let marginVertical:CGFloat = 8
        static let marginHorizontal:CGFloat = 16
    }
   
    private let titleLabel = ReusableLabel(labelType: .body)
    private let voteLabel = ReusableLabel(labelType: .caption)
    private let progressBar = ProgressBar()

    
    private lazy var container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    private func setupUI() {
        setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
    }
    func setup(title: String, vote: String, isActiveWin: Bool){
        titleLabel.text = title
        voteLabel.text = vote
        
        progressBar.isActiveComponent = isActiveWin
        
        if isActiveWin{
            container.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            voteLabel.textColor = .systemBlue
        }else{
            container.backgroundColor = .clear
        }
        
        
      
    }
   
}
extension ChatProgressSurveyView : ViewCode{
    func setHierarchy() {
        addSubview(container)
        
        container.addSubview(titleLabel)
        container.addSubview(progressBar)
        container.addSubview(voteLabel)
    }
    
    func setConstraints() {
        container
            .height(
                anchor: titleLabel.heightAnchor,
                constant: viewLayout.marginVertical*4 + viewLayout.height
            )
            .setContraintsToParent(self)
           
        
        titleLabel
            .top(
                anchor: container.topAnchor,
                constant: viewLayout.marginVertical
            )
            .leading(
                anchor: container.leadingAnchor,
                constant: viewLayout.marginHorizontal
            )
            .trailing(anchor: container.trailingAnchor)
        
        progressBar
            .top(
                anchor: titleLabel.bottomAnchor,
                constant: viewLayout.marginVertical
            )
            .leading(
                anchor: container.leadingAnchor,
                constant: viewLayout.marginHorizontal
            )
            .trailing(
                anchor: container.trailingAnchor,
                constant: -viewLayout.marginHorizontal
            )
            .bottom(
                anchor: container.bottomAnchor,
                constant: -viewLayout.marginVertical*2
            )
        
        voteLabel
            .top(
                anchor: container.topAnchor,
                constant: viewLayout.marginVertical
            )
            .trailing(
                anchor: container.trailingAnchor,
                constant: -viewLayout.marginHorizontal
            )

        
    
       
    }
}

@available(iOS 17.0, *)
#Preview("ChatSurveyCell2", traits: .sizeThatFitsLayout) {
    let cell = ChatSurveyTableViewCell()
    cell.setupCell(with: MockData.chat7)
    return cell
        
}
