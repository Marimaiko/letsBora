import UIKit
import FSCalendar

class CreateEventViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    //MARK: - UIComponents
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar Evento"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var nameEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome do evento"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return textField
    }()

    private lazy var descriptionEventTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Descrição"
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        textView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        return textView
    }()
    
    //Data e Hora <--
    private lazy var dateTextField: UITextField = {
           let textField = UITextField()
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.borderStyle = .roundedRect
           textField.textColor = .black
           textField.font = UIFont.systemFont(ofSize: 16)
           textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

           // Criando o container para o ícone do calendário e a label
           let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

           // Ícone do calendário
           let calendarIcon = UIImageView(image: UIImage(systemName: "calendar"))
           calendarIcon.translatesAutoresizingMaskIntoConstraints = false
           calendarIcon.contentMode = .scaleAspectFit
           calendarIcon.tintColor = .black

           // Label "Data e Hora"
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Data e Hora"
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 16)

           // StackView para o ícone e label
           let leftStackView = UIStackView(arrangedSubviews: [calendarIcon, label])
           leftStackView.translatesAutoresizingMaskIntoConstraints = false
           leftStackView.axis = .horizontal
           leftStackView.spacing = 6
           leftStackView.alignment = .center

           leftContainerView.addSubview(leftStackView)

           NSLayoutConstraint.activate([
               leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
               leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
               leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

               calendarIcon.widthAnchor.constraint(equalToConstant: 20),
               calendarIcon.heightAnchor.constraint(equalToConstant: 20)
           ])

           // Definir o stack como leftView
           textField.leftView = leftContainerView
           textField.leftViewMode = .always

           // Criando a seta à direita
           let arrowContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 42))
           let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
           arrowIcon.translatesAutoresizingMaskIntoConstraints = false
           arrowIcon.contentMode = .scaleAspectFit
           arrowIcon.tintColor = .gray

           arrowContainerView.addSubview(arrowIcon)

           NSLayoutConstraint.activate([
               arrowIcon.trailingAnchor.constraint(equalTo: arrowContainerView.trailingAnchor, constant: -16),
               arrowIcon.centerYAnchor.constraint(equalTo: arrowContainerView.centerYAnchor),
               arrowIcon.widthAnchor.constraint(equalToConstant: 14),
               arrowIcon.heightAnchor.constraint(equalToConstant: 14)
           ])

           // Definir o ícone como rightView
           textField.rightView = arrowContainerView
           textField.rightViewMode = .always

           // Adicionar ação ao tocar no campo
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
           textField.addGestureRecognizer(tapGesture)
           
           return textField
       }()

       private let calendarContainerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .white
           view.layer.cornerRadius = 10
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOpacity = 0.2
           view.layer.shadowOffset = CGSize(width: 0, height: 2)
           view.isHidden = true
           return view
       }()

       private let calendar: FSCalendar = {
           let calendar = FSCalendar()
           calendar.translatesAutoresizingMaskIntoConstraints = false
           calendar.appearance.headerTitleColor = .systemBlue
           calendar.appearance.weekdayTextColor = .darkGray
           calendar.appearance.selectionColor = .systemRed
           calendar.locale = Locale(identifier: "pt_BR")
           return calendar
       }()

       private let timePicker: UIDatePicker = {
           let picker = UIDatePicker()
           picker.translatesAutoresizingMaskIntoConstraints = false
           picker.datePickerMode = .time
           picker.preferredDatePickerStyle = .wheels
           return picker
       }()

        private lazy var confirmButton: UIButton = {
           let button = UIButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Confirmar", for: .normal)
           button.setTitleColor(.systemBlue, for: .normal)
           button.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
           button.layer.cornerRadius = 8
           button.heightAnchor.constraint(equalToConstant: 44).isActive = true
           button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
           button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
           return button
       }()
    
    //Localização <--
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // Criando o container para o ícone da localização e a label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        // Ícone da localização
        let locationIcon = UIImageView(image: UIImage(systemName: "pin"))
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.tintColor = .black

        // Label "Data e Hora"
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Localização"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        // Criando um StackView para o ícone e label
        let leftStackView = UIStackView(arrangedSubviews: [locationIcon, label])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center

        leftContainerView.addSubview(leftStackView)

        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Definir o stack como leftView
        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Criando a seta à direita
        let arrowContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 42)) // Garante altura correta
        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .gray

        arrowContainerView.addSubview(arrowIcon)

        NSLayoutConstraint.activate([
            arrowIcon.trailingAnchor.constraint(equalTo: arrowContainerView.trailingAnchor, constant: -16),
            arrowIcon.centerYAnchor.constraint(equalTo: arrowContainerView.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 14),
            arrowIcon.heightAnchor.constraint(equalToConstant: 14)
        ])

        // Definir o ícone como rightView
        textField.rightView = arrowContainerView
        textField.rightViewMode = .always

        return textField
    }()
    
    private let locationContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.isHidden = true
        return view
    }()
    
    //Categoria <--
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // Criando o container para o ícone da Categoria e a label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        // Ícone da localização
        let categoryIcon = UIImageView(image: UIImage(systemName: "face.smiling"))
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        categoryIcon.contentMode = .scaleAspectFit
        categoryIcon.tintColor = .black

        // Label "Categoria"
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Categoria"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        // Criando um StackView para o ícone e label
        let leftStackView = UIStackView(arrangedSubviews: [categoryIcon, label])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center

        leftContainerView.addSubview(leftStackView)

        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

            categoryIcon.widthAnchor.constraint(equalToConstant: 20),
            categoryIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Definir o stack como leftView
        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Criando a seta à direita
        let arrowContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 42)) // Garante altura correta
        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .gray

        arrowContainerView.addSubview(arrowIcon)

        NSLayoutConstraint.activate([
            arrowIcon.trailingAnchor.constraint(equalTo: arrowContainerView.trailingAnchor, constant: -16),
            arrowIcon.centerYAnchor.constraint(equalTo: arrowContainerView.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 14),
            arrowIcon.heightAnchor.constraint(equalToConstant: 14)
        ])

        // Definir o ícone como rightView
        textField.rightView = arrowContainerView
        textField.rightViewMode = .always

        return textField
    }()
    
    private let categoryContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.isHidden = true // Inicialmente escondido
        return view
    }()
    
    //Público/Privado <--
    private lazy var publicOrPrivateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // Criando o container para o ícone e o label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        // Ícone de cadeado (evento privado)
        let categoryIcon = UIImageView(image: UIImage(systemName: "lock"))
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        categoryIcon.contentMode = .scaleAspectFit
        categoryIcon.tintColor = .black

        // Label "Evento Privado"
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Evento Privado"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        // Criando um StackView para o ícone e o label
        let leftStackView = UIStackView(arrangedSubviews: [categoryIcon, label])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center

        leftContainerView.addSubview(leftStackView)

        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

            categoryIcon.widthAnchor.constraint(equalToConstant: 20),
            categoryIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Definir o stack como leftView
        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Criando um container para o UISwitch
        let switchContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 42))

        // Criando o UISwitch
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false
        toggleSwitch.onTintColor = .systemBlue
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false

        switchContainerView.addSubview(toggleSwitch)

        // Posicionando o switch afastado da borda direita
        NSLayoutConstraint.activate([
            toggleSwitch.centerYAnchor.constraint(equalTo: switchContainerView.centerYAnchor),
            toggleSwitch.leadingAnchor.constraint(equalTo: switchContainerView.leadingAnchor, constant: 304) // Afastamento da direita
        ])

        // Definir o switch como rightView do textField
        textField.rightView = switchContainerView
        textField.rightViewMode = .always

        return textField
    }()

    
    private let publicOrPrivateContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.isHidden = true // Inicialmente escondido
        return view
    }()
    
    //Convidar participantes <-
    private lazy var participantsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // Ícone
        let iconImageView = UIImageView(image: UIImage(systemName: "person"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .black
        
        // Label "Participantes"
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Participantes"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        // Botão "Convidar"
        let inviteButton = UIButton(type: .system)
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.setTitle("Convidar", for: .normal)
        inviteButton.setTitleColor(.systemBlue, for: .normal)
        
        // Stack para ícone e label
        let titleStackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.spacing = 6
        titleStackView.alignment = .center
        
        // Stack horizontal para organizar tudo
        let topStackView = UIStackView(arrangedSubviews: [titleStackView, inviteButton])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        topStackView.spacing = 10
        topStackView.alignment = .center
        topStackView.distribution = .equalSpacing
        
        containerView.addSubview(topStackView)
        
        // Stack para as imagens dos participantes
        let participantsStackView = UIStackView()
        participantsStackView.translatesAutoresizingMaskIntoConstraints = false
        participantsStackView.axis = .horizontal
        participantsStackView.spacing = 8
        participantsStackView.alignment = .center
        
        // Adicionando imagens de exemplo (substituir por dados reais depois)
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 16 // Arredondando as imagens
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray // Cor temporária para teste
            imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
            participantsStackView.addArrangedSubview(imageView)
        }
        
        containerView.addSubview(participantsStackView)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            participantsStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            participantsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            participantsStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10),
            participantsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        return containerView
    }()
    
    //Botões <--
    private lazy var actionButtonsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear // Fundo transparente
        
        // Botão Confirmar
        let confirmButton = UIButton(type: .system)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("Publicar Evento", for: .normal)
        confirmButton.setTitleColor(.systemBlue, for: .normal)
        confirmButton.backgroundColor = .clear
        confirmButton.layer.cornerRadius = 4
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmButton.layer.shadowColor = UIColor.black.cgColor
        confirmButton.layer.shadowOpacity = 0.2
        confirmButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        confirmButton.layer.shadowRadius = 4
        
        // Botão Salvar Rascunho
        let draftButton = UIButton(type: .system)
        draftButton.translatesAutoresizingMaskIntoConstraints = false
        draftButton.setTitle("Salvar Rascunho", for: .normal)
        draftButton.setTitleColor(.black, for: .normal)
        draftButton.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 239/255, alpha: 1.0)
        draftButton.layer.cornerRadius = 4
        draftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        draftButton.layer.shadowColor = UIColor.black.cgColor
        draftButton.layer.shadowOpacity = 0.2
        draftButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        draftButton.layer.shadowRadius = 4
        
        // StackView para alinhar os botões lado a lado
        let buttonStackView = UIStackView(arrangedSubviews: [draftButton, confirmButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        
        containerView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 26),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return containerView
    }()


    private lazy var stackView: UIStackView = createStackView(
        subViews: [
            titleLabel,
            nameEventTextField,
            descriptionEventTextView,
            dateTextField,
            locationTextField,
            categoryTextField,
            publicOrPrivateTextField,
            participantsView,
            actionButtonsView,
        ],
        spacing: 16
    )

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        // Adiciona o calendário na tela
        view.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendar)
        calendarContainerView.addSubview(timePicker)
        calendarContainerView.addSubview(confirmButton)

        // Configura o calendário
        calendar.delegate = self
        calendar.dataSource = self

        // Adiciona a toolbar ao teclado *OBS*
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Concluído", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        
        // Coloca as constraints após adicionar as views
        setupLayout()

        // Gestos de toque para mostrar o calendário
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        dateTextField.addGestureRecognizer(tapGesture)
    }

    //MARK: - Setup View
    private func setupLayout() {
        view.addSubview(stackView)
        
        // Configurar a posição do stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Adicionar elementos ao calendário
           calendarContainerView.addSubview(calendar)
           calendarContainerView.addSubview(timePicker)
           calendarContainerView.addSubview(confirmButton)
           
           // Configurar o layout do calendário
           NSLayoutConstraint.activate([
               calendarContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               calendarContainerView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10),
               calendarContainerView.widthAnchor.constraint(equalToConstant: 300),
               calendarContainerView.bottomAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 16), // Ajustando a altura automaticamente

               // Layout do calendário
               calendar.topAnchor.constraint(equalTo: calendarContainerView.topAnchor, constant: 16),
               calendar.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
               calendar.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
               calendar.heightAnchor.constraint(equalToConstant: 250),

               // Layout do seletor de hora
               timePicker.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 8),
               timePicker.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
               timePicker.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
               timePicker.heightAnchor.constraint(equalToConstant: 100),

               // Layout do botão de confirmação
               confirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 8),
               confirmButton.centerXAnchor.constraint(equalTo: calendarContainerView.centerXAnchor),
               confirmButton.widthAnchor.constraint(equalToConstant: 200),
               confirmButton.heightAnchor.constraint(equalToConstant: 44),
           ])    }
    
    //Função para gerar a stack
    private func createStackView(subViews: [UIView], spacing: CGFloat = 8) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = .fill
        return stackView
    }

    // Função para mostrar o calendário
    @objc private func showCalendar() {
        calendarContainerView.isHidden = false
        view.bringSubviewToFront(calendarContainerView)
    }

    // Função para fechar o calendário
    @objc private func doneButtonTapped() {
        view.endEditing(true)
        
        calendarContainerView.isHidden = true
    }

    // Método chamado quando uma data é selecionada
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: date)
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})

