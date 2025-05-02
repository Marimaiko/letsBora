//
//  ParticipantesCard.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 01/05/25.
//

import UIKit

class ParticipantCard: UIView{
    
    let imageSize: CGFloat = 40
    let fontSize: CGFloat = 16
    
    //MARK: Components
    private lazy var containerParticipant: UIView = {
        let participantView = UIView()
        participantView.translatesAutoresizingMaskIntoConstraints = false
        participantView.backgroundColor = .white
        participantView.layer.cornerRadius = 8
        participantView.layer.shadowColor = UIColor.black.cgColor
        participantView.layer.shadowOpacity = 0.1
        participantView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return participantView
    }()
    
    private lazy var imageParticipant: UIImageView = {
        let image = UIImageView(image: .julia)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        return image
    }()
    
    private lazy var titleParticipant: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Ana Clara"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: fontSize)
        
        return title
    }()
    
    private lazy var statusPayment: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Pago"
        if status.text == "Pago"{
            status.textColor = .systemGreen
        }else {
            status.textColor = .red
        }
        status.font = UIFont.systemFont(ofSize: fontSize)
        
        return status
    }()
    
    private lazy var valueParticipant: UILabel = {
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.text = "R$50,00"
        value.textColor = .darkGray
        value.font = UIFont.systemFont(ofSize: 22)
        
        return value
    }()
    
    //MARK: Init
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Hierarchy/Constraints
extension ParticipantCard: ViewCode{
    func setHierarchy() {
        addSubview(containerParticipant)
        containerParticipant.addSubview(imageParticipant)
        containerParticipant.addSubview(titleParticipant)
        containerParticipant.addSubview(statusPayment)
        containerParticipant.addSubview(valueParticipant)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerParticipant.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            containerParticipant.heightAnchor.constraint(equalToConstant: 60),
            containerParticipant.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerParticipant.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            imageParticipant.leadingAnchor.constraint(equalTo: containerParticipant.leadingAnchor, constant: 10),
            imageParticipant.centerYAnchor.constraint(equalTo: containerParticipant.centerYAnchor),
            
            titleParticipant.topAnchor.constraint(equalTo: containerParticipant.topAnchor, constant: 10),
            titleParticipant.leadingAnchor.constraint(equalTo: imageParticipant.trailingAnchor, constant: 10),
            
            statusPayment.bottomAnchor.constraint(equalTo: containerParticipant.bottomAnchor, constant: -10),
            statusPayment.leadingAnchor.constraint(equalTo: imageParticipant.trailingAnchor, constant: 10),
            
            valueParticipant.centerYAnchor.constraint(equalTo: containerParticipant.centerYAnchor),
            valueParticipant.trailingAnchor.constraint(equalTo: containerParticipant.trailingAnchor, constant: -10)
            
        ])
    }
}

//MARK: -Preview
@available(iOS 17.0, *)
#Preview("ParticipantCard", traits: .sizeThatFitsLayout) {
    let participantCard = ParticipantCard()
    participantCard
}
