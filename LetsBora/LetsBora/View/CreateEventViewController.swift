import UIKit

class CreateEventViewController: UIViewController {
    
    //MARK: - UIComponents
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar Evento"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    } ()
    
    private lazy var nameEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome do evento"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    } ()
    
    private lazy var descriptionEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Descrição"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return textField
    } ()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Selecione uma data"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        dateTextField.resignFirstResponder() // Esconde o teclado
    }
    
    lazy var stackView: UIStackView = createStackView(
        subViews: [
            titleLabel,
            nameEventTextField,
            descriptionEventTextField,
            dateTextField],
        spacing: 16)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        // Configurando o DatePicker como inputView do TextField
        dateTextField.inputView = datePicker
            
        // Criando uma Toolbar com botão "Concluído"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
            
        let doneButton = UIBarButtonItem(title: "Concluído", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
            
        // Adicionando a toolbar ao teclado do TextField
        dateTextField.inputAccessoryView = toolbar
        setupLayout()
    }
    
    //MARK: - Setup View
    private func setupLayout() {
        view.addSubview(stackView)
        setConstraints()
        
    }
        
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            // Position stack view at the top of safe area with 16pt horizontal margins
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createStackView(subViews: [UIView], spacing: CGFloat = 8) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: subViews)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = spacing
            return stackView
        }
        
    }
    
    // MARK: - Preview Profile
    @available(iOS 17.0,*)
    #Preview(traits: .portrait, body: {
        CreateEventViewController()
    })
