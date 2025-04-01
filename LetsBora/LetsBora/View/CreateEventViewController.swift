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

    private lazy var descriptionEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Descrição"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 108).isActive = true
        return textField
    }()

    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.headerTitleColor = .systemBlue
        calendar.appearance.weekdayTextColor = .darkGray
        calendar.appearance.selectionColor = .systemRed
        calendar.appearance.headerTitleOffset = CGPoint(x: 75, y: 0)
        calendar.locale = Locale(identifier: "pt_BR")
        return calendar
    }()

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // Criando o container para o ícone do calendário e a label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42)) // Define uma altura igual ao textField

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

        // Criando um StackView para o ícone e label
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

    private let calendarContainerView: UIView = {
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

    private lazy var stackView: UIStackView = createStackView(
        subViews: [
            titleLabel,
            nameEventTextField,
            descriptionEventTextField,
            dateTextField
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
        
        // Configurar o layout do calendário
        NSLayoutConstraint.activate([
            calendarContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarContainerView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10), // Posição abaixo do textField
            calendarContainerView.widthAnchor.constraint(equalToConstant: 300),
            calendarContainerView.heightAnchor.constraint(equalToConstant: 350),
            calendar.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
        ])
    }

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
    }

    // Função para fechar o calendário
    @objc private func doneButtonTapped() {
        view.endEditing(true) // Fecha o teclado
    }

    // Método chamado quando uma data é selecionada
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: date)

        // Esconde o calendário após a seleção
        calendarContainerView.isHidden = true
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})

